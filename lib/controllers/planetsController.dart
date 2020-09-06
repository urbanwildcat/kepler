import 'package:get/get.dart';
import 'package:kepler/api/api.dart';
import 'package:kepler/models/planets.dart';

class PlanetsController extends GetxController {
  static PlanetsController get to => Get.find();

  final RxString search = "".obs;

  Future<List<PlanetData>> getAllPlanets() async {
    List<PlanetData> _planets = await API.getAllPlanets();
    return _planets;
  }

  Future<List<PlanetData>> getPlanetsByName(String name) async {
    List<PlanetData> _planets = await API.getPlanetsByName(name);
    print(_planets);
    return _planets;
  }

  bool find(String name) {
    if (search.isNullOrBlank)
      return true;
    else if (name.toLowerCase().contains(search.value.toLowerCase()))
      return true;
    else
      return false;
  }

  void upd() {
    update();
  }
}
