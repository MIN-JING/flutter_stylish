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

  // setState(() {
  //   _tappayMessage = message;
  // });
}

// class _DetailMobileState extends State<DetailMobile> {
//   void _addItemToCart() {
//     setState(() {
//       Provider.of<ApplicationBloc>(context, listen: false)
//           .addClothesItem(widget.product);
//     });
//   }
//
//   TextEditingController _controller = TextEditingController();
//   int _quantity = 0;
//
//   void _increase() {
//     setState(() {
//       _quantity++;
//       _controller.text = _quantity.toString();
//     });
//   }
//
//   void _decrease() {
//     setState(() {
//       if (_quantity == 0) {
//         return;
//       }
//       _quantity--;
//       _controller.text = _quantity.toString();
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = TextEditingController(text: _quantity.toString());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             SizedBox(
//                 height: 500,
//                 child: Image.asset(
//                   widget.product.main_image,
//                   height: double.infinity,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(widget.product.title,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 26)),
//               ],
//             ),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Text(
//                 widget.product.id.toString(),
//                 style: const TextStyle(fontSize: 20),
//               ),
//             ]),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Text(
//                 widget.product.price.toString(),
//                 style:
//                     const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//               ),
//             ]),
//             const Divider(
//               color: Colors.grey, // Customize the divider color
//               thickness: 2, // Customize the divider thickness
//               height: 32, // Customize the space around the divider
//             ),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "顏色",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                     child: VerticalDivider(
//                       color: Colors.grey, // Customize the divider color
//                       thickness: 2, // Customize the divider thickness
//                       width: 32, // Customize the space around the divider
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       physics: const ClampingScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: widget.product.colors.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                             onTap: () {
//                               log('Color Item $index clicked');
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
//                               child: Container(
//                                 width: 20,
//                                 height: 20,
//                                 decoration: BoxDecoration(
//                                   color: widget.product.colors[index],
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(0, 1),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ));
//                       },
//                     ),
//                   )
//                 ]),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "尺寸",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                     child: VerticalDivider(
//                       color: Colors.grey, // Customize the divider color
//                       thickness: 2, // Customize the divider thickness
//                       width: 32, // Customize the space around the divider
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       physics: const ClampingScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: widget.product.sizes.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                             onTap: () {
//                               log('Color Item $index clicked');
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
//                               child: Container(
//                                 width: 30,
//                                 height: 22,
//                                 decoration: BoxDecoration(
//                                   color: Colors.blueGrey,
//                                   borderRadius: BorderRadius.circular(50),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       spreadRadius: 1,
//                                       blurRadius: 1,
//                                       offset: const Offset(0, 1),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Text(
//                                   widget.product.sizes[index],
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ));
//                       },
//                     ),
//                   )
//                 ]),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "數量",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   const SizedBox(
//                     height: 16,
//                     child: VerticalDivider(
//                       color: Colors.grey, // Customize the divider color
//                       thickness: 2, // Customize the divider thickness
//                       width: 32, // Customize the space around the divider
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.remove),
//                     onPressed: _decrease,
//                   ),
//                   SizedBox(
//                     width: 50,
//                     child: TextField(
//                       controller: _controller,
//                       keyboardType: TextInputType.number,
//                       textAlign: TextAlign.center,
//                       onChanged: (String quantity) {
//                         setState(() {
//                           _quantity = int.tryParse(quantity) ?? 0;
//                         });
//                       },
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.add),
//                     onPressed: _increase,
//                   ),
//                 ]),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             DecoratedBox(
//                 decoration: const BoxDecoration(color: Colors.grey),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       log('加入購物車');
//                       _addItemToCart();
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const CartMobile(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       disabledBackgroundColor: Colors.transparent,
//                       disabledForegroundColor:
//                           Colors.transparent, // Disabled background color
//                       elevation: 0, // Removes the shadow
//                     ),
//                     child: const Text('請選擇尺寸',
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 )),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(widget.product.colorHint,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal,
//                     )),
//               ],
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Text(widget.product.material,
//                   style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal)),
//             ]),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text('厚薄：${widget.product.thickLevel}',
//                     style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.black,
//                         fontWeight: FontWeight.normal)),
//               ],
//             ),
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Text('彈性：${widget.product.flexibility}',
//                   style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal)),
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Text('素材產地/${widget.product.materialOrigin}',
//                   style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal)),
//             ]),
//             Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Text('加工產地/${widget.product.processOrigin}',
//                   style: const TextStyle(
//                       fontSize: 18,
//                       color: Colors.black,
//                       fontWeight: FontWeight.normal)),
//             ]),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 32,
//                     child: ShaderMask(
//                       shaderCallback: ((bounds) {
//                         return const LinearGradient(
//                           colors: [
//                             Colors.blue,
//                             Colors.green,
//                           ],
//                           begin: Alignment.centerLeft,
//                           end: Alignment.centerRight,
//                           tileMode: TileMode.repeated,
//                         ).createShader(bounds);
//                       }),
//                       child: const Text('細部說明',
//                           style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.normal)),
//                     ),
//                   ),
//                   const Padding(padding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Divider(
//                         color: Colors.grey, // Customize the divider color
//                         thickness: 2, // Customize the divider thickness
//                         height: 4, // Customize the space around the divider
//                       ),
//                     ],
//                   )
//                 ]),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             const Text(
//                 'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
//                 style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.black,
//                     fontWeight: FontWeight.normal)),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             SizedBox(
//                 height: 200,
//                 child: Image.asset(
//                   widget.product.imageUrl,
//                   height: double.infinity,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             SizedBox(
//                 height: 200,
//                 child: Image.asset(
//                   widget.product.imageUrl,
//                   height: double.infinity,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             SizedBox(
//                 height: 200,
//                 child: Image.asset(
//                   widget.product.imageUrl,
//                   height: double.infinity,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
//             SizedBox(
//                 height: 200,
//                 child: Image.asset(
//                   widget.product.imageUrl,
//                   height: double.infinity,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
