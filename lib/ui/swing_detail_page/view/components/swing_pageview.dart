import 'package:flutter/material.dart';
import 'package:hackmotion_mobile_developer_homework/models/swing.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_detail_page/view/components/swing_pageview_incicator.dart';
import 'package:hackmotion_mobile_developer_homework/ui/swing_detail_page/view/swing_details_view.dart';

class SwingDetailsPageView extends StatefulWidget {
  final List<CapturedSwing> swings;
  final int swingId;
  const SwingDetailsPageView({
    super.key,
    required this.swings,
    required this.swingId,
  });

  @override
  State<SwingDetailsPageView> createState() => _SwingDetailsPageViewState();
}

class _SwingDetailsPageViewState extends State<SwingDetailsPageView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  List<CapturedSwing> _swingsList = [];
  int _currentPageIndex = 0;
  // late List<bool> _pagesLoaded;
  @override
  initState() {
    super.initState();
    _swingsList = List.from(widget.swings);
    _currentPageIndex = widget.swingId;
    _tabController = TabController(length: _swingsList.length, vsync: this, initialIndex: _currentPageIndex);
    _pageController = PageController(initialPage: _currentPageIndex);
    _updateCurrentPageIndex;
    // _pagesLoaded = List<bool>.filled(widget.swings.length, false);
    // _pagesLoaded[_currentPageIndex] = true;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFefefef),
      appBar: AppBar(
        backgroundColor: const Color(0xFFefefef),
        centerTitle: true,
        title: const Text('Inspection',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        leading: ButtonBar(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left, color: Color(0xFF5874ff)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _swingsList.isEmpty
          ? Container()
          : Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: _handlePageViewChanged,
                    itemBuilder: (context, index) {
                      if (_swingsList.isNotEmpty &&
                          index < _swingsList.length) {
                        final swing = _swingsList[index];
                        return SwingDetailsView(
                          swingsList: widget.swings,
                          swing: swing,
                          onDelete: () => _handleDeleteSwing(swing),
                        );
                      } else {
                        return Container();
                      }
                    }),
                PageIndicator(
                    tabController: _tabController,
                    currentPageIndex: _currentPageIndex,
                    onUpdateCurrentPageIndex: _updateCurrentPageIndex,
                    tabCount: widget.swings.length)
              ],
            ),
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
      // _pagesLoaded[currentPageIndex] = true;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _handleDeleteSwing(CapturedSwing swing) {
    final currentIndex = _swingsList.indexOf(swing);
    setState(() {
      // _pagesLoaded.removeAt(currentIndex);
      _swingsList.remove(swing);
      _tabController = TabController(length: _swingsList.length, vsync: this);
    });

    if (_swingsList.isEmpty) {
      Navigator.pop(context);
    } else {
      int newIndex = currentIndex;
      if (newIndex >= _swingsList.length) {
        newIndex = _swingsList.length - 1;
      }
      _updateCurrentPageIndex(newIndex);
      _pageController.jumpToPage(newIndex);
    }
  }
}
