import 'dart:convert';
GetMyCartModel getMyCartModelFromJson(String str) => GetMyCartModel.fromJson(json.decode(str));
String getMyCartModelToJson(GetMyCartModel data) => json.encode(data.toJson());
class GetMyCartModel {
  GetMyCartModel({
      int? status,
    num? totalPrice,
      int? totalPages, 
      List<Carts>? carts,}){
    _status = status;
    _totalPrice = totalPrice;
    _totalPages = totalPages;
    _carts = carts;
}

  GetMyCartModel.fromJson(dynamic json) {
    _status = json['status'];
    _totalPrice = json['totalPrice'];
    _totalPages = json['totalPages'];
    if (json['carts'] != null) {
      _carts = [];
      json['carts'].forEach((v) {
        _carts?.add(Carts.fromJson(v));
      });
    }
  }
  int? _status;
  num? _totalPrice;
  int? _totalPages;
  List<Carts>? _carts;

  int get status => _status ?? 0;
  num get totalPrice => _totalPrice ?? 0;
  int get totalPages => _totalPages ?? 0;
  List<Carts> get carts => _carts ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['totalPrice'] = _totalPrice;
    map['totalPages'] = _totalPages;
    if (_carts != null) {
      map['carts'] = _carts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Carts cartsFromJson(String str) => Carts.fromJson(json.decode(str));
String cartsToJson(Carts data) => json.encode(data.toJson());
class Carts {
  Carts({
      int? id, 
      Product? product, 
      int? productId, 
      int? quantity, 
      int? totalQuantity, 
      dynamic description, 
      int? price, 
      List<dynamic>? features,}){
    _id = id;
    _product = product;
    _productId = productId;
    _quantity = quantity;
    _totalQuantity = totalQuantity;
    _description = description;
    _price = price;
    _features = features;
}

  Carts.fromJson(dynamic json) {
    _id = json['id'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _productId = json['productId'];
    _quantity = json['quantity'];
    _totalQuantity = json['totalQuantity'];
    _description = json['description'];
    _price = json['price'];
    // if (json['features'] != null) {
    //   _features = [];
    //   json['features'].forEach((v) {
    //     _features?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  int? _id;
  Product? _product;
  int? _productId;
  int? _quantity;
  int? _totalQuantity;
  dynamic _description;
  num? _price;
  List<dynamic>? _features;

  int get id => _id ?? 0;
  Product get product => _product ?? Product();
  int get productId => _productId ?? 0;
  int get quantity => _quantity ?? 0;
  int get totalQuantity => _totalQuantity ?? 0;
  dynamic get description => _description ?? [];
  num get price => _price ?? 0;
  List<dynamic> get features => _features ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    map['productId'] = _productId;
    map['quantity'] = _quantity;
    map['totalQuantity'] = _totalQuantity;
    map['description'] = _description;
    map['price'] = _price;
    if (_features != null) {
      map['features'] = _features?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      int? id, 
      String? barcode, 
      String? name, 
      String? description,
    num? price,
      bool? isFreeDelivered, 
      List<String>? images, 
      dynamic store, 
      int? quantity, 
      dynamic brand, 
      List<Prices>? prices, 
      bool? isFav, 
      bool? hasOffer, 
      int? point, 
      List<dynamic>? features, 
      int? viewers,}){
    _id = id;
    _barcode = barcode;
    _name = name;
    _description = description;
    _price = price;
    _isFreeDelivered = isFreeDelivered;
    _images = images;
    _store = store;
    _quantity = quantity;
    _brand = brand;
    _prices = prices;
    _isFav = isFav;
    _hasOffer = hasOffer;
    _point = point;
    _features = features;
    _viewers = viewers;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _barcode = json['barcode'];
    _name = json['name'];
    _description = json['description'];
    _price = json['price'];
    _isFreeDelivered = json['isFreeDelivered'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _store = json['store'];
    _quantity = json['quantity'];
    _brand = json['brand'];
    if (json['prices'] != null) {
      _prices = [];
      json['prices'].forEach((v) {
        _prices?.add(Prices.fromJson(v));
      });
    }
    _isFav = json['isFav'];
    _hasOffer = json['hasOffer'];
    _point = json['point'];
    // if (json['features'] != null) {
    //   _features = [];
    //   json['features'].forEach((v) {
    //     _features?.add(Dynamic.fromJson(v));
    //   });
    // }
    _viewers = json['viewers'];
  }
  int? _id;
  String? _barcode;
  String? _name;
  String? _description;
  num? _price;
  bool? _isFreeDelivered;
  List<String>? _images;
  dynamic _store;
  int? _quantity;
  dynamic _brand;
  List<Prices>? _prices;
  bool? _isFav;
  bool? _hasOffer;
  int? _point;
  List<dynamic>? _features;
  int? _viewers;

  int get id => _id ?? 0;
  String get barcode => _barcode ?? '';
  String get name => _name ?? '';
  String get description => _description ?? '';
  num get price => _price ?? 0;
  bool get isFreeDelivered => _isFreeDelivered ?? false;
  List<String> get images => _images ?? [];
  dynamic get store => _store ?? [];
  int get quantity => _quantity ?? 0;
  dynamic get brand => _brand ?? [];
  List<Prices> get prices => _prices ?? [];
  bool get isFav => _isFav ?? false;
  bool get hasOffer => _hasOffer ?? false;
  int get point => _point ?? 0;
  List<dynamic> get features => _features ?? [];
  int get viewers => _viewers ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['barcode'] = _barcode;
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['isFreeDelivered'] = _isFreeDelivered;
    map['images'] = _images;
    map['store'] = _store;
    map['quantity'] = _quantity;
    map['brand'] = _brand;
    if (_prices != null) {
      map['prices'] = _prices?.map((v) => v.toJson()).toList();
    }
    map['isFav'] = _isFav;
    map['hasOffer'] = _hasOffer;
    map['point'] = _point;
    if (_features != null) {
      map['features'] = _features?.map((v) => v.toJson()).toList();
    }
    map['viewers'] = _viewers;
    return map;
  }

}

Prices pricesFromJson(String str) => Prices.fromJson(json.decode(str));
String pricesToJson(Prices data) => json.encode(data.toJson());
class Prices {
  Prices({
      int? id,
    num? price,
      dynamic name, 
      int? quantity, 
      String? image,}){
    _id = id;
    _price = price;
    _name = name;
    _quantity = quantity;
    _image = image;
}

  Prices.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _name = json['name'];
    _quantity = json['quantity'];
    _image = json['image'];
  }
  int? _id;
  num? _price;
  dynamic _name;
  int? _quantity;
  String? _image;

  int get id => _id ?? 0;
  num get price => _price ?? 0;
  dynamic get name => _name ?? [];
  int get quantity => _quantity ?? 0;
  String get image => _image ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['name'] = _name;
    map['quantity'] = _quantity;
    map['image'] = _image;
    return map;
  }

}