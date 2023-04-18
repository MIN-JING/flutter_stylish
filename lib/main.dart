import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/bloc/app_bloc.dart';
import 'package:flutter_minjing_stylish/home/home.dart';
import 'package:flutter_minjing_stylish/model/clothes.dart';
import 'package:provider/provider.dart';

import 'model/market_campaign.dart';

void main() {
  // runApp(MyApp(ApplicationBloc()));
  runApp(Provider<ApplicationBloc>(
    create: (_) => ApplicationBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  final ApplicationBloc bloc;

  const MyApp(this.bloc, {super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);
    return MaterialApp(
      title: 'Flutter Stylish Jim App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValueListenableBuilder<List<MarketCampaign>>(
        valueListenable: bloc.marketCampaignsNotifier,
        builder: (context, marketCampaigns, _) {
          return ValueListenableBuilder<List<ClothesItem>>(
            valueListenable: bloc.clothesItemsNotifier,
            builder: (context, clothesItems, _) {
              return HomePage(
                title: 'Home Page',
                marketCampaigns: marketCampaigns,
                clothesItems: clothesItems,
              );
            },
          );
        },
      ),
    );
  }
}

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Stylish Jim App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: ValueListenableBuilder<List<MarketCampaign>>(
//         valueListenable: widget.bloc.marketCampaignsNotifier,
//         builder: (context, marketCampaigns, _) {
//           return ValueListenableBuilder<List<ClothesItem>>(
//             valueListenable: widget.bloc.clothesItemsNotifier,
//             builder: (context, clothesItems, _) {
//               return HomePage(
//                 title: 'Application Bloc Home Page',
//                 marketCampaigns: marketCampaigns,
//                 clothesItems: clothesItems,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MyApp(bloc: GeneralBloc()));
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   // final BaseBloc<dynamic> bloc;

//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         // BlocProvider<BaseBloc<dynamic>>(create: (context) => bloc),
//         BlocProvider<ApplicationBloc>(create: (context) => ApplicationBloc()),
//         BlocProvider<ClothesCategoryBloc>(
//             create: (context) => ClothesCategoryBloc()),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Stylish Jim App',
//         theme: ThemeData(
//           useMaterial3: true,
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
//         ),
//         home: const HomePage(title: '商品概覽'),
//       ),
//     );
//   }
// }
