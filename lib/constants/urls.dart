class AppUrl {

  static final appStatusChecker='https://sarthakpatel.com/switch/switch.php?lma';
//  static final baseUrl='http://148.66.143.230/little_makers_app/public/api/';

  static final baseUrl='http://13.234.38.57/little_makers_app/public/api/';

  //live
  static final String loginAPi =
      baseUrl+"auth/login";
  static final String signUpApi =baseUrl+'auth/signup';
  static final String notificationAdrress=baseUrl+'notification/list/general';
  static final String clearAllNotification=baseUrl+'notification/clear/general/';
  static final String markAllReadNotification=baseUrl+'notification/mark/read/general/';
  static final userProfileUrl =
      baseUrl+"user/profile/update";
  static final userImageUrl=baseUrl+'user/photo/update';
  static final updateKidImage=baseUrl+'kid/photo/update';
  static final updateUserAddress =
      baseUrl+"user/address/update";

  static final getAddress =
      baseUrl+"user/address/get/";

  static final productsAddress =
      baseUrl+"product/list";
  static final virtualProductsAddress =
      baseUrl+"product/list/virtual";

  static final storageAddress =
      "http://13.234.38.57/little_makers_app/public/storage/";

  static final kidsAddress =
      baseUrl+"kid/list/";

  static final updateKidAddress =
      baseUrl+"kid/update";

  static final addKidAddress =
      baseUrl+"kid/add";

  static final deleteKidAddress =
      baseUrl+"kid/delete";

  static final createOrderAddress =
      baseUrl+"order/create";

  static final shippingListAddress =
      baseUrl+"shipping/classes";
  static final addToCartAddress=baseUrl+'manual_cart/item/add';
  static final getCartItemsAddress=baseUrl+'manual_cart/item/list/';
  static final updatebillingAddress=baseUrl+'user/address/billing/update';
  static final updateSippingAddress=baseUrl+'user/address/shipping/update';
  static final orderListAddress=baseUrl+'order/history/';
  static final activeSubscriptionAddress=baseUrl+'subscription/history/active/';
  static final deleteCartItemAddress=baseUrl+'manual_cart/item/delete/';
  static final updateCartItemAddress=baseUrl+'manual_cart/item/update';
  static final resultText=baseUrl+'subscription/progress/text/';
  static final resultImage=baseUrl+'subscription/progress/image/';
  static final resultVideo=baseUrl+'subscription/progress/video/';
  static final userDetailsAddress=baseUrl+'auth/user/details';
  static final clearCartAddress=baseUrl+'manual_cart/clear/';
  static final changePasswordAddress=baseUrl+'user/change/password';
  static final addWishListAddress=baseUrl+'wishlist/add';
  static final removeFromWishlistAddress=baseUrl+'wishlist/remove';
  static final myWishList=baseUrl+'wishlist/list/';
  static final checkwishlist=baseUrl+'wishlist/check';
  static final sendOtp=baseUrl+'auth/send/otp';
  static final verifyOtp=baseUrl+'auth/verify/otp';
  static final loginVerifyOtp=baseUrl+'auth/verify/otp/to/login';
  static final sendProfileOtp=baseUrl+'auth/send/otp/to/update/phone';
  static final verifyProfileOtp=baseUrl+'auth/verify/otp/to/update/phone';

}
