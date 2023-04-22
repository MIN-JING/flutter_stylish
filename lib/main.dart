import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/bloc/application_bloc.dart';
import 'package:flutter_minjing_stylish/page/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Provider<ApplicationBloc>(
    create: (_) => ApplicationBloc(),
    child: MyApp(
        ApplicationBloc()), // Add ApplicationBloc as a positional argument
  ));
}

class MyApp extends StatefulWidget {
  final ApplicationBloc bloc;

  const MyApp(this.bloc, {Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ApplicationBloc>(context);
    return MaterialApp(
      title: 'Jim Flutter Stylish App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
          title: 'Home',
          homeData: bloc.homeData,),
    );
  }
}
