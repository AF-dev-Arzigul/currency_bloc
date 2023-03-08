import 'package:dars_currency/di.dart';
import 'package:dars_currency/pages/main/bloc/main_bloc.dart';
import 'package:dars_currency/pages/main/main_page.dart';
import 'package:dars_currency/test_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(
    EasyLocalization(
      path: 'assets/tr',
      supportedLocales: const [
        Locale("uz", "UZ"),
        Locale("uz", "UZC"),
        Locale("ru", "RU"),
        Locale("en", "EN"),
      ],
      startLocale: const Locale("uz", "UZ"),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: "/",
      routes: {
        "/": (context) {
          return BlocProvider(
            create: (_) => MainBloc(di.get())..add(MainGetLastEvent()),
            child: const MainPage(),
          );
        },
      },
    );
  }
}
