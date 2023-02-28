import 'package:dars_currency/core/api/api_base.dart';
import 'package:dars_currency/core/api/currency_api.dart';
import 'package:dars_currency/core/hive/api_hive.dart';
import 'package:dars_currency/core/hive/hive_base.dart';
import 'package:dars_currency/core/hive/user_hive.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> setup() async {
  await EasyLocalization.ensureInitialized();

  di.registerSingleton(HiveBase());
  await di.get<HiveBase>().init();
  di.registerFactory(() => ApiHive(di.get<HiveBase>().apiBox));
  di.registerFactory(() => UserHive(di.get<HiveBase>().userBox));

  di.registerSingleton(
    ApiBase(Dio(BaseOptions(
      baseUrl: "https://cbu.uz",
      connectTimeout: const Duration(seconds: 60),
    ))),
  );
  di.registerFactory(() => CurrencyApi(di.get()));
}
