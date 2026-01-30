#!/bin/bash
# Создаёт seed_test_data.js на сервере, если его нет. Запуск: bash DB/SEED_ON_SERVER.sh
# (из папки backend)

DIR="$(cd "$(dirname "$0")" && pwd)"
FILE="$DIR/seed_test_data.js"
if [ -f "$FILE" ]; then
  echo "File exists: $FILE"
  exit 0
fi

mkdir -p "$DIR"
cat > "$FILE" << 'ENDOFFILE'
const mongoose = require("mongoose");
const Cryptr = require("cryptr");
const cryptr = new Cryptr("myTotallySecretKey");
const config = require("../config");
const User = require("../server/user/user.model");
const Seller = require("../server/seller/seller.model");
const Category = require("../server/category/category.model");
const SubCategory = require("../server/subCategory/subCategory.model");
const Product = require("../server/product/product.model");
const Reel = require("../server/reel/reel.model");
const Order = require("../server/order/order.model");
const Setting = require("../server/setting/setting.model");

const SELLER_USER_ID = new mongoose.Types.ObjectId("66a78b13a1a43d3e948f419a");
const ENCRYPTED_PASSWORD = cryptr.encrypt("12345678");
const SAMPLE_VIDEO = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4";
const SAMPLE_THUMB = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg";

async function run() {
  try {
    await mongoose.connect(config.MONGODB_CONNECTION_STRING);
    console.log("MongoDB connected");
    let setting = await Setting.findOne();
    if (!setting) {
      setting = new Setting({ isAddProductRequest: false, isUpdateProductRequest: false, adminCommissionCharges: 0, cancelOrderCharges: 0, withdrawCharges: 0, withdrawLimit: 1000 });
      await setting.save();
      console.log("Setting created");
    }
    let sellerUser = await User.findById(SELLER_USER_ID);
    if (!sellerUser) {
      sellerUser = new User({ _id: SELLER_USER_ID, firstName: "Era", lastName: "Shop Seller", email: "erashoptest@gmail.com", password: ENCRYPTED_PASSWORD, loginType: 3, identity: "test-seller", isSeller: true, isBlock: false });
      await sellerUser.save();
      console.log("Seller User created: erashoptest@gmail.com");
    } else {
      sellerUser.password = ENCRYPTED_PASSWORD;
      await sellerUser.save();
      console.log("Seller User password updated");
    }
    let sellerDoc = await Seller.findOne({ userId: sellerUser._id });
    if (!sellerDoc) {
      sellerDoc = new Seller({ firstName: "Era", lastName: "Shop", businessName: "Era Shop Test Store", businessTag: "@erashoptest", email: "erashoptest@gmail.com", userId: sellerUser._id, isSeller: true, isBlock: false });
      await sellerDoc.save();
      sellerUser.seller = sellerDoc._id;
      await sellerUser.save();
      console.log("Seller document created");
    }
    let buyerUser = await User.findOne({ email: "buyer@test.com" });
    if (!buyerUser) {
      buyerUser = new User({ firstName: "Test", lastName: "Buyer", email: "buyer@test.com", password: ENCRYPTED_PASSWORD, loginType: 3, identity: "test-buyer", isSeller: false, isBlock: false });
      await buyerUser.save();
      console.log("Buyer User created: buyer@test.com");
    }
    let category = await Category.findOne({ name: "Одежда" });
    if (!category) {
      category = new Category({ name: "Одежда", image: "" });
      await category.save();
      console.log("Category created");
    }
    let subCategory = await SubCategory.findOne({ category: category._id });
    if (!subCategory) {
      subCategory = new SubCategory({ name: "Футболки", image: "", category: category._id });
      await subCategory.save();
      category.subCategory = [subCategory._id];
      await category.save();
      console.log("SubCategory created");
    }
    const productNames = ["Футболка базовая", "Худи оверсайз", "Свитшот с принтом"];
    const productPrices = [990, 2490, 1990];
    const productIds = [];
    for (let i = 0; i < productNames.length; i++) {
      let product = await Product.findOne({ productName: productNames[i], seller: sellerDoc._id });
      if (!product) {
        product = new Product({ productName: productNames[i], productCode: "TEST-" + Date.now() + "-" + i, description: "Тестовый товар: " + productNames[i], price: productPrices[i], shippingCharges: 200, mainImage: "https://picsum.photos/400/400?random=" + i, images: [], attributes: [{ name: "Размер", value: ["S", "M", "L", "XL"] }, { name: "Цвет", value: ["Чёрный", "Белый"] }], quantity: 50, sold: i === 0 ? 3 : 0, review: 0, isOutOfStock: false, isNewCollection: true, seller: sellerDoc._id, category: category._id, subCategory: subCategory._id, createStatus: "Approved" });
        await product.save();
        productIds.push(product._id);
        console.log("Product created:", productNames[i]);
      }
    }
    if (productIds.length === 0) {
      const existing = await Product.find({ seller: sellerDoc._id }).limit(3);
      existing.forEach((p) => productIds.push(p._id));
    }
    const reelCount = await Reel.countDocuments({ sellerId: sellerDoc._id });
    if (reelCount === 0 && productIds[0]) {
      const p0 = await Product.findById(productIds[0]).select("productName");
      const reel1 = new Reel({ thumbnail: SAMPLE_THUMB, video: SAMPLE_VIDEO, description: "Тестовый рилс — " + (p0 ? p0.productName : ""), videoType: 2, thumbnailType: 2, productId: productIds[0], sellerId: sellerDoc._id, like: 0, isFake: false });
      await reel1.save();
      if (productIds[1]) {
        const reel2 = new Reel({ thumbnail: SAMPLE_THUMB, video: SAMPLE_VIDEO, description: "Второй тестовый рилс", videoType: 2, thumbnailType: 2, productId: productIds[1], sellerId: sellerDoc._id, like: 0, isFake: false });
        await reel2.save();
      }
      console.log("Reels created");
    }
    const orderCount = await Order.countDocuments({ userId: buyerUser._id });
    if (orderCount === 0 && productIds[0]) {
      const product0 = await Product.findById(productIds[0]);
      const order = new Order({ orderId: "ORD-TEST-" + Date.now(), userId: buyerUser._id, items: [{ productId: productIds[0], sellerId: sellerDoc._id, purchasedTimeProductPrice: product0.price, purchasedTimeShippingCharges: 200, productQuantity: 1, status: "Delivered", date: new Date().toISOString() }], totalQuantity: 1, totalItems: 1, totalShippingCharges: 200, subTotal: product0.price, total: product0.price + 200, finalTotal: product0.price + 200, shippingAddress: { name: "Test Buyer", country: "Россия", city: "Москва", address: "ул. Тестовая, 1", zipCode: 123456 } });
      await order.save();
      console.log("Order created for buyer");
    }
    console.log("\n--- Готово. Покупатель: buyer@test.com / 12345678. Продавец: erashoptest@gmail.com / 12345678 ---");
  } catch (err) {
    console.error("Seed error:", err);
    process.exit(1);
  } finally {
    await mongoose.disconnect();
    process.exit(0);
  }
}
run();
ENDOFFILE
echo "Created: $FILE"
echo "Run: node DB/seed_test_data.js"
