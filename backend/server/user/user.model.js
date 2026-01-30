const mongoose = require("mongoose");

const userSchema = new mongoose.Schema(
  {
    firstName: { type: String, trim: true, default: "George" },
    lastName: { type: String, trim: true, default: "Orwell" },
    email: { type: String, trim: true, default: "EraShopUser123@gmail.com" },
    dob: { type: String, trim: true, default: "24 february 1996" },
    gender: { type: String, trim: true, default: "Male" },
    location: { type: String, trim: true, default: "India" },
    mobileNumber: { type: String, trim: true, default: null },
    image: { type: String, trim: true, default: null },

    password: { type: String, trim: true, default: null },
    uniqueId: { type: String, trim: true, default: null },
    loginType: { type: Number, enum: [1, 2, 3, 4] }, //1.google 2.Apple 3.email-password 4.isLogin

    identity: { type: String, trim: true },
    fcmToken: { type: String, trim: true, default: null },
    date: String,

    followers: { type: Number, default: 0 },
    following: { type: Number, default: 0 },

    notification: {
      paymentReminder: { type: Boolean, default: true },
      productDelivery: { type: Boolean, default: true },
      expiredVoucher: { type: Boolean, default: true },
    },

    isBlock: { type: Boolean, default: false },
    amount: { type: Number, default: 0 }, //when order cancel at that time increase refund amount

    //If user become the seller
    isSeller: { type: Boolean, default: false },
    seller: { type: mongoose.Schema.Types.ObjectId, ref: "Seller", default: null },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

userSchema.index({ isBlock: 1 });
userSchema.index({ createdAt: -1 });
userSchema.index({ seller: -1 });

module.exports = mongoose.model("User", userSchema);
