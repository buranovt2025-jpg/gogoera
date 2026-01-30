const LiveSeller = require("./liveSeller.model");

//import model
const User = require("../user/user.model");
const Seller = require("../seller/seller.model");
const LiveSellingHistory = require("../liveSellingHistory/liveSellingHistory.model");
const Follower = require("../follower/follower.model");
const Product = require("../product/product.model");

//momemt
const moment = require("moment");

//mongoose
const mongoose = require("mongoose");

//private key
const admin = require("../../util/privateKey");

const liveSellerFunction = async (liveSeller, data) => {
  liveSeller.firstName = data.firstName;
  liveSeller.lastName = data.lastName;
  liveSeller.businessName = data.businessName;
  liveSeller.businessTag = data.businessTag;
  liveSeller.image = data.image;
  liveSeller.channel = data.channel;
  liveSeller.sellerId = data._id;

  await liveSeller.save();
  return liveSeller;
};

//live the seller for live Selling
exports.liveSeller = async (req, res) => {
  try {
    if (!req.body.sellerId) {
      return res.status(200).json({ status: false, message: "Oops ! Invalid details!" });
    }

    const sellerId = new mongoose.Types.ObjectId(req.body.sellerId);

    const [seller, SelectedProducts, existLiveSeller, follower] = await Promise.all([
      Seller.findById(sellerId),
      Product.find({ seller: sellerId, isSelect: true }).select("mainImage productName price seller isSelect attributes"),
      LiveSeller.findOne({ sellerId: sellerId }),
      Follower.find({ sellerId: sellerId }).distinct("userId"),
    ]);

    console.log("SelectedProducts in liveSeller API ============", SelectedProducts.length);

    if (!seller) {
      return res.status(200).json({ status: false, message: "Seller does not found!" });
    }

    if (existLiveSeller) {
      console.log("delete existLiveSeller");
      await LiveSeller.deleteOne({ sellerId: seller._id });
    }

    //when seller is live then create liveSeller's history
    const liveSellingHistory = new LiveSellingHistory();

    liveSellingHistory.sellerId = seller._id;
    liveSellingHistory.startTime = moment(new Date()).format("HH:mm:ss");

    seller.isLive = true;
    seller.channel = liveSellingHistory._id.toString();
    seller.liveSellingHistoryId = liveSellingHistory._id;

    await Promise.all([liveSellingHistory.save(), seller.save()]);

    let liveSellerData;
    const liveSeller = new LiveSeller();

    liveSeller.liveSellingHistoryId = liveSellingHistory._id;
    liveSeller.agoraUID = req?.body?.agoraUID;
    liveSeller.selectedProducts = SelectedProducts;

    liveSellerData = await liveSellerFunction(liveSeller, seller);

    const data = await LiveSeller.findOne({ _id: liveSeller._id });

    res.status(200).json({
      status: true,
      message: "Seller is live Successfully!",
      liveseller: data,
    });

    const user = await User.find({
      _id: { $in: follower },
      isBlock: false,
      isSeller: false,
    }).distinct("fcmToken");

    console.log("notification to users when seller is live for liveSelling: ", user.length);

    if (user.length !== 0) {
      const adminPromise = await admin;

      const payload = {
        notification: {
          title: `${seller?.firstName} is live now! 🚀✨`,
          body: "📺 Tap to join the stream and watch live! 🎥👀",
          image: seller?.image,
        },
        data: {
          _id: seller._id.toString(),
          firstName: seller.firstName.toString(),
          lastName: seller.lastName.toString(),
          image: seller.image.toString(),
          channel: seller.channel.toString(),
          liveSellingHistoryId: liveSellerData.liveSellingHistoryId.toString(),
          view: liveSellerData.view.toString(),
          type: "LIVE",
        },
      };

      const message = {
        tokens: user,
        notification: payload.notification,
        data: payload.data,
      };

      adminPromise
        .messaging()
        .sendEachForMulticast(message)
        .then((response) => {
          console.log("Successfully sent with response: ", response);

          if (response.failureCount > 0) {
            response.responses.forEach((res, index) => {
              if (!res.success) {
                console.error(`Error for token ${user[index]}:`, res.error.message);
              }
            });
          }
        })
        .catch((error) => {
          console.log("Error sending message:      ", error);
        });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};

//get live seller list
exports.getliveSellerList = async (req, res) => {
  try {
    if (!req.query.start || !req.query.limit) {
      return res.status(200).json({ status: false, message: "Oops ! Invalid details!" });
    }

    const start = req.query.start ? parseInt(req.query.start) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit) : 20;

    const [fakeLiveSeller, liveSeller] = await Promise.all([
      Seller.aggregate([
        {
          $match: {
            isFake: true,
            isBlock: false,
            isLive: true,
          },
        },
        {
          $project: {
            _id: 1,
            image: 1,
            isLive: 1,
            firstName: 1,
            lastName: 1,
            image: 1,
            businessTag: 1,
            businessName: 1,
            email: 1,
            mobileNumber: 1,
            isFake: 1,
            video: 1,
          },
        },
        {
          $addFields: {
            selectedProducts: [],
            liveSellingHistoryId: null,
            view: {
              $floor: {
                $add: [
                  30,
                  {
                    $multiply: [
                      {
                        $subtract: [100, 6],
                      },
                      {
                        $rand: {},
                      },
                    ],
                  },
                ],
              },
            },
          },
        },
        { $skip: (start - 1) * limit },
        { $limit: limit },
      ]),
      Seller.aggregate([
        {
          $match: {
            isBlock: false,
            isLive: true,
          },
        },
        {
          $lookup: {
            from: "livesellers",
            let: { liveSellerId: "$_id" },
            pipeline: [
              {
                $match: {
                  $expr: {
                    $eq: ["$$liveSellerId", "$sellerId"],
                  },
                },
              },
            ],
            as: "liveseller",
          },
        },
        {
          $unwind: {
            path: "$liveseller",
            preserveNullAndEmptyArrays: false,
          },
        },
        {
          $project: {
            _id: 1,
            image: 1,
            isLive: 1,
            firstName: 1,
            lastName: 1,
            image: 1,
            businessTag: 1,
            businessName: 1,
            email: 1,
            mobileNumber: 1,
            isFake: 1,
            video: 1,
            selectedProducts: "$liveseller.selectedProducts",
            liveSellingHistoryId: {
              $cond: [{ $eq: ["$isLive", true] }, "$liveseller.liveSellingHistoryId", null],
            },
            view: {
              $cond: [{ $eq: ["$isLive", true] }, "$liveseller.view", 0],
            },
          },
        },
        { $skip: (start - 1) * limit },
        { $limit: limit },
      ]),
    ]);

    if (settingJSON.isFakeData) {
      return res.status(200).json({
        status: true,
        message: "Retrive live seller list!",
        liveSeller: [...liveSeller, ...fakeLiveSeller],
      });
    } else {
      return res.status(200).json({
        status: true,
        message: "Retrive live seller list!",
        liveSeller: liveSeller,
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};

//get selectedProducts for the user
exports.getSelectedProducts = async (req, res) => {
  try {
    if (!req.query.liveSellingHistoryId) {
      return res.status(200).json({ status: false, message: "liveSellingHistoryId must be requried!" });
    }

    const liveSellingHistory = await LiveSeller.findOne({ liveSellingHistoryId: req.query.liveSellingHistoryId }).select("firstName lastName businessName businessTag image selectedProducts").lean();
    if (!liveSellingHistory) {
      return res.status(200).json({ status: false, message: "liveSellingHistoryId does not found!" });
    }

    return res.status(200).json({
      status: true,
      message: "Retrive selectedProducts for the user!",
      data: liveSellingHistory,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};
