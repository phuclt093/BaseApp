class ChuDe {
  int? id;
  String? ten;
  String? tenEn;
  String? tenFile;
  String? icon;
  int? soLuong;
  int? soLuongTinChuaXem;
  int? tongSo;
  String? lastOperator;
  String? registerDate;
  String? lastDate;
  String? pGID;
  String? dataVersion;

  ChuDe(
      {this.id,
      this.ten,
      this.tenEn,
      this.tenFile,
      this.icon,
      this.soLuong,
      this.soLuongTinChuaXem,
      this.tongSo,
      this.lastOperator,
      this.registerDate,
      this.lastDate,
      this.pGID,
      this.dataVersion});

  ChuDe.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ten = json['ten'];
    tenEn = json['ten_en'];
    tenFile = json['tenFile'];
    icon = json['icon'];
    soLuong = json['soLuong'];
    soLuongTinChuaXem = json['soLuongTinChuaXem'];
    tongSo = json['tongSo'];
    lastOperator = json['lastOperator'];
    registerDate = json['registerDate'];
    lastDate = json['lastDate'];
    pGID = json['pG_ID'];
    dataVersion = json['dataVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ten'] = this.ten;
    data['ten_en'] = this.tenEn;
    data['tenFile'] = this.tenFile;
    data['icon'] = this.icon;
    data['soLuong'] = this.soLuong;
    data['soLuongTinChuaXem'] = this.soLuongTinChuaXem;
    data['tongSo'] = this.tongSo;
    data['lastOperator'] = this.lastOperator;
    data['registerDate'] = this.registerDate;
    data['lastDate'] = this.lastDate;
    data['pG_ID'] = this.pGID;
    data['dataVersion'] = this.dataVersion;
    return data;
  }
}
