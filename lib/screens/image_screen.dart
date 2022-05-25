import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/image_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

class ImageScreen extends StatelessWidget {
  static const routeName = '/image';

  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageController controller = Get.find<ImageController>();
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
            // width: Get.width,
            // height: Get.height,
            // margin:
            //     const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ExtendedImage.network(
                    'https://picsum.photos/id/421/200/200',
                    width: 200,
                    fit: BoxFit.fill,
                    border: Border.all(color: Colors.red, width: 1.0),
                    shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    cache: true,
                    loadStateChanged: (ExtendedImageState state) {
                      // switch (state.extendedImageLoadState) {
                      //   case LoadState.loading:
                      //     QcLog.e("image file loading...");
                      //     break;
                      //   case LoadState.completed:
                      //     QcLog.e("image file load completed!!");
                      //     _controller.forward();
                      //     return FadeTransition(
                      //         opacity: _controller,
                      //         child: ExtendedRawImage(
                      //           image: state.extendedImageInfo?.image,
                      //           width: 100,
                      //           height: 100,
                      //         ));
                      //   case LoadState.failed:
                      //     QcLog.e("image file load FAIL!!!");
                      //     _controller.reset();
                      //     break;
                      // }
                      switch (state.extendedImageLoadState) {
                        // 이미지 로딩 중일 경우 로딩 애니메이션 표시
                        case LoadState.loading:
                          return LoadingFadingLine.circle(
                            backgroundColor: Theme.of(context).primaryColor,
                          );
                          break;
                        case LoadState.completed:
                          break;
                        case LoadState.failed:
                          break;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExtendedImage.network(
                    "https://i.pinimg.com/originals/e9/73/0a/e9730ab2e35d7ec8ac7e432099b5e6d9.gif",
                    width: 200,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    cache: true,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
