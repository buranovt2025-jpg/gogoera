/// API configuration. Backend runs on same server, port 5000.
/// Change BASE_URL if backend is on another host/port.
class Constant {
  /// Backend API URL (Era Shop Node.js backend). Must match backend config.baseURL.
  static const BASE_URL = "http://146.190.238.186:5000/";
  /// API secret key — must match backend config.secretKey (default from Era Shop install).
  static const SECRET_KEY = "5TIvw5cpc0";



  /// **************** GENERAL URL ****************
  static const editProfile = "user/update";
  static const userLogin = "user/login";
  static const otpCreate = "OTP/create";
  static const userLoginVerifyOtp = "OTP/otplogin";
  static const otpVerify = "OTP/verify";
  static const checkPassword = "user/checkPassword";
  static const setPassword = "user/setPassword";
  static const sellerSetPassword = "seller/setPassword";
  static const checkUser = "user/checkUser";
  static const reviewCreate = "review/create";
  static const requestCreate = "request/create"; // seller create request
  static const createProduct = "product/create";
  static const sellerAllData = "request/sellerBecomeOrNot";
  static const favoriteUnFavorite = "favorite/favoriteUnfavorite";
  static const followUnfollow = "follower/followUnfollow";
  static const addTOCart = "cart/addToCart";
  static const removeTOCart = "cart/removeProduct";
  static const faq = "FAQ";
  static const userAddAddress = "address/create";
  static const getAllCategory = "category";
  static const attributes = "attributes";
  static const checkOut = "cart/checkOut";
  static const allPromoCode = "promoCode/getAll";
  static const setting = "setting";
  static const justForYouProduct = "product/justForYouProducts"; // home page just for you
  static const searchProduct = "product/search";
  static const previousSearchProducts = "product/searchProduct";
  static const liveSeller = "liveSeller";
  static const uploadShort = "reel/uploadReel";

  /// **************** QUERY(params) URL ********************
  static const userProfile = "/user/profile"; // user profile who login
  static const sellerUpdate = "/seller/update";
  static const allProductForSeller = "/product/allProductForSeller";
  static const sellerUploadedShort = "/reel/reelsOfSeller";

  //static const productUpdate = "/product/update"; pela aa hti hve aa url chhe :- updateProductBySeller
  static const updateProductBySeller = "/productRequest/updateProductRequest";
  static const sellerProductDetails = "/product/detailforSeller";
  static const getShortForUser = "reel/getReelsForUser";
  static const shortsLikeAndDislike = "reel/likeOrDislikeOfReel";
  static const userProductDetails = "/product/detail";
  static const getReviewDetails = "/review/getreview";
  static const sellerProductDelete = "/product/delete";
  static const sellerReelDelete = "/reel/deleteReel";
  static const galleryCategory = "/product/categorywiseAllProducts";
  static const productSelectOrNot = "/product/selectOrNot";
  static const myOrders = "/order/orderDetailsForUser";
  static const selectedProductForLive = "/product/selectedProducts";
  static const favoriteProducts = "/favorite/favoriteProduct";
  static const getAllCartProducts = "/cart/getCartProduct";
  static const userUpdateAddress = "/address/update";
  static const userSelectAddress = "/address/selectOrNot";
  static const newCollection = "/product/geAllNewCollection";
  static const getAllAddress = "/address/getAllAddress";
  static const getOnlySelectedAddress = "/address/selectAddress";
  static const orderCountForSeller = "/order/orderCountForSeller";
  static const orderDetailsForSeller = "/order/orderDetailsForSeller";
  static const walletCountForSeller = "/sellerWallet/getAllAmount";
  static const pendingWalletAmountForSeller = "/sellerWallet/sellerPendingAmount";
  static const deliveredOrderAmountForSeller = "/sellerWallet/sellerPendingWithdrawableAmount";
  static const sellerTotalEarning = "/sellerWallet/sellerEarningAmount";
  static const categoryWiseSubCategory = "/subCategory/categoryWiseSubCategory";
  static const userApplyPromoCheck = "/promoCodeCheck/checkPromoCode";
  static const createOrderByUser = "/order/create";
  static const updateOrderStatusBySeller = "/order/updateOrder";
  static const orderCancelByUser = "/order/cancelOrderByUser";
  static const ratingAdd = "/rate/addRating";
  static const deleteAllCartProduct = "/cart/deleteCart";
  static const addressDeleteByUser = "/address/delete";
  static const liveSellerList = "/liveSeller/liveSellerList";
  static const updatePasswordByUser = "/user/updatePassword";
  static const updatePasswordBySeller = "/seller/updatePassword";
  static const filterWiseProduct = "/product/filterWiseProduct";
  static const getSelectedProductForUser = "/liveSeller/getSelectedProducts";
  static const allNotificationList = "/notification/list";
  static const deleteAccount = "/user/deleteUserAccount";
  static const getAllBank = "bank/getBanks";

  static String getDomainFromURL(String url) {
    final uri = Uri.parse(url);
    String host = uri.host;
    if (host.startsWith("www.")) {
      return host.substring(4);
    }
    print("object::::::host uri:::$host");
    return host;
  }
}
