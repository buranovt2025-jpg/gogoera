const mongoose = require("mongoose");

const productRequestSchema = new mongoose.Schema(
  {
    productName: { type: String, trim: true },
    productCode: { type: String, trim: true, unique: true, default: "" },
    description: { type: String, trim: true },
    mainImage: { type: String },
    images: { type: Array, default: [] },
    attributes: [
      {
        name: { type: String },
        value: [{ type: String }],
      },
    ],
    price: { type: Number, default: 0 },
    shippingCharges: { type: Number, default: 0 },

    seller: { type: mongoose.Schema.Types.ObjectId, ref: "Seller" },
    category: { type: mongoose.Schema.Types.ObjectId, ref: "Category" },
    subCategory: { type: mongoose.Schema.Types.ObjectId, ref: "SubCategory" },

    //update product request status
    updateStatus: {
      type: String,
      default: "All",
      enum: ["Pending", "Approved", "Rejected", "All"],
    },

    date: { type: String },
  },
  {
    timestamps: true,
    versionKey: false,
  }
);

productRequestSchema.index({ seller: 1 });
productRequestSchema.index({ category: 1 });
productRequestSchema.index({ subCategory: 1 });

module.exports = mongoose.model("ProductRequest", productRequestSchema);
