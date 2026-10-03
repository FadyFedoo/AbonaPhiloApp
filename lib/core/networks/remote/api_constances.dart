class ApiConstants {
  static const localBaseUrl = "http://192.168.1.18:5002/";
  static const baseUrl = "https://elbroker-back-end.onrender.com/";
  static const loginEndPoint = "user/login";
  static const forgetPasswordEndPoint = "user/forgetPassword";
  static const allCountriesEndPoint = "country/getCountriesUser";
  static const registerEndPoint = "user/addUser";
  static const updateUserEndPoint = "user/updateUser";
  static const deleteUserEndPoint = "user/deleteUser";
  static const changePasswordEndPoint = "user/changePassword";
  static const verifyAccountEndPoint = "user/userVerification";
  static const verifyResetPasswordCodeEndPoint = "user/forgetVerificatuion";
  static const resetPasswordEndPoint = "user/resetPasswordUser";
  static const resendVerificationCodeEndPoint = "user/verification";
  static const getUserDataEndPoint = "user/oneUser";
  static const getHomeUnitsDataEndPoint = "unit/getUnitsByTypes";
  static const getRecentlyViewedEndPoint = "user/getUserViews";
  static const getMyUnitsEndPoint = "user/getOwnerViews";
  static const getHomeCarouselDataEndPoint = "carousel/getCarousels";
  static const getAllPackagesEndPoint = "Package/getPackageUser";
  static const getTypesEndPoint = "type/getTypeUser";
  static const getFurnishingEndPoint = "furnishing/getFurnishingUser";
  static const getDeliveryEndPoint = "delivery/getDeliveryUser";
  static const getAllCitiesEndPoint = "country/getCities";
  static const getAmenitiesEndPoint = "amenitie/getAmenitieUser";
  static const getUserUnitTypesEndPoint = "unitType/getUserActiveUnitType";
  static const getFavoritesEndPoint = "user/getUserWishlist";
  static const getFavoritesByIdsEndPoint = "/user/getMobileWishlist";
  static const addManyWishListEndPoint = "/user/addManyWishlist";
  static const addToFavoritesEndPoint = "user/addWishlist";
  static const removeToFavoritesEndPoint = "user/removeWishlist";
  static const addUnitEndPoint = "unit/addUnit";
  static const getAllFilterTypesEndPoint = "unitType/getUnitTypeUser";
  static const getFilteredUnitsEndPoint = "unit/getUserFilter";
  static const getNotificationsEndPoint = "notification/getNotifications";
  static const searchUnitsByTypeEndPoint = "unit/searchUnitsByTypes";

  static const getUserSubscriptionsEndPoint =
      "subscribtion/getUserSubscribtions";

  static String getCitesEndPoint({String? id}) {
    return "country/getCitiesUser/$id";
  }

  static String editUnitEndPoint({String? id}) {
    return "unit/updateUnit/$id";
  }

  static String getCategoryUnits({required String id}) {
    return "unit/getUnitsByUnitType/$id";
  }

  static String getUnitDetailsData({required String id}) {
    return "unit/getOneUnit/$id";
  }

  static String deleteMyUnitEndPoint({required String id}) {
    return "unit/deleteUnit/$id";
  }
}
