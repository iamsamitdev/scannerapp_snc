import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    String? id;
    String? productDetail;
    String? productName;
    String? productBarcode;
    String? productQty;
    String? productPrice;
    DateTime? productDate;
    String? productImage;
    String? productCategory;
    String? productStatus;

    ProductModel({
        this.id,
        this.productDetail,
        this.productName,
        this.productBarcode,
        this.productQty,
        this.productPrice,
        this.productDate,
        this.productImage,
        this.productCategory,
        this.productStatus,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        productDetail: json["product_detail"],
        productName: json["product_name"],
        productBarcode: json["product_barcode"],
        productQty: json["product_qty"],
        productPrice: json["product_price"],
        productDate: json["product_date"] == null ? null : DateTime.parse(json["product_date"]),
        productImage: json["product_image"],
        productCategory: json["product_category"],
        productStatus: json["product_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_detail": productDetail,
        "product_name": productName,
        "product_barcode": productBarcode,
        "product_qty": productQty,
        "product_price": productPrice,
        "product_date": "${productDate!.year.toString().padLeft(4, '0')}-${productDate!.month.toString().padLeft(2, '0')}-${productDate!.day.toString().padLeft(2, '0')}",
        "product_image": productImage,
        "product_category": productCategory,
        "product_status": productStatus,
    };
}
