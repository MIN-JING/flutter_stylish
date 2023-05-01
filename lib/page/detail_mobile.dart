import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../bloc/application_bloc.dart';
import '../model/product.dart';

const platform = MethodChannel('com.example.myapp/string');

class DetailMobile extends StatefulWidget {
  final Product product;
  const DetailMobile({super.key, required this.product});

  @override
  State<DetailMobile> createState() => _DetailMobileState();
}

class _DetailMobileState extends State<DetailMobile> {

  void _addItemToCart() {
    setState(() {
      Provider.of<ApplicationBloc>(context, listen: false)
          .addProduct(widget.product);
    });
  }

  TextEditingController _controller = TextEditingController();
  int _quantity = 0;

  void _increase() {
    setState(() {
      _quantity++;
      _controller.text = _quantity.toString();
    });
  }

  void _decrease() {
    setState(() {
      if (_quantity == 0) {
        return;
      }
      _quantity--;
      _controller.text = _quantity.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _quantity.toString());

    _receiveStringFromAndroid();
    _sendStringToAndroid('Hello from Jim Flutter App');
    _inputCreditCard();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            buildProductImage(),
            const SizedBox(height: 24),
            buildProductTitle(),
            const SizedBox(height: 8),
            buildProductId(),
            const SizedBox(height: 32),
            buildProductPrice(),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              height: 32,
            ),
            buildColorRow(),
          ],
        ),
      ),
    );
  }

  Widget buildProductImage() {
    return SizedBox(
      height: 500,
      child: Image.network(
        widget.product.main_image,
        height: double.infinity,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildProductTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(widget.product.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 26)),
      ],
    );
  }

  Widget buildProductId() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.product.id.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Widget buildProductPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.product.price.toString(),
          style:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }

  Widget buildColorRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "顏色",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 16,
          child: VerticalDivider(
            color: Colors.grey,
            thickness: 2,
            width: 32,
          ),
        ),
        SizedBox(
          height: 20,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.product.colors.length,
            itemBuilder: (context, index) {
              // Add your color display logic here
              if (kDebugMode) {
                print(widget.product.colors[index]);
              }
            },
          ),
        ),
      ],
    );
  }
}

Future<void> _receiveStringFromAndroid() async {
  String stringValue;

  try {
    stringValue = await platform.invokeMethod('getString');
  } on PlatformException catch (e) {
    stringValue = "Failed to get string: '${e.message}'.";
  }

  if (kDebugMode) {
    print(stringValue);
  }
}

Future<void> _sendStringToAndroid(String stringToSend) async {
  try {
    await platform.invokeMethod('sendString', {'stringValue': stringToSend});
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("Failed to send string: '${e.message}'.");
    }
  }
}

Future<void> _inputCreditCard() async {
  String message;

  try {
    final String result = await platform.invokeMethod('tappay');
    message = result;
  } on PlatformException catch (e) {
    message = e.message ?? '';
  }

  if (kDebugMode) {
    print('inputCreditCard message = $message');
  }
}