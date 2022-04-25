class CountryListData {
  bool? error;
  String? msg;
  List<Data>? data;

  CountryListData({this.error, this.msg, this.data});

  CountryListData.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? iso2;
  String? iso3;
  String? country;
  List<String>? cities;

  Data({this.iso2, this.iso3, this.country, this.cities});

  Data.fromJson(Map<String, dynamic> json) {
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    country = json['country'];
    cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['country'] = this.country;
    data['cities'] = this.cities;
    return data;
  }
}
