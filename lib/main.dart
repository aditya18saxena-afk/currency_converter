import 'package:currency_converter/currency_converter_material_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp()); 
}

//types of widget
//1.StatelessWidget - immutable state
//2.StatefulWidget - mutable state
//3.InheritedWidget

//state - some data which ur widget will care about 

//Material design 
// cupertino design 

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  // const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1C1044),
        ),
        useMaterial3: true,
      ),
      home: const CurrConvMatePage(),
    );
  }
}