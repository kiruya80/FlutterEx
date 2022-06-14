import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/hero_page_controller.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';

class HeroPageScreen extends StatelessWidget {
  static const routeName = '/image/heropage';

  const HeroPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HeroPageController controller = Get.find<HeroPageController>();

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
            // height: Get.height,
            // margin:
            //     const EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'imageHero1',
                    child: ExtendedImage.network(
                      // "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDA3MjNfODgg%2FMDAxNTk1NDM5Mjk2MTE1.zh8K_CtdNlKg-bHQCl0v1ZXyu4bDcShJ6G4Yup7Xc7Eg.HDOiH7OblrhJuunJePvu4_LJmujoI1X6JDT2mqsJrT8g.JPEG.tg4946%2F2019_07_21_10_17_IMG_8595.JPG&type=sc960_832",
                      // "https://i.pinimg.com/originals/e9/73/0a/e9730ab2e35d7ec8ac7e432099b5e6d9.gif",
                      'https://picsum.photos/id/421/200/200',
                      width: 500,
                      fit: BoxFit.fill,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      cache: true,
                    ),
                  ),
                ],
              ),
            )
            // child: Hero(
            //   tag: 'imageHero',
            //   child: ExtendedImage.network(
            //     "https://search.pstatic.net/common/?src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDA3MjNfODgg%2FMDAxNTk1NDM5Mjk2MTE1.zh8K_CtdNlKg-bHQCl0v1ZXyu4bDcShJ6G4Yup7Xc7Eg.HDOiH7OblrhJuunJePvu4_LJmujoI1X6JDT2mqsJrT8g.JPEG.tg4946%2F2019_07_21_10_17_IMG_8595.JPG&type=sc960_832",
            //     width: Get.width,
            //     // shape: BoxShape.rectangle,
            //     // borderRadius: BorderRadius.all(Radius.circular(15.0)),
            //     cache: true,
            //   ),
            // ),
            ),
      ),
    );
  }
}
