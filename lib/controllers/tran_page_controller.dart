import 'package:flutterex/controllers/base_controller.dart';
import 'package:get/get.dart';

class TranPageController extends BaseController {
  Future<List<Transition>> getTransition() async {
    List<Transition> tranItems = [];

    tranItems.add(Transition.fade);
    tranItems.add(Transition.fadeIn);
    tranItems.add(Transition.rightToLeft);
    tranItems.add(Transition.leftToRight);
    tranItems.add(Transition.upToDown);
    tranItems.add(Transition.downToUp);
    tranItems.add(Transition.rightToLeftWithFade);
    tranItems.add(Transition.leftToRightWithFade);
    tranItems.add(Transition.zoom);
    tranItems.add(Transition.topLevel);
    tranItems.add(Transition.noTransition);
    tranItems.add(Transition.cupertino);
    tranItems.add(Transition.cupertinoDialog);
    tranItems.add(Transition.size);
    tranItems.add(Transition.circularReveal);
    tranItems.add(Transition.native);

    return tranItems;
  }
}
