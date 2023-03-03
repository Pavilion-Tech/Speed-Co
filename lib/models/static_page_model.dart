class StaticPageModel {
  String? message;
  bool? status;
  StaticPageData? data;

  StaticPageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new StaticPageData.fromJson(json['data']) : null;
  }

}

class StaticPageData {
  String? termsAndConditiondsEn;
  String? termsAndConditiondsAr;
  String? aboutUsEn;
  String? aboutUsAr;
  String? contactUsEn;
  String? contactUsAr;


  StaticPageData.fromJson(Map<String, dynamic> json) {
    termsAndConditiondsEn = json['terms_and_conditionds_en'];
    termsAndConditiondsAr = json['terms_and_conditionds_ar'];
    aboutUsEn = json['about_us_en'];
    aboutUsAr = json['about_us_ar'];
    contactUsEn = json['contact_us_en'];
    contactUsAr = json['contact_us_ar'];
  }

}
