
import 'package:flutterex/bindings/home_binding.dart';
import 'package:flutterex/screens/home_screen.dart';
import 'package:get/get.dart';


class GetXRouterContainer {
  GetXRouterContainer() {
    // Get.put(SessionBinding());
  }

  final allPageRouter = [

    GetPage(
        name: HomeScreen.routeName,
        page: () => HomeScreen(),
        binding: HomeBinding()),


  ];
}
