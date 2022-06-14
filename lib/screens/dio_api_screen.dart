import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/dio_api_controller.dart';
import 'package:flutterex/datas/model/api_item.dart';
import 'package:flutterex/screens/components/api_item.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

/// 샘플 url
/// https://jsonplaceholder.typicode.com/
///
class DioApiScreen extends StatelessWidget {
  static const routeName = '/dioApi';

  const DioApiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DioApiController controller = Get.find<DioApiController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: QcText.headline6(controller.title.value),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          // maintainBottomViewPadding 키보드가 올라온 경우 밀어낼지 덮을지 결정
          // maintainBottomViewPadding: false,
          child: Container(
              color: Theme.of(context).colorScheme.background,
              width: Get.width,
              height: Get.height,
              child: FutureBuilder<List<ApiItem>>(
                future: controller.makeApiData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ApiItem>> snapshot) {
                  //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                  if (snapshot.hasData == false) {
                    return Container(
                        child: Center(
                      child:
                          // CircularProgressIndicator()
                          LoadingFilling.square(
                        borderSize: 10,
                        borderColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        fillingColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ));
                  } else if (snapshot.hasError) {
                    return Container(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ));
                  } else {
                    List<ApiItem> items = snapshot.data!;
                    return Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int position) {
                          ApiItem item = items[position];

                          return Column(
                            children: <ApiListItemForm>[
                              ApiListItemForm(
                                item: item,
                                callback: (_item) async {
                                  QcLog.e('callback =============== $_item');
                                  controller.makeApi(context, item);
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              )),
        ),
      );
    });
  }
}
