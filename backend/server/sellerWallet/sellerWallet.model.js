const mongoose = require("mongoose");

const sellerWalletSchema = new mongoose.Schema(
  {
    orderId: { type: mongoose.Schema.Types.ObjectId, ref: "Order", default: null },
    productId: { type: mongoose.Schema.Types.ObjectId, ref: "Product" },
    sellerId: { type: mongoose.Schema.Types.ObjectId, ref: "Seller" },
    itemId: { type: mongoose.Schema.Types.ObjectId, default: null },
    amount: { type: Number, default: 0 },
    commissionPerProductQuantity: { type: Number, default: 0 },
    type: { type: Number, enum: [1, 2, 3, 4] }, //1.pendingAmount 2.pendingWithdrawbleAmount 3.pendingWithdrawbleRequestedAmount 4.cancelledOrderAmount
    status: { type: String, enum: ["Pending", "Done", "Cancelled"] },
    date: { type: String, default: "" },
    paymentGateway: { type: String, default: null },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

sellerWalletSchema.index({ orderId: 1 });
sellerWalletSchema.index({ productId: 1 });
sellerWalletSchema.index({ sellerId: 1 });
sellerWalletSchema.index({ itemId: 1 });
sellerWalletSchema.index({ type: 1 });
sellerWalletSchema.index({ status: 1 });

module.exports = mongoose.model("SellerWallet", sellerWalletSchema);
