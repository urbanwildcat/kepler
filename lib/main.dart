import 'package:flare_flutter/flare_cache.dart';
import 'package:flare_flutter/provider/asset_flare.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kepler/controllers/favoritesController.dart';
import 'package:kepler/controllers/settingsController.dart';
import 'package:kepler/locale/translations.dart';
import 'package:kepler/models/planetData.dart';
import 'package:kepler/models/starData.dart';
import 'package:kepler/theme/theme.dart';
import 'package:kepler/views/home/homeView.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() async {
  await _initializeApp().then((_) {
    runApp(GetMaterialApp(
      title: string.text('app_title'),
      theme: KeplerTheme.theme,
      debugShowCheckedModeBanner: false,
      supportedLocales: string.supportedLocales(),
      home: HomeView(),
      builder: (context, child) {
        return KeplerTheme.builder(child);
      },
    ));
  });
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Hive.initFlutter();
  await string.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SyncfusionLicense.registerLicense(
      "NT8mJyc2IWhia31hfWN9Z2doYmF8YGJ8ampqanNiYmlmamlmanMDHmg0JiAnMiU8PjImITowOjw3NjEyISE8IBM0PjI6P30wPD4=");
  FlareCache.doesPrune = false;
  await _warmupFlare();
  Get.put<FavoritesController>(FavoritesController());
  Get.put<SettingsController>(SettingsController());
  Hive.registerAdapter(PlanetDataAdapter());
  Hive.registerAdapter(StarDataAdapter());
}

final _assetsToWarmup = [
  AssetFlare(bundle: rootBundle, name: "assets/flare/shine.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/clouds.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/land.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/pops.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/holes.flr"),
  AssetFlare(bundle: rootBundle, name: "assets/flare/gas.flr"),
];

Future<void> _warmupFlare() async {
  for (final asset in _assetsToWarmup) {
    await cachedActor(asset);
  }
}
