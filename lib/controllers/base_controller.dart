import 'package:flutter/material.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

abstract class BaseController extends FullLifeCycleController
    with FullLifeCycleMixin {
  var title = "title".obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    QcLog.e('args : $args');

    try {
      final title = args['title'];
      this.title.value = title;
    } catch (e) {
      debugPrint('onInit error : $e');
    }

    init();
  }

  void init() {}

  /// detached(suspending): 모든 뷰가 제거되고 플러터 엔진만 동작 중이며 앱이 종료되기 직전에 실행된다.
  @override
  void onDetached() {
    debugPrint("onDetached");
  }

  /// inactive: 앱이 비활성화되고 유저의 인풋에 반응할 수 없다.
  /// AND : inactive > paused
  @override
  void onInactive() {
    debugPrint("onInactive");
  }

  /// paused: 앱이 유저에게 보이지 않고, 유저의 인풋에 반응할 수 없으며 백그라운드로 동작한다. (보통 inactive 이후 실행)
  @override
  void onPaused() {
    debugPrint("onPaused");
  }

  /// resumed: 앱이 화면에 다시 보이기 시작하는 경우, 유저의 인풋에 반응할 수 있다.
  @override
  void onResumed() {
    debugPrint("onResumed");
  }
}
