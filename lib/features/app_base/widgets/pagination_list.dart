import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:lottie/lottie.dart';

import 'app_loader.dart';

class PaginationList extends StatefulWidget {
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool? hasMore;
  final bool? shrinkWrap;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool loading;
  final ScrollController? scrollController;
  final Widget? loadingPlaceholder;
  final int? placeholderHeight;
  final EdgeInsetsGeometry? padding;

  PaginationList(
      {this.onLoadMore,
        this.onRefresh,
        this.hasMore,
        this.shrinkWrap,
        this.scrollController,
        required this.itemBuilder,
        this.itemCount = 0,
        this.loading = false,
        this.loadingPlaceholder,
        this.placeholderHeight,
        this.padding})
      : assert(loadingPlaceholder == null || placeholderHeight != null,
  "loadingPlaceholder needs placeholderHeight");

  @override
  PaginationListState createState() {
    return PaginationListState();
  }
}

class PaginationListState extends State<PaginationList>
    with SingleTickerProviderStateMixin {
  // var loadingMoreNotifier = ValueNotifier(false);
  late AnimationController controller;
  late ScrollController _scrollController = widget.scrollController ?? ScrollController();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 250),
        lowerBound: 0.0,
        upperBound: 1.0);
    addPaginationListener();
  }

  startLoadingMore() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    controller.forward().whenComplete(() {
      _scrollController.animateTo(maxScroll + 50,
          duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    });
  }

  stopLoadingMore() {
    controller.reverse();
  }

  Future<void> addPaginationListener() async {
    _scrollController.addListener(() async {
      var pos = _scrollController.position;
      var onLoadMore = widget.onLoadMore;
      if (pos.pixels == pos.maxScrollExtent &&
          (widget.hasMore ?? true) &&
          onLoadMore != null) {
        startLoadingMore();
        await onLoadMore();
        stopLoadingMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var placeHolder = widget.loadingPlaceholder;
    var height = widget.placeholderHeight;
    var crossFadeState = (widget.loading && placeHolder != null && height != null)
        ? CrossFadeState.showFirst
        : CrossFadeState.showSecond;
    return AnimatedCrossFade(
        firstChild: widget.loading ? AppLoader() : SizedBox(),
        secondChild: getList(),
        crossFadeState: crossFadeState,
        duration: const Duration(milliseconds: 700)
    );
  }

  Widget getList() {
    var list = ListView.builder(
      physics: (widget.shrinkWrap ?? false) ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
      padding: widget.padding,
      shrinkWrap: widget.shrinkWrap ?? false,
      controller: widget.scrollController == null ? _scrollController : null,
      itemBuilder: (context, index) {
        if (widget.itemCount > 0 && index == widget.itemCount) {
          return AnimatedBuilder(
            animation: controller,
            builder: (_, child) {
              return SizedBox(
                height: controller.value * 50,
                width: controller.value * 50,
                child: child,
              );
            },
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.OLIVE_DRAB,
              ),
            ),
          );
        }
        return widget.itemBuilder(context, index);
      },
      itemCount: (widget.itemCount > 0 && (widget.hasMore ?? false))
          ? (widget.itemCount + 1)
          : widget.itemCount,
    );
    var onRefresh = widget.onRefresh;
    return Builder(
      builder: (cx) => Container(
        height: (widget.shrinkWrap ?? false) ? null: MediaQuery.of(cx).size.height,
        child: onRefresh != null
            ? RefreshIndicator(
          onRefresh: onRefresh,
          child: list,
        )
            : list,
      ),
    );
  }
}
