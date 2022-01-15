import 'package:flutter/material.dart';
 import 'package:mms_app/app/colors.dart';
import 'package:mms_app/app/size_config/extensions.dart';
import '../../app/size_config/config.dart';

class FloatingNavBar extends StatefulWidget {
  final List<FloatingNavBarItem> items;

  const FloatingNavBar({Key? key,  required this.items});

  @override
  _FloatingNavBarState createState() {
    return _FloatingNavBarState();
  }
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  PageController bottomNavbarController = PageController(initialPage: 1);
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: bottomNavbarController,
              children: widget.items.map((item) => item.page).toList(),
              onPageChanged: (index) => _changePage(index),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20.h,
              child: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.h),
                  ),
                  child: Container(
                    height: 65.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.h),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 2],
                          colors: <Color>[
                            Color(0xff432FBF),
                            Color(0xffE86FCE),
                          ],
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _widgetsBuilder(widget.items),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _floatingNavBarItem(FloatingNavBarItem item, int index) {
    return FutureBuilder(
        future: Future.value(true),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  _changePage(index);
                },
                child: Container(
                  padding: EdgeInsets.all(10.h),
                  width: 50.h,
                  decoration: BoxDecoration(
                      color: currentIndex == index
                          ? AppColors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16.h)),
                  child: currentIndex != index
                      ? Icon(
                          item.img,
                          size: 24.h,
                          color: Colors.white,
                        )
                      : RadiantGradientMask(
                          child: Icon(
                            item.img,
                            size: 24.h,
                            color: Color(0xffE86FCE),
                          ),
                        ),
                ),
              ),
            ],
          );
        });
  }

  List<Widget> _widgetsBuilder(List<FloatingNavBarItem> items) {
    List<Widget> _floatingNavBarItems = [];
    for (int i = 0; i < items.length; i++) {
      Widget item = this._floatingNavBarItem(items[i], i);
      _floatingNavBarItems.add(item);
    }
    return _floatingNavBarItems;
  }

  _changePage(index) async {
    currentIndex = index;
    bottomNavbarController.jumpToPage(index);
    setState(() {});
  }
}

void moveUp(ScrollController control) {
  if (control.hasClients)
    control.animateTo(control.position.minScrollExtent - 60,
        curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
}

class FloatingNavBarItem {
  IconData img;
  Widget page;

  FloatingNavBarItem({required this.img, required this.page});
}

class RadiantGradientMask extends StatelessWidget {
  const RadiantGradientMask({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Color(0xFF8F51B1),
          Color(0xffE86FCE),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
