import 'package:get/get.dart';
import 'package:htttp/pages/home.dart';

class Routes {
  static List<GetPage> get pages => [
        GetPage(name: '/home', page: () => HomeScreen()),
      ];
}
