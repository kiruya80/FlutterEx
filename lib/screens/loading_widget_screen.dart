import 'package:flutter/material.dart';
import 'package:flutterex/controllers/loading_widget_controller.dart';
import 'package:flutterex/screens/components/loading/bouncing_grid_circle_tab.dart';
import 'package:flutterex/screens/components/loading/bouncing_grid_square_tab.dart';
import 'package:flutterex/screens/components/loading/bouncing_line_circle_tab.dart';
import 'package:flutterex/screens/components/loading/bouncing_line_square_tab.dart';
import 'package:flutterex/screens/components/loading/bumping_line_circle_tab.dart';
import 'package:flutterex/screens/components/loading/bumping_line_square_tab.dart';
import 'package:flutterex/screens/components/loading/double_flipping_circle_tab.dart';
import 'package:flutterex/screens/components/loading/double_flipping_square_tab.dart';
import 'package:flutterex/screens/components/loading/fading_line_circle_tab.dart';
import 'package:flutterex/screens/components/loading/fading_line_square_tab.dart';
import 'package:flutterex/screens/components/loading/filling_square_tab.dart';
import 'package:flutterex/screens/components/loading/flipping_circle_tab.dart';
import 'package:flutterex/screens/components/loading/flipping_square_tab.dart';
import 'package:flutterex/screens/components/loading/jumping_line_circle_tab.dart';
import 'package:flutterex/screens/components/loading/jumping_line_square_tab.dart';
import 'package:flutterex/screens/components/loading/rotating_square_tab.dart';
import 'package:flutterex/widget/text_widget.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';

class LoadingWidgetScreen extends StatelessWidget {
  static const routeName = '/loading';

  const LoadingWidgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoadingWidgetController controller = Get.find<LoadingWidgetController>();
    return DefaultTabController(
        length: 16,
        child: Scaffold(
            appBar: AppBar(
              title: QcText.headline6(controller.title.value),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: TabBar(
                  isScrollable: true,
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  tabs: <Widget>[
                    Tab(
                      child: LoadingBumpingLine.circle(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingBumpingLine.square(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingFadingLine.circle(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingFadingLine.square(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingBouncingLine.circle(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingBouncingLine.square(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingJumpingLine.circle(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingJumpingLine.square(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingFlipping.circle(
                        size: 30,
                        borderColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingFlipping.square(
                        size: 30,
                        borderColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingRotating.square(
                        size: 30,
                        borderColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingFilling.square(
                        size: 30,
                        borderColor: Theme.of(context).colorScheme.error,
                        fillingColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingDoubleFlipping.circle(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingDoubleFlipping.square(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingBouncingGrid.circle(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Tab(
                      child: LoadingBouncingGrid.square(
                        size: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                BumpingLineCircleExample(),
                BumpingLineSquareExample(),
                FadingLineCircleExample(),
                FadingLineSquareExample(),
                BouncingLineCircleExample(),
                BouncingLineSquareExample(),
                JumpingLineCircleExample(),
                JumpingLineSqaureExample(),
                FlippingCircleExample(),
                FlippingSquareExample(),
                RotatingSquareExample(),
                FillingSquareExample(),
                DoubleFlippingCircleExample(),
                DoubleFlippingSquareExample(),
                BouncingGridCircleExample(),
                BouncingGridSquareExample(),
              ],
            )));
  }
}
