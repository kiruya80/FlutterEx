import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterex/controllers/home_controller.dart';
import 'package:flutterex/datas/model/home_item.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:flutterex/utils/print_log.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class HomeListItemCardForm extends StatefulWidget {
  final HomeItem item;

  const HomeListItemCardForm({Key? key, required this.item}) : super(key: key);

  @override
  _HomeListItemCardFormState createState() => _HomeListItemCardFormState(item);
}

class _HomeListItemCardFormState extends State<HomeListItemCardForm>
    with TickerProviderStateMixin {
  final homeController = Get.find<HomeController>();

  HomeItem item;

  _HomeListItemCardFormState(this.item);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // 내부 컨테이너에 라운드 처리 방법 none > hardEdge > antiAlias >>>>>> antiAliasWithSaveLayer
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: InkWell(
          onTap: () {
            QcLog.e("item.routeName == ${item.routeName}");
            Get.toNamed(item.routeName, arguments: {'name': item.name});
          },
          child: GridTile(
            header: GridTileBar(
              backgroundColor: Colors.black26,
              title: QcText.subtitle1('header'),
              subtitle: QcText.caption('Item ${item.name}'),
              leading: IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
              trailing: IconButton(
                icon: Icon(Icons.shopping_bag_outlined),
                onPressed: () {},
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black38,
              title: QcText.subtitle1('footer'),
              subtitle: QcText.caption('Item ${item.name}'),
            ),
            child: Center(
                child: QcText.headline6(
              item.name,
              fontColor: Theme.of(context).colorScheme.onSurfaceVariant,
            )),
          ),
        ));

    // return ClipRRect(
    //     // margin: const EdgeInsets.all(8),
    //     // elevation: 5,
    //     borderRadius: BorderRadius.circular(10),
    //     // shape: RoundedRectangleBorder(
    //     //     borderRadius: BorderRadius.circular(20),
    //     //     side: BorderSide(
    //     //       width: 2,
    //     //       color: Colors.blue,
    //     //       style: BorderStyle.solid,
    //     //     )),
    //     // shape: RoundedRectangleBorder(
    //     //   borderRadius: BorderRadius.circular(10),
    //     // ),
    //     // color: Theme.of(context).colorScheme.surfaceVariant,
    //     child: new InkWell(
    //         borderRadius: BorderRadius.circular(10),
    //         onTap: () {
    //           QcLog.e("item.routeName == ${item.routeName}");
    //           Get.toNamed(item.routeName, arguments: {'name': item.name});
    //         },
    //         child: GridTile(
    //           header: GridTileBar(
    //             backgroundColor: Colors.black26,
    //             title: const Text('header'),
    //             subtitle: Text('Item ${item.name}'),
    //             leading: IconButton(
    //               icon: Icon(Icons.favorite),
    //               onPressed: () {},
    //             ),
    //             trailing: IconButton(
    //               icon: Icon(Icons.shopping_bag_outlined),
    //               onPressed: () {},
    //             ),
    //           ),
    //           footer: GridTileBar(
    //             backgroundColor: Colors.black38,
    //             title: const Text('footer'),
    //             subtitle: Text('Item ${item.name}'),
    //           ),
    //           child: Center(
    //               child: QcText.headline6(
    //             item.name,
    //             fontColor: Theme.of(context).colorScheme.onSurfaceVariant,
    //           )),
    //           // child: GestureDetector(
    //           //   onTap: () {},
    //           //   child: Image.network(
    //           //     listing.coverPhoto,
    //           //     fit: BoxFit.cover,
    //           //   ),
    //           // ),
    //         )
    //     ));
  }
}
