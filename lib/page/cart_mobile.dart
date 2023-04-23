import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/application_bloc.dart';

class CartMobile extends StatefulWidget {
  const CartMobile({Key? key}) : super(key: key);

  @override
  State<CartMobile> createState() => _CartMobileState();
}

class _CartMobileState extends State<CartMobile> {
  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<ApplicationBloc>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 32),
            buildCartTitle(),
            const SizedBox(height: 32),
            buildProductList(appBloc),
          ],
        ),
      ),
    );
  }

  Widget buildCartTitle() {
    return const Text(
      "購物車",
      style: TextStyle(fontSize: 32, color: Colors.black),
    );
  }

  Widget buildProductList(ApplicationBloc appBloc) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: appBloc.cart.products.length,
      itemBuilder: (context, index) {
        return buildCartItem(appBloc, index);
      },
    );
  }

  Widget buildCartItem(ApplicationBloc appBloc, int index) {
    return Card(
      child: ListTile(
        title: Text(appBloc.cart.products[index].title),
        subtitle: Text(
            appBloc.cart.products[index].price.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            appBloc.cart.removeProduct(
                appBloc.cart.products[index]);
          },
        ),
      ),
    );
  }
}

// class CartMobile extends StatefulWidget {
//   const CartMobile({Key? key}) : super(key: key);
//
//   @override
//   State<CartMobile> createState() => _CartMobileState();
// }
//
// class _CartMobileState extends State<CartMobile> {
//   @override
//   Widget build(BuildContext context) {
//     final appBloc = Provider.of<ApplicationBloc>(context);
//
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
//       child: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
//             const Text(
//               "購物車",
//               style: TextStyle(fontSize: 32, color: Colors.black),
//             ),
//             const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
//             ListView.builder(
//               primary: false,
//               shrinkWrap: true,
//               itemCount: appBloc.cart.products.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(appBloc.cart.products[index].name),
//                     subtitle: Text(
//                         appBloc.cart.products[index].price.toString()),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () {
//                         appBloc.cart.removeProduct(
//                             appBloc.cart.products[index]);
//                       },
//                     ),
//                   ),
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
