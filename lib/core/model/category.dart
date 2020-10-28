import 'package:flutter/cupertino.dart';

class Category {
  String id;
  String name;
  IconData icon;
  String iconUrl;

  Category({
    this.id,
    this.name,
    this.icon,

    this.iconUrl,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];

    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['icon_url'] = this.iconUrl;
    return data;
  }
}
