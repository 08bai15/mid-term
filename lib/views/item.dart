class items {
  String? userId;
  String? itemname;
  String? itemtype;
  String? itemdesc;
  String? itemprice;
  String? itemqty;
  String? latitude;
  String? longitude;
  String? state;
  String? locality;


  items(
      {this.userId,
      this.itemname,
      this.itemtype,
      this.itemdesc,
      this.itemprice,
      this.itemqty,
      this.latitude,
      this.longitude,
      this.state,
      this.locality,});

  items.fromJson(Map<String, dynamic> json) {
     userId = json['user_id'];
    itemname = json['item_name'];
    itemtype = json['item_type'];
    itemdesc = json['item_desc'];
    itemprice = json['item_price'];
    itemqty = json['item_qty'];
    latitude = json['item_lat'];
    longitude = json['item_long'];
    state = json['item_state'];
    locality = json['item_locality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['item_name'] = itemname;
    data['item_type'] = itemtype;
    data['item_desc'] = itemdesc;
    data['item_price'] = itemprice;
    data['item_qty'] = itemqty;
    data['item_lat'] = latitude;
    data['item_long'] = longitude;
    data['item_state'] = state;
    data['item_locality'] = locality;
    return data;
  }
}