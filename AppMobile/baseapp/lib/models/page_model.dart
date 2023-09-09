import 'string.dart';

class PageModel {
  String? id, pageContent, title, image;

  PageModel({this.id, this.pageContent, this.title, this.image});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return new PageModel(
      id: json[ID],
      pageContent: json[PAGE_CONTENT],
      title: json[TITLE],
      image: json[PAGE_ICON],
    );
  }
}
