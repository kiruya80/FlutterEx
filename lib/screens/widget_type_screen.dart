import 'package:flutter/material.dart';
import 'package:flutterex/controllers/multi_lang_controller.dart';
import 'package:flutterex/controllers/widget_type_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:get/get.dart';

// 위젯 : https://bsscco.github.io/posts/flutter-layout-widgets/
class WidgetTypeScreen extends StatelessWidget {
  static const routeName = '/widgetType';

  const WidgetTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Print.e("FontScreen =============");
    WidgetTypeController controller = Get.find<WidgetTypeController>();
    return Scaffold(
      appBar: AppBar(
        title:
            QcText.headline6(controller.title.value, fontColor: Colors.white),
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
            color: Colors.white,
            width: Get.width,
            height: Get.height,
            margin:
                const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  QcText.headline3('Row'),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star, size: 50),
                      Icon(Icons.star, size: 100),
                      Icon(Icons.star, size: 50),
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Column'),
                  Column(
                    children: <Widget>[
                      Icon(Icons.star, size: 50),
                      Icon(Icons.star, size: 100),
                      Icon(Icons.star, size: 50),
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Flex'),
                  Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      Icon(Icons.star, size: 50),
                      Icon(Icons.star, size: 100),
                      Icon(Icons.star, size: 50),
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('DecoratedBox'),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        Icon(Icons.star, size: 300), // largest child
                        Icon(Icons.star,
                            size: 50, color: Colors.red), // align center right
                        Positioned(
                            left: 0,
                            top: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned left, top
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned right, top
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned left, bottom
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned right, bottom
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('DecoratedBox'),
                  DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                    child: IndexedStack(
                      index: 1,
                      alignment: FractionalOffset(0.5, 0.5),
                      children: <Widget>[
                        Icon(Icons.star, size: 300), // largest child
                        Icon(Icons.star,
                            size: 50, color: Colors.red), // align center right
                        Positioned(
                            left: 0,
                            top: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned left, top
                        Positioned(
                            right: 0,
                            top: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned right, top
                        Positioned(
                            left: 0,
                            bottom: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned left, bottom
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: Icon(Icons.star,
                                size: 50)), // positioned right, bottom
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('GridView.count'),
                  Container(
                    height: 300,
                    color: Colors.black26,
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20.0),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 2,
                      children: <Widget>[
                        Container(color: Colors.red),
                        Container(color: Colors.red),
                        Container(color: Colors.red),
                        Container(color: Colors.red),
                        Container(color: Colors.red),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('GridView.extent'),
                  Container(
                    height: 300,
                    color: Colors.black26,
                    child: GridView.extent(
                      primary: false,
                      padding: const EdgeInsets.all(20.0),
                      maxCrossAxisExtent: 300,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      children: <Widget>[
                        Container(color: Colors.green),
                        Container(color: Colors.green),
                        Container(color: Colors.green),
                        Container(color: Colors.green),
                        Container(color: Colors.green),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('ListView'),
                  Container(
                    height: 300,
                    color: Colors.black26,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.all(20),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: 200,
                            height: 200,
                            margin: EdgeInsets.only(bottom: 10),
                            color: Colors.red);
                      },
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Table'),
                  Table(
                    border: TableBorder.all(),
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        TableCell(
                            child: Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.red)),
                        TableCell(
                            child: Container(
                                width: double.infinity,
                                height: 100,
                                color: Colors.green)),
                      ]),
                      TableRow(children: <Widget>[
                        TableCell(
                            child: Container(
                                width: double.infinity,
                                height: 100,
                                color: Colors.blue)),
                        TableCell(
                            child: Container(
                                width: double.infinity,
                                height: 150,
                                color: Colors.yellow)),
                      ])
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('PageView'),
                  Container(
                    height: 300,
                    child: PageView(
                      children: <Widget>[
                        Container(
                          color: Colors.red,
                          child: Center(child: Text('Page1')),
                        ),
                        Container(
                          color: Colors.blue,
                          child: Center(child: Text('Page2')),
                        ),
                        Container(
                          color: Colors.green,
                          child: Center(child: Text('Page3')),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('DecoratedBox'),
                  Container(
                    height: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        runSpacing: 40,
                        children: <Widget>[
                          Container(
                              width: 100, height: 100, color: Colors.black),
                          Container(
                              width: 100, height: 100, color: Colors.black),
                          Container(
                              width: 100, height: 100, color: Colors.black),
                          Container(
                              width: 100, height: 100, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('LayoutBuilder'),
                  Container(
                    height: 300,
                    color: Colors.green,
                    child: LayoutBuilder(
                      // LayoutBuilder
                      builder: (context, constraints) {
                        return Stack(
                          children: <Widget>[
                            Positioned(
                                left: 0,
                                top: 0,
                                child: Icon(Icons.star, size: 50)), // left, top
                            Positioned(
                                left: constraints.maxWidth - 50,
                                top: 0,
                                child: Icon(Icons.star, size: 50)), // left, top
                            Positioned(
                                left: 0,
                                top: constraints.maxHeight - 50,
                                child: Icon(Icons.star, size: 50)), // left, top
                            Positioned(
                                left: constraints.maxWidth - 50,
                                top: constraints.maxHeight - 50,
                                child: Icon(Icons.star, size: 50)), // left, top
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Expanded'),
                  Container(
                    height: 300,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(color: Colors.red, height: 50)),
                        Expanded(
                            flex: 2,
                            child: Container(color: Colors.blue, height: 50)),
                        Container(color: Colors.yellow, width: 50, height: 50),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Flexible'),
                  Container(
                    height: 300,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(color: Colors.red, height: 50)),
                        Flexible(
                            fit: FlexFit.loose,
                            flex: 2,
                            child: Container(
                                color: Colors.blue,
                                width: 70,
                                height: 50)), // width가 최대 70으로 제한됨.
                        Container(color: Colors.yellow, width: 50, height: 50),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('IntrinsicHeight 사용 전 '),
                  Container(
                    height: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Row(
                        children: <Widget>[
                          DecoratedBox(
                            decoration: BoxDecoration(color: Colors.red),
                            child: Text('aaa\naaa'),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(color: Colors.green),
                            child: Text('bbb\nbbb\nbbb'),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(color: Colors.blue),
                            child: Text('ccc'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('IntrinsicHeight 사용 후 '),
                  // 이 위젯은 처리비용이 매우 비싸므로 지양해야 합니다.
                  Container(
                    height: 300,
                    child: IntrinsicHeight(
                      child: DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            DecoratedBox(
                              decoration: BoxDecoration(color: Colors.red),
                              child: Text('aaa\naaa'),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(color: Colors.green),
                              child: Text('bbb\nbbb\nbbb'),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(color: Colors.blue),
                              child: Text('ccc'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Align '),
                  Container(
                    height: 300,
                    child: Align(
                      alignment:
                          FractionalOffset(0.5, 1.0), // 수평 중간, 수직 하단에 위치하도록 설정
                      child: Container(
                        height: 40.0,
                        width: 40.0,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Container '),
                  Container(
                    height: 500,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(20),
                            width: 100,
                            height: 100,
                            color: Colors.red,
                            child: Container(color: Colors.white),
                          ),
                          Container(
                              width: 100, height: 100, color: Colors.blue),
                          Container(
                              width: 100, height: 100, color: Colors.green),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('padding '),
                  Container(
                    height: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child:
                            Container(width: 50, height: 50, color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Center '),
                  Container(
                    height: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Center(
                        widthFactor: 2,
                        heightFactor: 3,
                        child:
                            Container(width: 50, height: 50, color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('FittedBox '),
                  Container(
                    height: 300,
                    child: Container(
                      color: Colors.grey,
                      height: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: const Icon(Icons.star, size: 100000),
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('ㅈㅈㅈ '),
                  Container(
                    height: 300,
                    child: Container(
                      color: Colors.grey,
                      height: double.infinity,
                      child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: const Icon(Icons.star, size: 100000),
                      ),
                    ),
                  ),

                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('Transform '),
                  Container(
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationZ(1.0),
                          child: Container(
                              width: 50, height: 50, color: Colors.red),
                        ),
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.skewX(1.0)..translate(50.0),
                          child: Container(
                              width: 50, height: 50, color: Colors.green),
                        ),
                        Container(
                            height: double.infinity,
                            width: 1,
                            color: Colors.black),
                        Container(
                            height: 1,
                            width: double.infinity,
                            color: Colors.black),
                      ],
                    ),
                  ),

                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('RotatedBox '),
                  Container(
                    height: 300,
                    child: RotatedBox(
                      quarterTurns: 1, // 0, 1, 2, 3
                      child: const Text('Hello World!'),
                    ),
                  ),

                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('FractionalTranslation '),
                  Container(
                    height: 300,
                    child: FractionalTranslation(
                      translation: Offset(1, 1),
                      child: const Text('Hello World!'),
                    ),
                  ),

                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('AspectRatio '),
                  Container(
                    height: 300,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey,
                      height: 100,
                      width: 100,
                      child: AspectRatio(
                          aspectRatio: 2 / 1,
                          child: Container(color: Colors.red)),
                    ),
                  ),

                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  QcText.headline3('ConstrainedBox '),
                  Container(
                      height: 300,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 300,
                          maxWidth: double.infinity,
                          minHeight: 300,
                          maxHeight: double.infinity,
                        ),
                        child: Card(color: Colors.blue, child: Text('AAA')),
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
