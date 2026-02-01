/**
 * Расширенный seed: фейк-аккаунты для всех ролей, товары, рилсы, истории заказов.
 * Запуск: cd backend && node DB/seed_fake_data.js
 * Сброс и пересоздание: node DB/seed_fake_data.js --reset
 */
const mongoose = require("mongoose");
const RESET_MODE = process.argv.includes("--reset");
const Cryptr = require("cryptr");
const bcrypt = require("bcryptjs");
const cryptr = new Cryptr("myTotallySecretKey");
const config = require("../config");

const User = require("../server/user/user.model");
const Seller = require("../server/seller/seller.model");
const Admin = require("../server/admin/admin.model");
const Category = require("../server/category/category.model");
const SubCategory = require("../server/subCategory/subCategory.model");
const Product = require("../server/product/product.model");
const Reel = require("../server/reel/reel.model");
const Order = require("../server/order/order.model");
const Setting = require("../server/setting/setting.model");
const Login = require("../server/login/login.model");

const PASSWORD = "12345678";
const ENCRYPTED_PASSWORD = cryptr.encrypt(PASSWORD);
const BCRYPT_PASSWORD = bcrypt.hashSync(PASSWORD, 10);

const SAMPLE_VIDEOS = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
];
const SAMPLE_THUMBS = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
];

const SELLER_DEMO_ID = new mongoose.Types.ObjectId("66a78b13a1a43d3e948f419a"); // для кнопки "Seller Demo Account"

const FAKE_ACCOUNTS = {
  admin: { email: "admin@test.com", name: "Админ Тест", role: "admin" },
  buyers: [
    { email: "buyer@test.com", firstName: "Тест", lastName: "Покупатель" },
    { email: "buyer1@test.com", firstName: "Иван", lastName: "Покупатель" },
    { email: "buyer2@test.com", firstName: "Мария", lastName: "Клиент" },
    { email: "buyer3@test.com", firstName: "Алексей", lastName: "Шоппер" },
  ],
  sellers: [
    { email: "erashoptest@gmail.com", firstName: "Era", lastName: "Shop", businessName: "Era Shop Test Store", businessTag: "@erashoptest", _id: SELLER_DEMO_ID },
    { email: "seller1@test.com", firstName: "Олег", lastName: "Продавец", businessName: "Модный магазин Олега", businessTag: "@oleshop" },
    { email: "seller2@test.com", firstName: "Анна", lastName: "Торговец", businessName: "Бутик Анны", businessTag: "@annaboutique" },
  ],
};

const CATEGORIES = [
  { name: "Одежда", subcats: ["Футболки", "Джинсы", "Платья"] },
  { name: "Электроника", subcats: ["Смартфоны", "Наушники", "Аксессуары"] },
  { name: "Дом", subcats: ["Текстиль", "Декор", "Посуда"] },
];

const FAKE_PRODUCTS = [
  { name: "Футболка базовая", price: 990, desc: "Универсальная базовая футболка" },
  { name: "Худи оверсайз", price: 2490, desc: "Тёплый худи свободного кроя" },
  { name: "Свитшот с принтом", price: 1990, desc: "Свитшот с уникальным принтом" },
  { name: "Джинсы скинни", price: 3290, desc: "Классические скинни джинсы" },
  { name: "Платье летнее", price: 4590, desc: "Лёгкое летнее платье" },
  { name: "Чехол для телефона", price: 490, desc: "Силиконовый чехол" },
  { name: "Беспроводные наушники", price: 3990, desc: "Bluetooth наушники" },
  { name: "Подушка декоративная", price: 1290, desc: "Мягкая декоративная подушка" },
  { name: "Набор кружек", price: 890, desc: "Набор из 4 кружек" },
  { name: "Рюкзак городской", price: 2790, desc: "Стильный городской рюкзак" },
];

async function run() {
  try {
    await mongoose.connect(config.MONGODB_CONNECTION_STRING);
    console.log("MongoDB connected");

    // 1. Setting
    let setting = await Setting.findOne();
    if (!setting) {
      setting = new Setting({
        isAddProductRequest: false,
        isUpdateProductRequest: false,
        adminCommissionCharges: 0,
        cancelOrderCharges: 0,
        withdrawCharges: 0,
        withdrawLimit: 1000,
        zegoAppId: "0",
        zegoAppSignIn: "",
      });
      await setting.save();
      console.log("Setting created");
    } else if (!/^\d+$/.test(setting.zegoAppId || "")) {
      setting.zegoAppId = "0";
      await setting.save();
      console.log("Setting: fixed invalid zegoAppId");
    }

    // Reset: удаляем рилсы и фейк-товары для пересоздания
    if (RESET_MODE) {
      const delReels = await Reel.deleteMany({});
      const delProducts = await Product.deleteMany({ productCode: /^FAKE-/ });
      console.log("Reset: deleted", delReels.deletedCount, "reels,", delProducts.deletedCount, "fake products");
    }

    // 2. Admin
    let admin = await Admin.findOne({ email: FAKE_ACCOUNTS.admin.email });
    if (!admin) {
      admin = new Admin({
        name: FAKE_ACCOUNTS.admin.name,
        email: FAKE_ACCOUNTS.admin.email,
        password: BCRYPT_PASSWORD,
      });
      await admin.save();
      console.log("Admin created:", FAKE_ACCOUNTS.admin.email);
    } else {
      admin.password = BCRYPT_PASSWORD;
      await admin.save();
      console.log("Admin password updated");
    }

    // 2.5 Login flag — показывать форму входа (не регистрации)
    let loginDoc = await Login.findOne();
    if (!loginDoc) {
      loginDoc = new Login({ login: true });
      await loginDoc.save();
      console.log("Login: created, login=true");
    } else if (loginDoc.login === false) {
      loginDoc.login = true;
      await loginDoc.save();
      console.log("Login: set login=true (админка покажет форму входа)");
    }

    // 3. Buyers
    const buyerUsers = [];
    for (const b of FAKE_ACCOUNTS.buyers) {
      let user = await User.findOne({ email: b.email });
      if (!user) {
        user = new User({
          firstName: b.firstName,
          lastName: b.lastName,
          email: b.email,
          password: ENCRYPTED_PASSWORD,
          loginType: 3,
          identity: "fake-" + b.email.split("@")[0],
          isSeller: false,
          isBlock: false,
        });
        await user.save();
        console.log("Buyer created:", b.email);
      }
      buyerUsers.push(user);
    }

    // 4. Sellers (User + Seller)
    const sellerDocs = [];
    for (let i = 0; i < FAKE_ACCOUNTS.sellers.length; i++) {
      const s = FAKE_ACCOUNTS.sellers[i];
      const isDemo = s._id && s.email === "erashoptest@gmail.com";
      let user = await User.findOne({ email: s.email });
      if (!user) {
        user = new User({
          ...(isDemo && { _id: s._id }),
          firstName: s.firstName,
          lastName: s.lastName,
          email: s.email,
          password: ENCRYPTED_PASSWORD,
          loginType: 3,
          identity: isDemo ? "test-seller" : "fake-seller-" + (i + 1),
          isSeller: true,
          isBlock: false,
        });
        await user.save();
      } else if (isDemo) {
        user.password = ENCRYPTED_PASSWORD;
        await user.save();
      }
      let seller = await Seller.findOne({ userId: user._id });
      if (!seller) {
        seller = new Seller({
          firstName: s.firstName,
          lastName: s.lastName,
          businessName: s.businessName,
          businessTag: s.businessTag,
          email: s.email,
          userId: user._id,
          isSeller: true,
          isBlock: false,
        });
        await seller.save();
        user.seller = seller._id;
        await user.save();
        console.log("Seller created:", s.email);
      }
      sellerDocs.push(seller);
    }

    // 5. Categories & SubCategories
    const categoryMap = {};
    for (const cat of CATEGORIES) {
      let category = await Category.findOne({ name: cat.name });
      if (!category) {
        category = new Category({ name: cat.name, image: `https://picsum.photos/id/${50 + cat.name.length}/200/200` });
        await category.save();
        console.log("Category:", cat.name);
      }
      const subcats = [];
      for (const subName of cat.subcats) {
        let sub = await SubCategory.findOne({ name: subName, category: category._id });
        if (!sub) {
          sub = new SubCategory({ name: subName, image: "", category: category._id });
          await sub.save();
          category.subCategory = category.subCategory || [];
          if (!category.subCategory.some((id) => id.toString() === sub._id.toString())) {
            category.subCategory.push(sub._id);
            await category.save();
          }
          subcats.push(sub);
        } else {
          subcats.push(sub);
        }
      }
      categoryMap[cat.name] = { category, subcats };
    }

    // 6. Products (раздаём по продавцам и категориям)
    const productIds = [];
    const catKeys = Object.keys(categoryMap);
    for (let i = 0; i < FAKE_PRODUCTS.length; i++) {
      const p = FAKE_PRODUCTS[i];
      const seller = sellerDocs[i % sellerDocs.length];
      const catKey = catKeys[i % catKeys.length];
      const { category, subcats } = categoryMap[catKey];
      const subcat = subcats[i % subcats.length] || subcats[0];

      let product = RESET_MODE ? null : await Product.findOne({ productName: p.name, seller: seller._id });
      if (!product) {
        product = new Product({
          productName: p.name,
          productCode: `FAKE-${Date.now()}-${i}`,
          description: p.desc,
          price: p.price,
          shippingCharges: 200,
          mainImage: `https://picsum.photos/id/${100 + i}/400/400`,
          images: [],
          attributes: [{ name: "Размер", value: ["S", "M", "L", "XL"] }, { name: "Цвет", value: ["Чёрный", "Белый", "Серый"] }],
          quantity: 50,
          sold: Math.floor(Math.random() * 10),
          review: Math.floor(Math.random() * 5),
          isOutOfStock: false,
          isNewCollection: i < 5,
          seller: seller._id,
          category: category._id,
          subCategory: subcat._id,
          createStatus: "Approved",
        });
        await product.save();
        productIds.push(product._id);
        console.log("Product:", p.name);
      }
    }

    const allProducts = await Product.find({ seller: { $in: sellerDocs.map((s) => s._id) } }).limit(15);
    const allProductIds = allProducts.map((p) => p._id);
    if (allProductIds.length === 0) {
      console.log("No products for reels/orders. Run seed_test_data.js first?");
      process.exit(1);
    }

    // 7. Reels (для каждого продавца по 2-3 рилса)
    for (const seller of sellerDocs) {
      const sellerProducts = await Product.find({ seller: seller._id }).limit(3);
      const reelCount = await Reel.countDocuments({ sellerId: seller._id });
      if (reelCount < 2 && sellerProducts.length > 0) {
        for (let r = 0; r < Math.min(3, sellerProducts.length); r++) {
          const prod = sellerProducts[r];
          const vi = r % SAMPLE_VIDEOS.length;
          const reel = new Reel({
            thumbnail: SAMPLE_THUMBS[vi],
            video: SAMPLE_VIDEOS[vi],
            description: `Рилс: ${prod.productName}. Смотри и покупай!`,
            videoType: 2,
            thumbnailType: 2,
            productId: prod._id,
            sellerId: seller._id,
            like: Math.floor(Math.random() * 100),
            isFake: false,
          });
          await reel.save();
          console.log("Reel for:", prod.productName);
        }
      }
    }

    // 8. Orders (истории заказов для покупателей)
    const statuses = ["Pending", "Confirmed", "Out Of Delivery", "Delivered", "Cancelled"];
    for (const buyer of buyerUsers) {
      const orderCount = await Order.countDocuments({ userId: buyer._id });
      if (orderCount < 3) {
        for (let o = 0; o < 3; o++) {
          const prod = allProducts[o % allProducts.length];
          const seller = await Seller.findById(prod.seller);
          const status = statuses[o % statuses.length];
          const orderId = `ORD-FAKE-${Date.now()}-${buyer._id.toString().slice(-6)}-${o}`;
          const exists = await Order.findOne({ orderId });
          if (!exists && prod && seller) {
            const order = new Order({
              orderId,
              userId: buyer._id,
              items: [
                {
                  productId: prod._id,
                  sellerId: seller._id,
                  purchasedTimeProductPrice: prod.price,
                  purchasedTimeShippingCharges: 200,
                  productQuantity: 1 + (o % 2),
                  status,
                  date: new Date(Date.now() - o * 86400000).toISOString(),
                },
              ],
              totalQuantity: 1 + (o % 2),
              totalItems: 1,
              totalShippingCharges: 200,
              subTotal: prod.price * (1 + (o % 2)),
              total: prod.price * (1 + (o % 2)) + 200,
              finalTotal: prod.price * (1 + (o % 2)) + 200,
              shippingAddress: {
                name: `${buyer.firstName} ${buyer.lastName}`,
                country: "Россия",
                city: "Москва",
                address: `ул. Тестовая, ${o + 1}`,
                zipCode: 123456 + o,
              },
            });
            await order.save();
            console.log("Order:", orderId, status);
          }
        }
      }
    }

    console.log("\n=== Готово! Фейк-аккаунты (пароль: 12345678) ===");
    console.log("Админ:    ", FAKE_ACCOUNTS.admin.email);
    console.log("Покупатели:", FAKE_ACCOUNTS.buyers.map((b) => b.email).join(", "));
    console.log("Продавцы: ", FAKE_ACCOUNTS.sellers.map((s) => s.email).join(", "));
  } catch (err) {
    console.error("Seed error:", err);
    process.exit(1);
  } finally {
    await mongoose.disconnect();
    process.exit(0);
  }
}

run();
