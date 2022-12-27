class Product {
  int? totalSize;
  int? typeId;
  int? offset;
  late List<Products> products;

  Product({required this.totalSize, required this.typeId, required this.offset, required this.products});

  List<Products> get GetProducts => products;

  Product.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products.add(Products.fromJson(v));
      });
    }
  }

  
}

class Products {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  Products(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

}

// {
//     "total_size": 6,
//     "type_id": 2,
//     "offset": 0,
//     "products": [
//         {
//             "id": 1,
//             "name": "Sadqwwdqwd",
//             "description": "LongText",
//             "price": 12,
//             "stars": 5,
//             "img": "path/to/img",
//             "location": "china",
//             "created_at": "2021-12-27 06:35:34",
//             "updated_at": "2021-12-27 08:35:34",
//             "type_id": 2
//         }
//     ]
// }