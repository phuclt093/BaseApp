import 'string.dart';

class LanguageModel {
  String? id, language, image, code, isRtl, contryCode;

  LanguageModel(
      {this.id,
      this.image,
      this.language,
      this.code,
      this.contryCode,
      this.isRtl});

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return new LanguageModel(
      id: json[ID],
      image: json[IMAGE],
      language: json[LANGUAGE],
      code: json[CODE],
      isRtl: json[ISRTL],
      contryCode: json[COUNTRY_CODE],
    );
  }
}
