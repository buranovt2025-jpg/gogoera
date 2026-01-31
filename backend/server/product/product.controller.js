const Product = require("./product.model");

//mongoose
const mongoose = require("mongoose");

//fs
const fs = require("fs");

//import model
const Category = require("../category/category.model");
const User = require("../user/user.model");
const Rating = require("../rating/rating.model");
const Seller = require("../seller/seller.model");
const SubCategory = require("../subCategory/subCategory.model");
const ProductRequest = require("../productRequest/productRequest.model");
const Reel = require("../reel/reel.model");
const Cart = require("../cart/cart.model");
const Order = require("../order/order.model");
const Favorite = require("../favorite/favorite.model");
const Review = require("../review/review.model");
const LikeHistoryOfReel = require("../likeHistoryOfReel/likeHistoryOfReel.model");

//deleteFiles
const { deleteFiles } = require("../../util/deleteFile");

//import config
const Config = require("../../config");

//add product by seller
exports.createProduct = async (req, res) => {
  try {
    if (
      !req.body.productName ||
      !req.body.description ||
      !req.body.price ||
      !req.body.category ||
      !req.body.subCategory ||
      !req.body.sellerId ||
      !req.body.shippingCharges ||
      !req.body.productCode ||
      !req.body.attributes ||
      !req.files
    ) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "Oops ! Invalid deatils." });
    }

    const [category, subCategory, seller] = await Promise.all([Category.findById(req.body.category), SubCategory.findById(req.body.subCategory), Seller.findById(req.body.sellerId)]);

    if (!category) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "category does not found." });
    }

    if (!subCategory) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "subCategory does not found." });
    }

    if (!seller) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "seller does not found." });
    }

    if (global.settingJSON.isAddProductRequest) {
      const existProduct = await Product.findOne({ seller: seller._id, productCode: req.body.productCode });
      if (existProduct) {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({
          status: false,
          message: "Product with the same product code already exists.",
          product: existProduct,
        });
      }

      if (existProduct?.createStatus === "Pending") {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({
          status: true,
          message: "You have already sent a request to admin for create the product.",
          createStatus: existProduct.createStatus,
          request: existProduct,
        });
      }

      if (existProduct?.createStatus === "Approved") {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({
          status: false,
          message: "product request already has been accepted for create the product.",
          createStatus: existProduct.createStatus,
          request: existProduct,
        });
      }

      const product = new Product();

      product.productName = req.body.productName.trim();
      product.description = req.body.description.trim();
      product.price = req.body.price || 0;
      product.category = category._id;
      product.subCategory = subCategory._id;
      product.seller = seller._id;
      product.createStatus = "Pending";
      product.shippingCharges = req.body.shippingCharges || 0;
      product.productCode = req.body.productCode;
      product.date = new Date().toLocaleString("en-US", { timeZone: "Asia/Kolkata" });

      if (req.files.mainImage) {
        product.mainImage = Config.baseURL + req.files.mainImage[0].path;
      }

      if (req.files.images) {
        const imagesData = [];
        await req.files.images.map((data) => {
          imagesData.push(Config.baseURL + data.path);
        });
        product.images = imagesData;
      }

      if (req.body.attributes) {
        console.log("type: ", typeof req.body.attributes);

        let attributes;

        if (typeof req.body.attributes === "string") {
          attributes = JSON.parse(req.body.attributes);
        } else if (typeof req.body.attributes === "object") {
          attributes = req.body.attributes;
        } else {
          if (req.files) deleteFiles(req.files);
          return res.status(200).json({
            status: false,
            message: "Invalid attributes format",
          });
        }

        if (Array.isArray(attributes)) {
          product.attributes = attributes.map((attr) => ({
            name: attr.name,
            value: Array.isArray(attr.value) ? attr.value.map(String) : [attr.value.toString()],
          }));
        } else {
          console.log("req.body.attributes is not an array.");
        }
      }

      console.log("product.attributes: ", product.attributes);

      await product.save();

      const product_ = await Product.findById(product._id).populate([
        { path: "category", select: "name" },
        { path: "subCategory", select: "name" },
        {
          path: "seller",
          select: "firstName lastName businessTag businessName image",
        },
      ]);

      return res.status(200).json({
        status: true,
        message: "Product request created by seller to admin.",
        product: product_,
      });
    } else {
      const existProduct = await Product.findOne({ seller: seller._id, productCode: req.body.productCode });
      if (existProduct) {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({
          status: false,
          message: "Product with the same product code already exists.",
          product: existProduct,
        });
      }

      const product = new Product();

      product.productName = req.body.productName.trim();
      product.description = req.body.description.trim();
      product.price = req.body.price || 0;
      product.category = category._id;
      product.subCategory = subCategory._id;
      product.seller = seller._id;
      product.createStatus = "Approved";
      product.shippingCharges = req.body.shippingCharges || 0;
      product.productCode = req.body.productCode;
      product.date = new Date().toLocaleString("en-US", { timeZone: "Asia/Kolkata" });

      if (req.files.mainImage) {
        product.mainImage = Config.baseURL + req.files.mainImage[0].path;
      }

      if (req.files.images) {
        const imagesData = [];
        await req.files.images.map((data) => {
          imagesData.push(Config.baseURL + data.path);
        });
        product.images = imagesData;
      }

      if (req.body.attributes) {
        console.log("type: ", typeof req.body.attributes);

        let attributes;

        if (typeof req.body.attributes === "string") {
          attributes = JSON.parse(req.body.attributes);
        } else if (typeof req.body.attributes === "object") {
          attributes = req.body.attributes;
        } else {
          if (req.files) deleteFiles(req.files);
          return res.status(200).json({
            status: false,
            message: "Invalid attributes format",
          });
        }

        if (Array.isArray(attributes)) {
          product.attributes = attributes.map((attr) => ({
            name: attr.name,
            value: Array.isArray(attr.value) ? attr.value.map(String) : [attr.value.toString()],
          }));
        } else {
          console.log("req.body.attributes is not an array.");
        }
      }

      console.log("product.attributes: ", product.attributes);

      await product.save();

      const product_ = await Product.findById(product._id).populate([
        { path: "category", select: "name" },
        { path: "subCategory", select: "name" },
        {
          path: "seller",
          select: "firstName lastName businessTag businessName image",
        },
      ]);

      return res.status(200).json({
        status: true,
        message: "isAddProductRequest is false by admin then directly product added by the seller.",
        product: product_,
      });
    }
  } catch (error) {
    if (req.files) deleteFiles(req.files);
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//create product request accept or decline by admin
exports.acceptCreateRequest = async (req, res) => {
  try {
    if (!req.query.productId) {
      return res.status(200).json({ status: false, message: "productId must be requried." });
    }

    const product = await Product.findById(req.query.productId);
    if (!product) {
      return res.status(200).json({ status: false, message: "product does not found." });
    }

    if (product.createStatus === "Approved") {
      return res.status(200).json({
        status: false,
        message: "product request already accepted by the admin for create the product.",
      });
    }

    if (req.query.type === "Approved") {
      product.createStatus = "Approved";
      await product.save();

      return res.status(200).json({
        status: true,
        message: "Product request accepted by the admin.",
        product: product,
      });
    } else if (req.query.type === "Rejected") {
      product.createStatus = "Rejected";
      await product.save();

      //await Product.findByIdAndDelete(product._id);

      return res.status(200).json({
        status: true,
        message: "Product request rejected by the admin for create the product.",
        product: product,
      });
    } else {
      return res.status(200).json({ status: false, message: "type must be passed valid." });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//get status wise all product requests to create product for admin
exports.createProductRequestStatusWise = async (req, res) => {
  try {
    if (!req.query.status) {
      return res.status(200).json({ status: true, message: "Oops ! Invalid details." });
    }

    let statusQuery = {};
    if (req.query.status === "Pending") {
      statusQuery = { createStatus: "Pending" };
    } else if (req.query.status === "Approved") {
      statusQuery = { createStatus: "Approved" };
    } else if (req.query.status === "Rejected") {
      statusQuery = { createStatus: "Rejected" };
    } else if (req.query.status === "All") {
      statusQuery = {
        createStatus: {
          $in: ["Pending", "Approved", "Rejected"],
        },
      };
    } else {
      return res.status(200).json({ status: false, message: "status must be passed valid" });
    }

    const products = await Product.find(statusQuery);

    return res.status(200).json({
      status: true,
      message: `Retrive products with status ${req.query.status}`,
      products,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//add product by admin
exports.createProductByAdmin = async (req, res) => {
  try {
    if (
      !req.body.productName ||
      !req.body.description ||
      !req.body.price ||
      !req.body.category ||
      !req.body.subCategory ||
      !req.body.sellerId ||
      !req.body.shippingCharges ||
      !req.body.productCode ||
      !req.body.attributes ||
      !req.files
    ) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "Oops ! Invalid deatils!!" });
    }

    const [category, subCategory, seller] = await Promise.all([Category.findById(req.body.category), SubCategory.findById(req.body.subCategory), Seller.findById(req.body.sellerId)]);

    if (!category) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "category does not found!!" });
    }

    if (!subCategory) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "subCategory does not found!!" });
    }

    if (!seller) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "seller does not found!!" });
    }

    const existProduct = await Product.findOne({
      seller: seller._id,
      productCode: req.body.productCode,
    });

    if (existProduct) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({
        status: false,
        message: "Product with the same product code already exists!!",
        product: existProduct,
      });
    } else {
      const product = new Product();

      product.productName = req.body.productName;
      product.description = req.body.description;
      product.price = req.body.price || 0;
      product.category = category._id;
      product.subCategory = subCategory._id;
      product.seller = seller._id;
      product.createStatus = "Approved";
      product.isAddByAdmin = true;
      product.shippingCharges = req.body.shippingCharges || 0;
      product.productCode = req.body.productCode;
      product.date = new Date().toLocaleString("en-US", { timeZone: "Asia/Kolkata" });

      if (req.files.mainImage) {
        product.mainImage = Config.baseURL + req.files.mainImage[0].path;
      }

      if (req.files.images) {
        const imagesData = [];
        await req.files.images.map((data) => {
          imagesData.push(Config.baseURL + data.path);
        });
        product.images = imagesData;
      }

      if (req.body.attributes) {
        console.log("type: ", typeof req.body.attributes);

        let attributes;

        if (typeof req.body.attributes === "string") {
          attributes = JSON.parse(req.body.attributes);
        } else if (typeof req.body.attributes === "object") {
          attributes = req.body.attributes;
        } else {
          if (req.files) deleteFiles(req.files);
          return res.status(200).json({
            status: false,
            message: "Invalid attributes format",
          });
        }

        if (Array.isArray(attributes)) {
          product.attributes = attributes.map((attr) => ({
            name: attr.name,
            value: Array.isArray(attr?.value) ? attr?.value.map(String) : [attr?.value?.toString()],
          }));
        } else {
          console.log("req.body.attributes is not an array.");
        }
      }

      console.log("product.attributes: ", product.attributes);

      await product.save();

      const product_ = await Product.findById(product._id).populate([
        { path: "category", select: "name" },
        { path: "subCategory", select: "name" },
        {
          path: "seller",
          select: "firstName lastName businessTag businessName image",
        },
      ]);

      return res.status(200).json({
        status: true,
        message: "Product Added Successfully.",
        product: product_,
      });
    }
  } catch (error) {
    if (req.files) deleteFiles(req.files);
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//update product by admin
exports.updateProduct = async (req, res) => {
  try {
    if (!req.query.productId || !req.query.sellerId || !req.query.productCode) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "Oops ! Invalid details." });
    }

    const productId = new mongoose.Types.ObjectId(req.query.productId);
    const sellerId = new mongoose.Types.ObjectId(req.query.sellerId);
    const productCode = req.query.productCode.trim();

    const [seller, product] = await Promise.all([
      Seller.findById(sellerId),
      Product.findOne({
        _id: productId,
        productCode: productCode,
        seller: sellerId,
        createStatus: "Approved",
      }),
    ]);

    if (!seller) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "seller does not found!!" });
    }

    if (!product) {
      if (req.files) deleteFiles(req.files);
      return res.status(200).json({ status: false, message: "No product Was found." });
    }

    if (req?.body?.category) {
      var category = await Category.findById(req.body.category);
      if (!category) {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({ status: false, message: "category does not found." });
      }
    }

    if (req?.body?.subCategory) {
      var subCategory = await SubCategory.findById(req.body.subCategory);
      if (!subCategory) {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({ status: false, message: "subCategory does not found." });
      }
    }

    product.productName = req.body.productName ? req.body.productName : product.productName;
    product.description = req.body.description ? req.body.description : product.description;
    product.price = req.body.price ? req.body.price : product.price;
    product.shippingCharges = req.body.shippingCharges ? req.body.shippingCharges : product.shippingCharges;
    product.category = req.body.category ? category._id : product.category;
    product.subCategory = req.body.subCategory ? subCategory._id : product.subCategory;
    product.date = new Date().toLocaleString("en-US", { timeZone: "Asia/Kolkata" });
    product.updateStatus = "Approved";
    product.isUpdateByAdmin = true;

    if (req.files.mainImage) {
      const image = product?.mainImage.split("storage");
      if (image) {
        if (fs.existsSync("storage" + image[1])) {
          fs.unlinkSync("storage" + image[1]);
        }
      }

      product.mainImage = Config.baseURL + req.files.mainImage[0].path;
    }

    if (req.files.images) {
      var imagesData = [];

      if (product.images.length > 0) {
        for (var i = 0; i < product.images.length; i++) {
          const images = product.images[i].split("storage");
          if (images) {
            if (fs.existsSync("storage" + images[1])) {
              fs.unlinkSync("storage" + images[1]);
            }
          }
        }
      }

      await req.files.images.map((data) => {
        imagesData.push(Config.baseURL + data.path);
      });

      product.images = imagesData;
    }

    if (req.body.attributes) {
      let attributes;

      if (typeof req.body.attributes === "string") {
        console.log("attributes in body: ", typeof req.body.attributes);

        attributes = JSON.parse(req.body.attributes);
      } else if (typeof req.body.attributes === "object") {
        console.log("attributes in body: ", typeof req.body.attributes);

        attributes = req.body.attributes;
      } else {
        if (req.files) deleteFiles(req.files);
        return res.status(200).json({
          status: false,
          message: "Invalid attributes format",
        });
      }

      if (Array.isArray(attributes)) {
        const updatedAttributes = attributes.map((attr) => {
          if (attr && attr._id) {
            const existingAttribute = product.attributes.find((attribute) => attribute && attribute._id && attribute._id.toString() === attr._id.toString());

            if (existingAttribute) {
              const updatedAttribute = {
                ...existingAttribute,
                name: attr.name || existingAttribute.name,
                value: attr.value || existingAttribute.value,
              };

              return updatedAttribute;
            }
          }

          return attr;
        });

        product.attributes = updatedAttributes;
      } else {
        console.log("req.body.attributes is not an array.");
      }
    }

    await product.save();

    const product_ = await Product.findById(product._id).populate([
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
      {
        path: "seller",
        select: "firstName lastName businessTag businessName image",
      },
    ]);

    return res.status(200).json({
      status: true,
      message: "Product updated Successfully.",
      product: product_,
    });
  } catch (error) {
    if (req.files) deleteFiles(req.files);
    console.log(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error",
    });
  }
};

//get product details for seller
exports.detailforSeller = async (req, res) => {
  try {
    if (!req.query.productId || !req.query.sellerId) {
      return res.status(200).json({ status: false, message: "Oops ! Invalid details." });
    }

    const [product, seller] = await Promise.all([Product.findById(req.query.productId), Seller.findById(req.query.sellerId)]);

    if (!product) {
      return res.status(200).json({
        status: false,
        message: "No product was found!",
      });
    }

    if (!seller) {
      return res.status(200).json({ status: false, message: "seller does not found!" });
    }

    const productData = await Product.find({ _id: product._id, seller: seller._id }).populate([
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
      {
        path: "seller",
        select: "firstName lastName businessTag businessName image",
      },
    ]);

    return res.status(200).json({
      status: true,
      message: "Retrive product details for the seller!",
      product: productData,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      error: error.message || "Internal Server Error",
    });
  }
};

//delete product by seller and admin
exports.deleteProduct = async (req, res) => {
  try {
    if (!req.query.productId) {
      return res.status(200).json({ status: false, message: "productId must be requried!" });
    }

    const productId = new mongoose.Types.ObjectId(req.query.productId);

    const product = await Product.findOne({ _id: productId, createStatus: "Approved" });
    if (!product) {
      return res.status(200).json({ status: false, message: "Product does not found!" });
    }

    res.status(200).json({
      status: true,
      message: "Product has been deleted.",
    });

    if (product.mainImage) {
      const image = product?.mainImage?.split("storage");
      if (image) {
        if (fs.existsSync("storage" + image[1])) {
          fs.unlinkSync("storage" + image[1]);
        }
      }
    }

    if (product.images) {
      if (product.images.length > 0) {
        for (var i = 0; i < product?.images?.length; i++) {
          const images = product?.images[i]?.split("storage");
          if (images) {
            if (fs.existsSync("storage" + images[1])) {
              fs.unlinkSync("storage" + images[1]);
            }
          }
        }
      }
    }

    const [cart, order, favorite, review, rating, productRequest, reels] = await Promise.all([
      Cart.deleteMany({ "items.productId": productId }),
      Order.deleteMany({ "items.productId": productId }),
      Favorite.deleteMany({ productId: productId }),
      Review.deleteMany({ productId: productId }),
      Rating.deleteMany({ productId: productId }),
      ProductRequest.find({ productCode: product?.productCode }),
      Reel.find({ productId: productId }),
    ]);

    if (productRequest.length > 0) {
      await productRequest.forEach(async (product) => {
        if (product.mainImage) {
          const image = product?.mainImage?.split("storage");
          if (image) {
            if (fs.existsSync("storage" + image[1])) {
              fs.unlinkSync("storage" + image[1]);
            }
          }
        }

        if (product.images) {
          if (product.images.length > 0) {
            for (var i = 0; i < product?.images?.length; i++) {
              const images = product?.images[i]?.split("storage");
              if (images) {
                if (fs.existsSync("storage" + images[1])) {
                  fs.unlinkSync("storage" + images[1]);
                }
              }
            }
          }
        }
      });
    }

    if (reels.length > 0) {
      await reels.forEach(async (reel) => {
        if (reel.video) {
          const video = reel?.video?.split("storage");
          if (video) {
            if (fs.existsSync("storage" + video[1])) {
              fs.unlinkSync("storage" + video[1]);
            }
          }
        }

        if (reel.thumbnail) {
          const thumbnail = reel?.thumbnail?.split("storage");
          if (thumbnail) {
            if (fs.existsSync("storage" + thumbnail[1])) {
              fs.unlinkSync("storage" + thumbnail[1]);
            }
          }
        }

        await LikeHistoryOfReel.deleteMany({ reelId: reel._id });
      });
    }

    await Promise.all([ProductRequest.deleteMany({ productCode: product?.productCode }), Reel.deleteMany({ productId: product?._id })]);
    await product.deleteOne();
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//get all products for seller
exports.getAll = async (req, res) => {
  try {
    if (!req.query.start || !req.query.limit || !req.query.sellerId) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details!" });
    }

    const sellerId = new mongoose.Types.ObjectId(req.query.sellerId);

    const start = req.query.start ? parseInt(req.query.start) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit) : 10;

    const query = [
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
      {
        path: "seller",
        select: "firstName lastName businessTag businessName image",
      },
    ];

    const [seller, products] = await Promise.all([
      Seller.findById(sellerId),
      Product.find({ seller: sellerId })
        .populate(query)
        .sort({ createdAt: -1 })
        .skip((start - 1) * limit)
        .limit(limit),
    ]);

    if (!seller) {
      return res.status(200).json({ status: false, message: "Seller does not found." });
    }

    return res.status(200).json({
      status: true,
      message: "Retrive products for the seller",
      products: products,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error",
    });
  }
};

//handle the product is selected or not
exports.selectedOrNot = async (req, res) => {
  try {
    if (!req.query.productId) {
      return res.status(200).json({ status: false, massage: "productId must be requried!" });
    }

    const product = await Product.findById(req.query.productId);
    if (!product) {
      return res.status(200).json({ status: false, message: "product does not found!" });
    }

    product.isSelect = !product.isSelect;
    await product.save();

    return res.status(200).json({
      status: true,
      message: "Success",
      product,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error!!",
    });
  }
};

//get all products selected for seller when seller going for live
exports.getSelectedProducts = async (req, res) => {
  try {
    if (!req.query.sellerId) {
      return res.status(200).json({ status: false, message: "sellerId must be requried!" });
    }

    const sellerId = new mongoose.Types.ObjectId(req.query.sellerId);

    const [seller, totalSelectedProducts, selectedProducts, liveSeller] = await Promise.all([
      Seller.findById(sellerId),
      Product.countDocuments({ isSelect: true, seller: sellerId }),
      Product.find({ isSelect: true, seller: sellerId }).select("mainImage productName price seller isSelect").sort({ createdAt: -1 }),
      Seller.aggregate([
        {
          $match: {
            _id: sellerId,
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
            liveSellingHistoryId: {
              $cond: [{ $eq: ["$isLive", true] }, "$liveseller.liveSellingHistoryId", null],
            },
          },
        },
      ]),
    ]);

    if (!seller) {
      return res.status(200).json({ status: false, message: "seller does not found." });
    }

    return res.status(200).json({
      status: true,
      message: "when seller going for live then finally, get all products selected by the seller!",
      totalSelectedProducts: totalSelectedProducts ? totalSelectedProducts : 0,
      SelectedProducts: selectedProducts.length > 0 ? selectedProducts : [],
      liveSellingHistoryId: liveSeller[0]?.liveSellingHistoryId ? liveSeller[0].liveSellingHistoryId : null,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//get product details for user
exports.productDetail = async (req, res) => {
  try {
    if (!req.query.productId || !req.query.userId) {
      return res.status(200).json({ status: true, message: "Oops ! Invalid details." });
    }

    const productId = new mongoose.Types.ObjectId(req.query.productId);
    const userId = new mongoose.Types.ObjectId(req.query.userId);

    const [product, user, ratingExist] = await Promise.all([
      Product.findOne({ _id: productId, createStatus: "Approved" }),
      User.findOne({ _id: userId, isBlock: false }),
      Rating.findOne({
        userId: userId,
        productId: productId,
      }),
    ]);

    if (!product) {
      return res.status(500).json({ status: false, message: "No product was found." });
    }

    if (!user) {
      return res.status(200).json({ status: false, message: "User does not found." });
    }

    const seller = await Seller.findById(product.seller);
    if (!seller) {
      return res.status(200).json({ status: false, message: "seller of this product does not found." });
    }

    const data = await Product.aggregate([
      { $match: { _id: product._id } },
      { $addFields: { isRating: ratingExist ? true : false } },
      {
        $lookup: {
          from: "ratings",
          let: {
            product: product._id,
          },
          pipeline: [
            {
              $match: {
                $expr: { $eq: ["$$product", "$productId"] },
              },
            },
            {
              $group: {
                _id: "$productId",
                totalUser: { $sum: 1 }, //totalRating by user
                avgRating: { $avg: "$rating" },
              },
            },
          ],
          as: "rating",
        },
      },
      {
        $lookup: {
          from: "followers",
          let: {
            sellerId: seller._id,
          },
          pipeline: [
            {
              $match: {
                $expr: {
                  $and: [{ $eq: ["$sellerId", seller._id] }],
                },
              },
            },
          ],
          as: "isFollow",
        },
      },
      {
        $lookup: {
          from: "favorites",
          let: {
            productId: "$_id",
            userId: user._id,
          },
          pipeline: [
            {
              $match: {
                $expr: {
                  $and: [{ $eq: ["$productId", "$$productId"] }, { $eq: ["$userId", user._id] }],
                },
              },
            },
          ],
          as: "isFavorite",
        },
      },
      {
        $lookup: {
          from: "categories",
          localField: "category",
          foreignField: "_id",
          as: "category",
        },
      },
      {
        $unwind: { path: "$category", preserveNullAndEmptyArrays: true },
      },
      {
        $lookup: {
          from: "subcategories",
          localField: "subCategory",
          foreignField: "_id",
          as: "subCategory",
        },
      },
      {
        $unwind: { path: "$subCategory", preserveNullAndEmptyArrays: true },
      },
      {
        $lookup: {
          from: "sellers",
          localField: "seller",
          foreignField: "_id",
          as: "seller",
        },
      },
      {
        $unwind: { path: "$seller", preserveNullAndEmptyArrays: true },
      },
      {
        $project: {
          mainImage: 1,
          images: 1,
          price: 1,
          shippingCharges: 1,
          productName: 1,
          productCode: 1,
          attributes: 1,
          location: 1,
          sold: 1,
          review: 1,
          isOutOfStock: 1,
          isNewCollection: 1,
          description: 1,
          rating: 1,
          createStatus: 1,
          updateStatus: 1,
          category: {
            _id: 1,
            name: 1,
          },
          subCategory: {
            _id: 1,
            name: 1,
          },
          seller: {
            _id: 1,
            userId: 1,
            firstName: 1,
            lastName: 1,
            businessTag: 1,
            businessName: 1,
            image: 1,
            "address.city": 1,
            "address.state": 1,
            "address.country": 1,
          },
          isFollow: {
            $cond: [{ $eq: [{ $size: "$isFollow" }, 0] }, false, true],
          },
          isFavorite: {
            $cond: [{ $eq: [{ $size: "$isFavorite" }, 0] }, false, true],
          },
        },
      },
    ]);

    return res.status(200).json({
      status: true,
      message: "Product details Retrive Successfully.",
      product: data,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};

//get product details for admin
exports.productDetails = async (req, res) => {
  try {
    if (!req.query.productId) {
      return res.status(200).json({ status: true, message: "Oops ! Invalid details!!" });
    }

    const product = await Product.findById(req.query.productId);
    if (!product) {
      return res.status(500).json({ status: false, message: "No product was found." });
    }

    const [seller, data] = await Promise.all([
      Seller.findById(product.seller),
      Product.aggregate([
        { $match: { _id: product._id } },
        {
          $lookup: {
            from: "ratings",
            let: {
              product: product._id,
            },
            pipeline: [
              {
                $match: {
                  $expr: { $eq: ["$$product", "$productId"] },
                },
              },
              {
                $group: {
                  _id: "$productId",
                  totalUser: { $sum: 1 }, //totalRating by user
                  avgRating: { $avg: "$rating" },
                },
              },
            ],
            as: "rating",
          },
        },
        {
          $lookup: {
            from: "categories",
            localField: "category",
            foreignField: "_id",
            as: "category",
          },
        },
        {
          $unwind: { path: "$category", preserveNullAndEmptyArrays: true },
        },
        {
          $lookup: {
            from: "subcategories",
            localField: "subCategory",
            foreignField: "_id",
            as: "subCategory",
          },
        },
        {
          $unwind: { path: "$subCategory", preserveNullAndEmptyArrays: true },
        },
        {
          $lookup: {
            from: "sellers",
            localField: "seller",
            foreignField: "_id",
            as: "seller",
          },
        },
        {
          $unwind: { path: "$seller", preserveNullAndEmptyArrays: true },
        },
        {
          $project: {
            mainImage: 1,
            images: 1,
            price: 1,
            shippingCharges: 1,
            productName: 1,
            location: 1,
            sold: 1,
            review: 1,
            isOutOfStock: 1,
            description: 1,
            rating: 1,
            createStatus: 1,
            updateStatus: 1,
            productCode: 1,
            attributes: 1,
            category: {
              _id: 1,
              name: 1,
            },
            subCategory: {
              _id: 1,
              name: 1,
            },
            seller: {
              _id: 1,
              firstName: 1,
              lastName: 1,
              businessTag: 1,
              businessName: 1,
              image: 1,
            },
          },
        },
      ]),
    ]);

    if (!seller) {
      return res.status(200).json({ status: false, message: "seller of this product does not found." });
    }

    return res.status(200).json({
      status: true,
      message: "Product details Retrive Successfully.",
      product: data,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      error: error.message || "Internal Server Error",
    });
  }
};

//get category wise all products for user (gallery page)
exports.getProductsForUser = async (req, res) => {
  try {
    if (!req.query.userId || !req.query.categoryId || !req.query.start || !req.query.limit) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const start = req.query.start ? parseInt(req.query.start) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit) : 10;

    const userId = new mongoose.Types.ObjectId(req.query.userId);
    const categoryId = new mongoose.Types.ObjectId(req.query.categoryId);

    const [user, userIsSeller, category, data] = await Promise.all([
      User.findById(userId),
      Seller.findOne({ userId: userId }).lean(),
      Category.findById(categoryId),
      Product.aggregate([
        {
          $match: {
            category: categoryId,
            createStatus: "Approved",
          },
        },
        {
          $lookup: {
            from: "favorites",
            let: {
              productId: "$_id",
              userId: userId,
            },
            pipeline: [
              {
                $match: {
                  $expr: {
                    $and: [{ $eq: ["$productId", "$$productId"] }, { $eq: ["$userId", userId] }],
                  },
                },
              },
            ],
            as: "isFavorite",
          },
        },
        {
          $project: {
            seller: 1,
            productName: 1,
            productCode: 1,
            description: 1,
            price: 1,
            review: 1,
            mainImage: 1,
            images: 1,
            shippingCharges: 1,
            quantity: 1,
            sold: 1,
            isOutOfStock: 1,
            category: 1,
            subCategory: 1,
            rating: 1,
            createStatus: 1,
            updateStatus: 1,
            isFavorite: {
              $cond: [{ $eq: [{ $size: "$isFavorite" }, 0] }, false, true],
            },
          },
        },
        {
          $project: {
            createdAt: 0,
            updatedAt: 0,
            __v: 0,
          },
        },
        { $skip: (start - 1) * limit }, //how many records you want to skip
        { $limit: limit },
      ]),
    ]);

    if (!user) {
      return res.status(200).json({ status: false, message: "User does not found." });
    }

    if (!category) {
      return res.status(200).json({ status: false, message: "category does not found." });
    }

    const filteredProducts = data.filter((product) => !userIsSeller || product.seller.toString() !== userIsSeller._id.toString());

    const data_ = await Product.populate(filteredProducts, [
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
    ]);

    return res.status(200).json({
      status: true,
      message: "Retrive category wise products Successfully.",
      product: data_ || [],
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: true,
      error: error.message || "Internal Server Error",
    });
  }
};

//search products for user
exports.search = async (req, res) => {
  try {
    if (!req.query.productName || !req.query.userId) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const userId = new mongoose.Types.ObjectId(req.query.userId);

    const query = [
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
    ];

    if (req.query.productName) {
      const [userIsSeller, response, results] = await Promise.all([
        Seller.findOne({ userId: userId }).lean(),
        Product.find({
          createStatus: "Approved",
          productName: { $regex: req.query.productName?.trim(), $options: "i" },
        }).populate(query),
        Product.updateMany(
          {
            createStatus: "Approved",
            productName: { $regex: req.query.productName?.trim(), $options: "i" },
          },
          { $inc: { searchCount: 1 } }
        ), //increment the searchCount for the matched products
      ]);

      const filteredProducts = response.filter((product) => !userIsSeller || product.seller.toString() !== userIsSeller._id.toString());

      return res.status(200).json({ status: true, message: "Success", products: filteredProducts });
    } else if (req.query.productName === "") {
      return res.status(200).json({ status: true, message: "No data found.", products: [] });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      error: error.message || "Internal Server Error",
    });
  }
};

//previous search products for user
exports.searchProduct = async (req, res) => {
  try {
    const matchQuery = { createStatus: "Approved" };

    const [lastSearchedProducts, popularSearchedProducts] = await Promise.all([
      Product.find(matchQuery)
        .select("-attributes")
        .sort({ updatedAt: -1 }) //Sort by most recently updated
        .limit(5),
      Product.find(matchQuery)
        .select("-attributes")
        .sort({ searchCount: -1 }) //Sort by searchCount
        .limit(5),
    ]);

    return res.status(200).json({
      status: true,
      message: "Success",
      products: {
        lastSearchedProducts,
        popularSearchedProducts,
      },
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error",
    });
  }
};

//get all products filterWise for user
exports.filterWiseProduct = async (req, res) => {
  try {
    if (!req.query.userId) {
      return res.status(200).json({ status: true, message: "userId must be requried." });
    }

    if (!req.body.category || !req.body.subCategory || !req.body.minPrice || !req.body.maxPrice)
      return res.status(200).json({
        status: false,
        message: "OOps ! Invalid details.",
      });

    const userId = new mongoose.Types.ObjectId(req.query.userId);

    //category filter
    let categoryArray = [];
    if (req.body?.category) {
      if (Array.isArray(req.body.category)) {
        categoryArray = req.body.category.map((id) => new mongoose.Types.ObjectId(id));
      } else {
        categoryArray = [new mongoose.Types.ObjectId(req.body.category)];
      }
    }

    const categoryQuery = categoryArray?.length > 0 ? { category: { $in: categoryArray } } : {};

    //subCategory filter
    let subCategoryArray = [];
    if (req.body?.subCategory) {
      if (Array.isArray(req.body.subCategory)) {
        subCategoryArray = req.body.subCategory.map((id) => new mongoose.Types.ObjectId(id));
      } else {
        subCategoryArray = [new mongoose.Types.ObjectId(req.body.subCategory)];
      }
    }

    const subCategoryQuery = subCategoryArray?.length > 0 ? { subCategory: { $in: subCategoryArray } } : {};

    //priceQuery filter
    const priceQuery = {};
    if (req.body.minPrice) {
      priceQuery.price = { $gte: req.body.minPrice };
    }

    if (req.body.maxPrice) {
      priceQuery.price = {
        ...priceQuery.price,
        $lte: req.body.maxPrice,
      };
    }

    const query = {
      $and: [categoryQuery, subCategoryQuery, priceQuery],
    };

    const matchQuery = { createStatus: "Approved" };

    const [user, userIsSeller, product] = await Promise.all([
      User.findOne({ _id: userId, isBlock: false }),
      Seller.findOne({ userId: userId }).lean(),
      Product.aggregate([
        {
          $match: {
            $and: [matchQuery, ...query.$and],
          },
        },
        {
          $lookup: {
            from: "favorites",
            let: {
              productId: "$_id",
              userId: userId,
            },
            pipeline: [
              {
                $match: {
                  $expr: {
                    $and: [{ $eq: ["$productId", "$$productId"] }, { $eq: ["$userId", userId] }],
                  },
                },
              },
            ],
            as: "isFavorite",
          },
        },
        {
          $lookup: {
            from: "ratings",
            localField: "_id",
            foreignField: "productId",
            as: "productRating",
          },
        },
        {
          $project: {
            _id: 1,
            mainImage: 1,
            images: 1,
            price: 1,
            shippingCharges: 1,
            productName: 1,
            productCode: 1,
            location: 1,
            sold: 1,
            review: 1,
            isOutOfStock: 1,
            description: 1,
            category: 1,
            seller: 1,
            createStatus: 1,
            isFavorite: {
              $cond: [{ $eq: [{ $size: "$isFavorite" }, 0] }, false, true],
            },
            ratingAverage: {
              $cond: {
                if: { $eq: [{ $avg: "$productRating.rating" }, null] },
                then: { $avg: 0 },
                else: { $avg: "$productRating.rating" },
              },
            },
          },
        },
      ]),
    ]);

    if (!user) {
      return res.status(200).json({ status: false, message: "User does not found." });
    }

    const filteredProducts = product.filter((product) => !userIsSeller || product.seller.toString() !== userIsSeller._id.toString());

    return res.status(200).json({
      status: true,
      message: "Retrive Filter wise products Successfully!",
      product: filteredProducts.length > 0 ? filteredProducts : [],
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      message: "Internal Server Error",
    });
  }
};

//handle the isOutofStock or not for admin
exports.isOutOfStock = async (req, res) => {
  try {
    if (!req.query.productId) {
      return res.status(200).json({ status: false, massage: "productId must be requried!" });
    }

    const product = await Product.findById(req.query.productId).populate("seller", "firstName lastName image").populate("category", "name").populate("subCategory", "name");
    if (!product) {
      return res.status(200).json({ status: false, message: "product does not found!" });
    }

    product.isOutOfStock = !product.isOutOfStock;
    await product.save();

    return res.status(200).json({
      status: true,
      message: "Success",
      product,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      error: error.message || "Internal Server Error!",
    });
  }
};

//handle the isNewCollection or not for admin
exports.isNewCollection = async (req, res) => {
  try {
    if (!req.query.productId) {
      return res.status(200).json({ status: false, massage: "productId must be requried!!" });
    }

    const product = await Product.findById(req.query.productId).populate("seller", "firstName lastName image").populate("category", "name").populate("subCategory", "name");
    if (!product) {
      return res.status(200).json({ status: false, message: "product does not found!!" });
    }

    product.isNewCollection = !product.isNewCollection;
    await product.save();

    return res.status(200).json({
      status: true,
      message: "Success",
      product,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      error: error.message || "Internal Server Error",
    });
  }
};

//get all new collection for user (home page)
exports.getAllisNewCollection = async (req, res) => {
  try {
    if (!req.query.userId) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const userId = new mongoose.Types.ObjectId(req.query.userId);

    const [user, userIsSeller, products] = await Promise.all([
      User.findById(userId),
      Seller.findOne({ userId: userId }).lean(),
      Product.aggregate([
        {
          $match: {
            isNewCollection: true,
          },
        },
        {
          $lookup: {
            from: "favorites",
            let: {
              productId: "$_id",
              userId: userId,
            },
            pipeline: [
              {
                $match: {
                  $expr: {
                    $and: [{ $eq: ["$productId", "$$productId"] }, { $eq: ["$userId", userId] }],
                  },
                },
              },
            ],
            as: "isFavorite",
          },
        },
        {
          $project: {
            seller: 1,
            mainImage: 1,
            images: 1,
            price: 1,
            shippingCharges: 1,
            productName: 1,
            location: 1,
            sold: 1,
            review: 1,
            isOutOfStock: 1,
            isNewCollection: 1,
            description: 1,
            category: 1,
            seller: 1,
            rating: 1,
            status: 1,
            isApproved: 1,
            productCode: 1,
            attributes: 1,
            isFavorite: {
              $cond: [{ $eq: [{ $size: "$isFavorite" }, 0] }, false, true],
            },
          },
        },
        { $sort: { createdAt: -1 } },
      ]),
    ]);

    if (!user) {
      return res.status(200).json({ status: false, message: "User does not found." });
    }

    if (user.isBlock) {
      return res.status(200).json({ status: false, message: "You are blocked by admin!" });
    }

    const filteredProducts = products.filter((product) => !userIsSeller || product.seller.toString() !== userIsSeller._id.toString());

    return res.status(200).json({
      status: true,
      message: "Success",
      products: filteredProducts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, error: error.message || "Internal Server Error" });
  }
};

//get real products for admin
exports.getRealProducts = async (req, res) => {
  try {
    if (!req.query.start || !req.query.limit) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const start = req.query.start ? parseInt(req.query.start) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit) : 10;

    const query = [
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
      {
        path: "seller",
        select: "firstName lastName businessTag businessName image",
      },
    ];

    const [totalProducts, product] = await Promise.all([
      Product.countDocuments({ isAddByAdmin: false }),
      Product.find({ isAddByAdmin: false })
        .populate(query)
        .sort({ createdAt: -1 })
        .skip((start - 1) * limit)
        .limit(limit),
    ]);

    return res.status(200).json({
      status: true,
      message: "Retrive the products.",
      totalProducts: totalProducts,
      product: product,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error",
    });
  }
};

//get fake products for admin
exports.getFakeProducts = async (req, res) => {
  try {
    if (!req.query.start || !req.query.limit) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const start = req.query.start ? parseInt(req.query.start) : 1;
    const limit = req.query.limit ? parseInt(req.query.limit) : 10;

    const query = [
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
      {
        path: "seller",
        select: "firstName lastName businessTag businessName image",
      },
    ];

    const [totalProducts, product] = await Promise.all([
      Product.countDocuments({ isAddByAdmin: true }),
      Product.find({ isAddByAdmin: true })
        .populate(query)
        .sort({ createdAt: -1 })
        .skip((start - 1) * limit)
        .limit(limit),
    ]);

    return res.status(200).json({
      status: true,
      message: "Retrive the products.",
      totalProducts: totalProducts,
      product: product,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error",
    });
  }
};

//get seller wise all products for admin
exports.getSellerWise = async (req, res) => {
  try {
    if (!req.query.sellerId) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const seller = await Seller.findById(req.query.sellerId);
    if (!seller) {
      return res.status(200).json({ status: false, message: "Seller does not found." });
    }

    const query = [
      { path: "category", select: "name" },
      { path: "subCategory", select: "name" },
      {
        path: "seller",
        select: "firstName lastName businessTag businessName image",
      },
    ];

    const product = await Product.find({ seller: seller._id }).populate(query).sort({ createdAt: -1 });

    return res.status(200).json({
      status: true,
      message: "Retrive products for the seller.",
      product,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({
      status: false,
      message: error.message || "Internal Server Error",
    });
  }
};

//get top selling products for admin (dashboard)
exports.topSellingProducts = async (req, res) => {
  try {
    //const products = await Product.find().sort({ sold: -1 }).limit(10);

    const products = await Product.aggregate([
      {
        $match: { createStatus: "Approved" },
      },
      {
        $lookup: {
          from: "ratings",
          localField: "_id",
          foreignField: "productId",
          as: "rating",
        },
      },
      {
        $project: {
          mainImage: 1,
          productName: 1,
          productCode: 1,
          productCode: 1,
          sold: 1,
          rating: {
            $cond: {
              if: { $eq: [{ $avg: "$rating.rating" }, null] },
              then: { $avg: 0 },
              else: { $avg: "$rating.rating" },
            },
          },
        },
      },
      { $sort: { sold: -1 } },
      { $limit: 10 },
    ]);

    return res.status(200).json({
      status: true,
      message: "Retrive top selling products.",
      products: products,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//get most popular products for admin (dashboard)
exports.popularProducts = async (req, res) => {
  try {
    const popularProducts = await Product.aggregate([
      {
        $match: { createStatus: "Approved" },
      },
      {
        $lookup: {
          from: "ratings",
          localField: "_id",
          foreignField: "productId",
          as: "rating",
        },
      },
      {
        $lookup: {
          from: "categories",
          localField: "category",
          foreignField: "_id",
          as: "category",
        },
      },
      {
        $project: {
          mainImage: 1,
          productName: 1,
          productCode: 1,
          rating: {
            $cond: {
              if: { $eq: [{ $avg: "$rating.rating" }, null] },
              then: { $avg: 0 },
              else: { $avg: "$rating.rating" },
            },
          },
          categoryName: { $arrayElemAt: ["$category.name", 0] },
        },
      },
      {
        $sort: { rating: -1 },
      },
      { $limit: 10 },
    ]);

    return res.status(200).json({
      status: true,
      message: "Retrive popular products.",
      popularProducts: popularProducts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};

//get just for you products for user(home page)
exports.justForYou = async (req, res) => {
  try {
    if (!req.query.userId) {
      return res.status(200).json({ status: false, message: "Oops! Invalid details." });
    }

    const userId = new mongoose.Types.ObjectId(req.query.userId);

    const [user, userIsSeller, justForYouProducts] = await Promise.all([
      User.findById(userId),
      Seller.findOne({ userId: userId }).lean(),
      Product.aggregate([
        {
          $match: {
            createStatus: "Approved",
          },
        },
        {
          $lookup: {
            from: "ratings",
            localField: "_id",
            foreignField: "productId",
            as: "rating",
          },
        },
        {
          $project: {
            seller: 1,
            mainImage: 1,
            productName: 1,
            review: 1,
            price: 1,
            sold: 1,
            attributes: 1,
            createStatus: 1,
            rating: {
              $cond: {
                if: { $eq: [{ $avg: "$rating.rating" }, null] },
                then: { $avg: 0 },
                else: { $avg: "$rating.rating" },
              },
            },
          },
        },
        {
          $sort: {
            review: -1,
            rating: -1,
          },
        },
        { $limit: 10 },
      ]),
    ]);

    if (!user) {
      return res.status(200).json({ status: false, message: "User does not found." });
    }

    if (user.isBlock) {
      return res.status(200).json({ status: false, message: "You are blocked by admin!" });
    }

    const filteredProducts = justForYouProducts.filter((product) => !userIsSeller || product.seller.toString() !== userIsSeller._id.toString());

    return res.status(200).json({
      status: true,
      message: "Retrieve just for you products!",
      justForYouProducts: filteredProducts,
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ status: false, message: error.message || "Internal Server Error" });
  }
};
