class SettingsModel {
  String? message;
  bool? status;
  SettingsData? data;


  SettingsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? SettingsData.fromJson(json['data']) : null;
  }

}

class SettingsData {
  String? projectLogo;
  int? isProjectInFactoryMode;
  String? projectMainBackgroundColor;
  String? projectMainTextColor;
  String? projectWhatsAppNumber;
  String? projectPhoneNumber;
  String? projectEmailAddress;
  String? projectFacebookLink;
  String? projectTwitterLink;
  String? projectInstagramLink;
  int? shippingChargers;
  int? vatValue;

  SettingsData.fromJson(Map<String, dynamic> json) {
    projectLogo = json['project_logo'];
    isProjectInFactoryMode = json['is_project_In_factory_mode'];
    projectMainBackgroundColor = json['project_main_background_color'];
    projectMainTextColor = json['project_main_text_color'];
    projectWhatsAppNumber = json['project_whats_app_number'];
    projectPhoneNumber = json['project_phone_number'];
    projectEmailAddress = json['project_email_address'];
    projectFacebookLink = json['project_facebook_link'];
    projectTwitterLink = json['project_twitter_link'];
    projectInstagramLink = json['project_instagram_link'];
    shippingChargers = json['shipping_chargers'];
    vatValue = json['vat_value'];
  }
}
