import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scannerapp/services/rest_api.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {

  // สร้างตัวแปร formProductKey ไว้ผูกกับ Form
  final formProductKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า barcode
  String barcode = '';

  // สร้างตัวแปรไว้เก็บข้อมูล productList ที่อ่านได้
  var productList = [];

  // สร้างตัวแปรไว้รับค่าจากคีย์ที่กด
  List<LogicalKeyboardKey> keys = [];

  final barcodeFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    barcodeFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      // autofocus: true,
      focusNode: FocusNode(),
      onKey: (event) async {
        final key  = event.logicalKey; // รับค่าจากคีย์ที่กด
        if(event is RawKeyDownEvent) {
          // print('key: $key');
          // เช็คว่ามีการกด keys เดิมไปหรือยัง
          if (keys.contains(key)) return;

          // Enter
          if(event.isKeyPressed(LogicalKeyboardKey.enter)){
            // print('Enter');
            // เมื่อมีการ Enter ให้ทำการตรวจสอบค่า barcode ในระบบ
            if(formProductKey.currentState!.validate()) {
              formProductKey.currentState!.save();
              // print('barcode: $barcode');
              // Call API อ่านข้อมูล product โดยค้นหาจาก barcode
              var product = await CallAPI().getProductByBarcodeAPI(barcode);
              if(product != null) {
                // print(product.toJson());
                // เพิ่มข้อมูล product ลงในตัวแปร product
                setState(() {
                  productList.add(product);
                });
              }
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product List (ตัดเบิก)'),
        ),
        body: Column(
          children: [
            Form(
              key: formProductKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: barcodeFocusNode,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Barcode',
                        prefixIcon: Icon(
                          Icons.barcode_reader,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLength: 13,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'กรุณากรอก barcode';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        barcode = value!;
                        // clear ค่า barcode
                        formProductKey.currentState!.reset();
                        // focus ไปที่ barcode อีกครั้ง
                        FocusScope.of(context).requestFocus(barcodeFocusNode);
                      },
                    ),
                  ],
                ),
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        productList[index].productImage,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: Text(productList[index].productName),
                      subtitle: Text(productList[index].productBarcode),
                      trailing: Text(productList[index].productQty.toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}