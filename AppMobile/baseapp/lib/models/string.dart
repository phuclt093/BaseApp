import 'package:flutter/material.dart';

import '../../helpers/constant.dart';

//define all string here that used in json api

final String getUserSignUpApi = apiUrl + 'user_signup';
final String getNewsApi = apiUrl + 'get_news';
final String getNewsByCatApi = apiUrl + 'get_news_by_category';
final String getSettingApi = apiUrl + 'get_settings';
final String getCatApi = apiUrl + 'get_category';
final String getNewsByIdApi = apiUrl + 'get_news_by_id';
final String setBookmarkApi = apiUrl + 'set_bookmark';
final String getBookmarkApi = apiUrl + 'get_bookmark';
final String setCommentApi = apiUrl + 'set_comment';
final String getCommnetByNewsApi = apiUrl + 'get_comment_by_news';
final String getBreakingNewsApi = apiUrl + 'get_breaking_news';
final String setProfileApi = apiUrl + 'set_profile_image';
final String setUpdateProfileApi = apiUrl + 'update_profile';
final String setRegisterToken = apiUrl + 'register_token';
final String getNotificationApi = apiUrl + 'get_notification';
final String setUserCatApi = apiUrl + 'set_user_category';
final String getUserByIdApi = apiUrl + 'get_user_by_id';
final String getNewsByUserCatApi = apiUrl + 'get_news_by_user_category';
final String setCommentDeleteApi = apiUrl + 'delete_comment';
final String setLikesDislikesApi = apiUrl + 'set_like_dislike';
final String setFlagApi = apiUrl + 'set_flag';
final String getLiveStreamingApi = apiUrl + 'get_live_streaming';
final String getSubCategoryApi = apiUrl + 'get_subcategory_by_category';
final String setLikeDislikeComApi = apiUrl + 'set_comment_like_dislike';
final String getNewsByTagApi = apiUrl + 'get_news_by_tag';
final String getUserNotificationApi = apiUrl + 'get_user_notification';
final String updateFCMIdApi = apiUrl + 'update_fcm_id';
final String deleteUserNotiApi = apiUrl + 'delete_user_notification';
final String getQueApi = apiUrl + 'get_question';
final String getQueResultApi = apiUrl + 'get_question_result';
final String setQueResultApi = apiUrl + 'set_question_result';
final String userDeleteApi = apiUrl + 'delete_user';
final String getTagsApi = apiUrl + 'get_tag';
final String setNewsApi = apiUrl + 'set_news';
final String updateNewsApi = apiUrl + 'update_news';
final String setDeleteNewsApi = apiUrl + 'delete_news';
final String setDeleteImageApi = apiUrl + 'delete_news_images';
final String getLanguagesApi = apiUrl + 'get_languages_list';
final String getLangJsonDataApi = apiUrl + 'get_language_json_data';
final String getVideosApi = apiUrl + 'get_videos';
final String getPagesApi = apiUrl + 'get_pages';
final String getPolicyPagesApi = apiUrl + 'get_policy_pages';

final String ISFIRSTTIME = 'loginfirst$appName';

const String APP_THEME = "AppTheme";
const String ID = "id";
const String NAME = "name";
const String EMAIL = "email";
const String TYPE = "type";
const String URL = "url";
const String STATUS = "status";
const String FCM_ID = "fcm_id";
const String PROFILE = "profile";
const String ROLE = "role";
const String MOBILE = "mobile";
const String ACCESS_KEY = "access_key";
const String FIREBASE_ID = "firebase_id";
const String CATEGORY_ID = "category_id";
const String CONTENT_TYPE = "content_type";
const String SHOW_TILL = "show_till";
const String CONTENT_VALUE = "content_value";
const String DATE = "date";
const String TITLE = "title";
const String DESCRIPTION = "description";
const String IMAGE = "image";
const String CATEGORY_NAME = "category_name";
const String PRIVACY_POLICY = "privacy_policy";
const String CONTACT_US = "contact_us";
const String TERMS_CONDITIONS = "terms_conditions";
const String ABOUT_US = "about_us";
const String NEWS_ID = "news_id";
const String USER_ID = "user_id";
const String OFFSET = "offset";
const String LIMIT = "limit";
const String USER_NEWS = "get_user_news";
const String MESSAGE = "message";
const String COUNTER = "counter";
const String DATE_SENT = "date_sent";
const String SYSTEM = "system";
const String DARK = "Dark";
const String LIGHT = "light";
const String OTHER_IMAGE = "other_image";
const String OTHER_URL = "other_url";
const String IMAGE_DATA = "image_data";
const String cur_catId = "catId";
const String COMMENT_ID = "comment_id";
const String font_value = "fontValue";
const String TOTAL_LIKE = "total_like";
const String LIKE = "like";
const String LANGUAGE_CODE = 'languageCode';
const String login_email = "email";
const String login_gmail = "gmail";
const String login_fb = "fb";
const String login_apple = "apple";
const String login_mbl = "mobile";
const String TAG_NAME = "tag_name";
const String SUBCAT_NAME = "subcategory_name";
const String SUBCAT_ID = "subcategory_id";
const String DISLIKE = "dislike";
const String TOTAL_DISLIKE = "total_dislike";
const String PARENT_ID = "parent_id";
const String REPLY = "replay";
const String SEARCH = "search";
const String TAGNAME = "tag_name";
const String SUBCATEGORY = "subcategory";
const String TAG_ID = "tag_id";
const String NOTIENABLE = "notiEnabled";
const String HISTORY_LIST = "history_list";
const String QUESTION = "question";
const String QUESTION_ID = "question_id";
const String OPTION_ID = "option_id";
const String OPTION = "option";
const String OPTIONS = "options";
const String PERCENTAGE = "percentage";
const String CATEGORY_MODE = "category_mode";
const String BREAK_NEWS_MODE = "breaking_news_mode";
const String COMM_MODE = "comments_mode";
const String LIVE_STREAM_MODE = "live_streaming_mode";
const String SUBCAT_MODE = "subcategory_mode";
const String FB_REWARDED_ID = "fb_rewarded_video_id";
const String FB_INTER_ID = "fb_interstitial_id";
const String FB_BANNER_ID = "fb_banner_id";
const String FB_NATIVE_ID = "fb_native_unit_id";
const String IOS_FB_REWARDED_ID = "ios_fb_rewarded_video_id";
const String IOS_FB_INTER_ID = "ios_fb_interstitial_id";
const String IOS_FB_BANNER_ID = "ios_fb_banner_id";
const String IOS_FB_NATIVE_ID = "ios_fb_native_unit_id";

const String GO_REWARDED_ID = "google_rewarded_video_id";
const String GO_INTER_ID = "google_interstitial_id";
const String GO_BANNER_ID = "google_banner_id";
const String GO_NATIVE_ID = "google_native_unit_id";
const String IOS_GO_REWARDED_ID = "ios_google_rewarded_video_id";
const String IOS_GO_INTER_ID = "ios_google_interstitial_id";
const String IOS_GO_BANNER_ID = "ios_google_banner_id";
const String IOS_GO_NATIVE_ID = "ios_google_native_unit_id";
//add ads string for Unity ads
const String U_REWARDED_ID = "unity_rewarded_video_id";
const String U_INTER_ID = "unity_interstitial_id";
const String U_BANNER_ID = "unity_banner_id";
const String U_AND_GAME_ID = "android_game_id";
const String IOS_U_REWARDED_ID = "ios_unity_rewarded_video_id";
const String IOS_U_INTER_ID = "ios_unity_interstitial_id";
const String IOS_U_BANNER_ID = "ios_unity_banner_id";
const String IOS_U_GAME_ID = "ios_game_id";

const String ADS_MODE = "in_app_ads_mode";
const String IOS_ADS_MODE = "ios_in_app_ads_mode";
const String ADS_TYPE = "ads_type";
const String IOS_ADS_TYPE = "ios_ads_type";
const String LANGUAGE_ID = "language_id";
const String LANGUAGE = "language";
const String ISRTL = "isRTL";
const String COUNTRY_CODE = "country_code";
const String CODE = "code";
const String DEFAULT_LANG = "default_language";
const String PAGE_CONTENT = "page_content";
const String PAGE_ICON = "page_icon";
const String TERMSPOLICY = "terms_policy";
const String PRIVACYPOLICY = "privacy_policy";
const String ISFROMBACK = "isfrombackground";

//current user param
String CUR_USERID = '0';

String CUR_USERNAME = '';
String CUR_USEREMAIL = '';
String CATID = "";
String? CUR_LANGUAGE_ID;

String category_mode = '';
String comments_mode = '';
String breakingNews_mode = "";
String liveStreaming_mode = "";
String subCategory_mode = "";

String in_app_ads_mode = "";
String ios_in_app_ads_mode = "";

String ads_type = "";
String ios_ads_type = "";

String fbRewardedVideoId = "";
String fbInterstitialId = "";
String fbBannerId = "";
String fbNativeUnitId = "";
String iosFbRewardedVideoId = "";
String iosFbInterstitialId = "";
String iosFbBannerId = "";
String iosFbNativeUnitId = "";

String goRewardedVideoId = "";
String goInterstitialId = "";
String goBannerId = "";
String goNativeUnitId = "";
String iosGoRewardedVideoId = "";
String iosGoInterstitialId = "";
String iosGoBannerId = "";
String iosGoNativeUnitId = "";

String unityGameID = "";
String iosUnityGameID = "";

String unityRewardedVideoId = "";
String unityInterstitialId = "";
String unityBannerId = ""; //"News_Details_Banner_Ad"; //
String iosUnityRewardedVideoId = "";
String iosUnityInterstitialId = "";
String iosUnityBannerId = "";

String token1 = "";
bool? isDark;
bool? notiEnable;
double? deviceHeight;
double? deviceWidth;

//Notification
const String JN_NOTIFICATION_ID = "ID";
const String JN_NOTIFICATION_ICON = "Icon";
const String JN_NOTIFICATION_THUTU = "ThuTu";
const String JN_NOTIFICATION_TIEUDE = "TieuDe";
const String JN_NOTIFICATION_SUBTIEUDE = "SubTieuDe";
const String JN_NOTIFICATION_NOIDUNG = "NoiDung";
const String JN_NOTIFICATION_NGONNGU = "NgonNgu";
const String JN_NOTIFICATION_NGAYTAO = "NgayTaoStr";
const String JN_NOTIFICATION_MALOAI = "MaLoai";
const String JN_NOTIFICATION_TENLOAI = "TenLoai";
const String JN_NOTIFICATION_LICHSUID = "LichSuID";

//Notification Topic
const String JN_NOTIFICATION_TOPIC_MALOAI = "MaLoai";
const String JN_NOTIFICATION_TOPIC_TENLOAI = "TenLoai";
const String JN_NOTIFICATION_TOPIC_TENLOAI_EN = "TenLoai_EN";

