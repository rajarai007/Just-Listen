class ApiConstants {
  static String BASE_URL_LIVE = 'https://www.mcc.gov.ae/api/v1/';
  static String BASE_URL_STAGING = 'https://dtpstg.admcc.ae/api/v1/';
  static String BASE_URL = BASE_URL_STAGING;
  static String DUMMY_USER_IMAGE =
      'https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2019/11/29/1866666-472213580.jpg?itok=cRkQr6fw';
  static String GET_ACCESS_TOKEN = 'users/allInfo';
  static String GET_USER_DETAILS = "users/details";
  static String GET_USER_PROFILE = "users/profile";
  static String GET_SERVICE_LIST = "items/ServiceCatalog/list";
  static String GET_LICENCED_MEMBERLIST = "company/members";
  static String GET_REPRESENTATIVE_MEMBERLIST = "company/admins";
  static String ADD_COMPANY_PRO_MEMBER = "company/members";
  static String GET_RENEW_LICENSE_FINS = "company/fins";
  static String GET_RENEW_LICENSE_VIOLATION = "violations";
  static String CHECK_LICENSE_MEMBER = "company/member";
  static String ADD_LICENSE_MEMBER = "company/members";
  static String DELETE_COMPANY_MEMBER = "company/member";
  static String RENEW_LICENSING_COMPANY = "company/renew?undefined=undefined";
  static String COMPANY_ENTITIES = "entities";
  static String LICENSES_LIST = "licenses";
  static String TASKS = "tasks";
  static String REQUESTS = "requests";
  static String VIOLATIONS = "violations";
  static String INSPECTION = "inspections";
  static String ANNOUNCEMENTS = "items/Announcements/list";
  static String ANNOUCEMENTS_DOWNLOAD =
      "items/Announcements/list/%s/attachements/";
  static String SUPPLIER_INVOICES = "supplier/invoices";
  static String SUPPLIER_PROJECTS = "supplier/projects";
  static String SUPPLIER_DETAILS = 'supplier/details';
  static String COMPANY_SEND_EMAIL = 'sms/send';
  static String COMPANY_SMS_VERIFY = 'sms/verify';
  static String CONTACT_US = 'contact-us';
  static String SLIDER_IMAGE_NAME =
      "items/BannerSlider/list?expand=AttachmentFiles";
  static String SLIDER_IMAGE_CONTENT =
      "items/BannerSlider/list/1/attachements?fileName=";
  static String ABOUT_US = "items/InformationPages/list";
  static String GUEST_REGULATION = "items/Regulations/list";
  static String REGULATION_DOWNLOAD =
      "items/Regulations/list/14/attachements?fileName=";
}

enum ApiRequest {
  GENERATE_AUTH_CODE,
  GET_UAE_PASS_PROFILE,
  LOGOUT_UAE_PASS,
  GET_ACCESS_TOKEN,
  GET_USER_DETAILS,
  GET_USER_PROFILE,
  GET_SERVICE_LIST,
  GET_LICENCED_MEMBERLIST,
  GET_REPRESENTATIVE_MEMBERLIST,
  ADD_COMPANY_PRO_MEMBER,
  GET_RENEW_LICENSE_FINS,
  GET_RENEW_LICENSE_VIOLATION,
  CHECK_LICENSE_MEMBER,
  ADD_LICENSE_MEMBER,
  DELETE_COMPANY_MEMBER,
  RENEW_LICENSING_COMPANY,
  COMPANY_ENTITIES,
  LICENSES_LIST,
  TASKS,
  REQUESTS,
  VIOLATIONS,
  INSPECTION,
  ANNOUNCEMENTS,
  ANNOUCEMENTS_DOWNLOAD,
  SUPPLIER_INVOICES,
  SUPPLIER_PROJECTS,
  SUPPLIER_DETAILS,
  COMPANY_SEND_EMAIL,
  COMPANY_SMS_VERIFY,
  CONTACT_US,
  SLIDER_IMAGE_NAME,
  SLIDER_IMAGE_CONTENT,
  ABOUT_US,
  GUEST_REGULATION,
  REGULATION_DOWNLOAD
}
