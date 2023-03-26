import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/widget/banner_widget.dart';
import 'package:flutter_minjing_stylish/model/banner.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish from Jim',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '商品概覽'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: TopBanner.items.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Center(
                      // height: 80,
                      // color: Colors.white,
                      child: Image.asset(TopBanner.items[index].imageUrl),
                    ));
                  }),
            ),
            // Row(mainAxisSize: MainAxisSize.min, children: [
            //   SizedBox(
            //     height: 100,
            //     width: double.infinity,
            //     child: ListView.builder(
            //       itemCount: TopBanner.items.length,
            //       itemBuilder: (context, index) {
            //         return
            //             BannerItemWidget(item: TopBanner.items[index]);
            //             Card(
            //               child: Container(
            //                 height: 80,
            //                 color: Colors.white,
            //                 child: Image.asset(TopBanner.items[index].imageUrl),
            //           ),
            //         );
            //       },
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: true,
            //     ),
            //   )
            // ]),
          ],
        ),
      ),
    );
  }
}
