import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scannerapp/constants.dart';
import 'package:scannerapp/models/product_model.dart';

class CallAPI {

  // กำหนด header
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };

  // Login User API
  loginAPI(data) async {
    return await http.post(
      Uri.parse('${baseURLAPI}login'),
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  // อ่านข้อมูล product โดยค้นหาจาก barcode
  Future<ProductModel?> getProductByBarcodeAPI(barcode) async {
    final response = await http.get(
      Uri.parse('${baseURLAPI}products/barcode/$barcode'),
      headers: _setHeaders(),
    );
    if(response.body != 'null') {
      return productModelFromJson(response.body);
    } else {
      return null;
    }
  }

}