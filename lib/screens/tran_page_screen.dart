import 'package:flutter/material.dart';
import 'package:flutterex/bindings/tran_detail_page_binding.dart';
import 'package:flutterex/controllers/tran_page_controller.dart';
import 'package:flutterex/screens/tran_detail_page_screen.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class TranPageScreen extends StatelessWidget {
  static const routeName = '/tran';

  const TranPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TranPageController controller = Get.find<TranPageController>();

    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: QcText.headline6(controller.title.value),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
            child: FutureBuilder<List<Transition>>(
              future: controller.getTransition(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Transition>> snapshot) {
                //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                if (snapshot.hasData == false) {
                  return Container(
                      child: Center(child: CircularProgressIndicator()));
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
                  List<Transition> items = snapshot.data!;
                  return Container(
                    child: GridView.builder(
                        /**
                       * SliverGridDelegateWithMaxCrossAxisExtent 반응형으로 너비로
                       * ㄴ maxCrossAxisExtent child에게 부여할 최대 width 지정
                       *
                       * SliverGridDelegateWithFixedCrossAxisCount 숫자로
                       * ㄴ crossAxisCount crossAxis 방향으로 몇개의 grid를 배치할 것인지 결정
                       */
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: orientation == Orientation.portrait
                              ? 2
                              : 3, //1 개의 행에 보여줄 item 개수
                          // mainAxisExtent: 256,
                          mainAxisSpacing: 10, //그리드 사이의 수직 간격
                          crossAxisSpacing: 10, // 그리드 사이의 좌우 간격
                          childAspectRatio: 4 / 1, //item 의 가로 1, 세로 2 의 비율
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, position) {
                          Transition item = items[position];
                          return TextButton(
                              onPressed: () async {
                                Get.to(
                                    TranDetailPageScreen(
                                      title: item.name,
                                    ),
                                    transition: item,
                                    binding: TranDetailPageBinding());
                              },
                              style: TextButton.styleFrom(
                                // minimumSize: Size.fromHeight(30),
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                // primary: Colors.teal,
                                // backgroundColor: Colors.white,
                              ),
                              child: QcText.bodyText1(
                                item.name,
                                fontColor:
                                    Theme.of(context).colorScheme.onPrimary,
                              ));
                        }),
                  );
                }
              },
            )),
      ),
    );
  }
}
