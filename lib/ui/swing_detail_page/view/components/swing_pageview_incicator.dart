import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.tabCount,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final int tabCount;

  bool _previousButtonEnabled() {
    return currentPageIndex > 0;
  }

  bool _nextButtonEnabled() {
    return currentPageIndex < tabCount - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
                visible: _previousButtonEnabled(),
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: GestureDetector(
                    onTap: () {
                      if (currentPageIndex > 0) {
                        onUpdateCurrentPageIndex(currentPageIndex - 1);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          color: Color(0xFF5874ff),
                          size: 20.0,
                        ),
                        // Text("Previous Swing"),
                      ]),
                    ))),
            TabPageSelector(
              controller: tabController,
              color: const Color(0xFF5874ff).withOpacity(0.3),
              borderStyle: BorderStyle.none,
              selectedColor: const Color(0xFF5874ff),
              indicatorSize: 6,
            ),
            Visibility(
                visible: _nextButtonEnabled(),
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: GestureDetector(
                  onTap: () {
                    if (currentPageIndex < tabCount - 1) {
                      onUpdateCurrentPageIndex(currentPageIndex + 1);
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        // Text("Next Swing"),
                        Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF5874ff),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}