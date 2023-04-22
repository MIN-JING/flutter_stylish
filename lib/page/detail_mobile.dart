import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/clothes.dart';
import 'package:provider/provider.dart';

import '../bloc/application_bloc.dart';
import 'cart_mobile.dart';

class DetailMobile extends StatefulWidget {
  final ClothesItem clothesItem;
  const DetailMobile({super.key, required this.clothesItem});

  @override
  State<DetailMobile> createState() => _DetailMobileState();
}

class _DetailMobileState extends State<DetailMobile> {
  void _addItemToCart() {
    setState(() {
      Provider.of<ApplicationBloc>(context, listen: false)
          .addClothesItem(widget.clothesItem);
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
                height: 500,
                child: Image.asset(
                  widget.clothesItem.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.clothesItem.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26)),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                widget.clothesItem.id.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ]),
            const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                widget.clothesItem.price.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ]),
            const Divider(
              color: Colors.grey, // Customize the divider color
              thickness: 2, // Customize the divider thickness
              height: 32, // Customize the space around the divider
            ),
            Row(
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
                      color: Colors.grey, // Customize the divider color
                      thickness: 2, // Customize the divider thickness
                      width: 32, // Customize the space around the divider
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.clothesItem.colors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              log('Color Item $index clicked');
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: widget.clothesItem.colors[index],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  )
                ]),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "尺寸",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                    child: VerticalDivider(
                      color: Colors.grey, // Customize the divider color
                      thickness: 2, // Customize the divider thickness
                      width: 32, // Customize the space around the divider
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.clothesItem.sizes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              log('Color Item $index clicked');
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                              child: Container(
                                width: 30,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  widget.clothesItem.sizes[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ));
                      },
                    ),
                  )
                ]),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "數量",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                    child: VerticalDivider(
                      color: Colors.grey, // Customize the divider color
                      thickness: 2, // Customize the divider thickness
                      width: 32, // Customize the space around the divider
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrease,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (String quantity) {
                        setState(() {
                          _quantity = int.tryParse(quantity) ?? 0;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _increase,
                  ),
                ]),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            DecoratedBox(
                decoration: const BoxDecoration(color: Colors.grey),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      log('加入購物車');
                      _addItemToCart();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartMobile(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      disabledForegroundColor:
                          Colors.transparent, // Disabled background color
                      elevation: 0, // Removes the shadow
                    ),
                    child: const Text('請選擇尺寸',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ),
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.clothesItem.colorHint,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(widget.clothesItem.material,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('厚薄：${widget.clothesItem.thickLevel}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.normal)),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('彈性：${widget.clothesItem.flexibility}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('素材產地/${widget.clothesItem.materialOrigin}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text('加工產地/${widget.clothesItem.processOrigin}',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    child: ShaderMask(
                      shaderCallback: ((bounds) {
                        return const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.green,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          tileMode: TileMode.repeated,
                        ).createShader(bounds);
                      }),
                      child: const Text('細部說明',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.fromLTRB(16, 0, 0, 0)),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Divider(
                        color: Colors.grey, // Customize the divider color
                        thickness: 2, // Customize the divider thickness
                        height: 4, // Customize the space around the divider
                      ),
                    ],
                  )
                ]),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            const Text(
                'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            SizedBox(
                height: 200,
                child: Image.asset(
                  widget.clothesItem.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            SizedBox(
                height: 200,
                child: Image.asset(
                  widget.clothesItem.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            SizedBox(
                height: 200,
                child: Image.asset(
                  widget.clothesItem.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 16, 0, 0)),
            SizedBox(
                height: 200,
                child: Image.asset(
                  widget.clothesItem.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}
