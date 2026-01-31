const mongoose = require("mongoose");
const Message = require("./chat.model");

exports.sendMessage = async (req, res) => {
  try {
    const { senderId, receiverId, text } = req.body;
    if (!senderId || !receiverId || !text || !text.trim()) {
      return res.status(200).json({ status: false, message: "senderId, receiverId and text are required." });
    }

    const message = new Message({
      senderId,
      receiverId,
      text: text.trim(),
    });
    await message.save();

    const populated = await Message.findById(message._id)
      .populate("senderId", "firstName lastName image")
      .populate("receiverId", "firstName lastName image");

    return res.status(200).json({
      status: true,
      message: "Message sent.",
      data: populated,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};

exports.getConversations = async (req, res) => {
  try {
    const userId = req.query.userId;
    if (!userId) {
      return res.status(200).json({ status: false, message: "userId is required." });
    }

    const userObjId = new mongoose.Types.ObjectId(userId);
    const messages = await Message.aggregate([
      { $match: { $or: [{ senderId: userObjId }, { receiverId: userObjId }] } },
      { $sort: { createdAt: -1 } },
      {
        $group: {
          _id: {
            $cond: [
              { $eq: ["$senderId", userObjId] },
              "$receiverId",
              "$senderId",
            ],
          },
          lastMessage: { $first: "$text" },
          lastMessageAt: { $first: "$createdAt" },
          unreadCount: {
            $sum: {
              $cond: [
                {
                  $and: [
                    { $eq: ["$receiverId", userObjId] },
                    { $eq: ["$read", false] },
                  ],
                },
                1,
                0,
              ],
            },
          },
        },
      },
      {
        $lookup: {
          from: "users",
          localField: "_id",
          foreignField: "_id",
          as: "user",
        },
      },
      { $unwind: "$user" },
      {
        $project: {
          _id: 1,
          lastMessage: 1,
          lastMessageAt: 1,
          unreadCount: 1,
          "user._id": 1,
          "user.firstName": 1,
          "user.lastName": 1,
          "user.image": 1,
        },
      },
      { $sort: { lastMessageAt: -1 } },
      { $limit: 50 },
    ]);

    return res.status(200).json({
      status: true,
      message: "Conversations retrieved.",
      data: messages,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};

exports.getMessages = async (req, res) => {
  try {
    const { userId, otherUserId } = req.query;
    if (!userId || !otherUserId) {
      return res.status(200).json({ status: false, message: "userId and otherUserId are required." });
    }

    const messages = await Message.find({
      $or: [
        { senderId: userId, receiverId: otherUserId },
        { senderId: otherUserId, receiverId: userId },
      ],
    })
      .sort({ createdAt: 1 })
      .populate("senderId", "firstName lastName image")
      .populate("receiverId", "firstName lastName image")
      .limit(100);

    await Message.updateMany(
      { senderId: otherUserId, receiverId: userId, read: false },
      { $set: { read: true } }
    );

    return res.status(200).json({
      status: true,
      message: "Messages retrieved.",
      data: messages,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};
