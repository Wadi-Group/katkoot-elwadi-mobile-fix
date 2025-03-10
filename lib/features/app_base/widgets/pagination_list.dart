import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/active_button.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
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

  PaginationList({
    this.onLoadMore,
    this.onRefresh,
    this.hasMore,
    this.shrinkWrap,
    this.scrollController,
    required this.itemBuilder,
    this.itemCount = 0,
    this.loading = false,
    this.loadingPlaceholder,
    this.placeholderHeight,
    this.padding,
  }) : assert(loadingPlaceholder == null || placeholderHeight != null,
            "loadingPlaceholder needs placeholderHeight");

  @override
  PaginationListState createState() => PaginationListState();
}

class PaginationListState extends State<PaginationList> {
  late ScrollController _scrollController;
  bool showLoadMoreButton = false;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 10) {
      if (!showLoadMoreButton && (widget.hasMore ?? false)) {
        setState(() {
          showLoadMoreButton = true;
        });
      }
    }
  }

  Future<void> loadMore() async {
    if (widget.onLoadMore != null && (widget.hasMore ?? false)) {
      setState(() {
        isLoadingMore = true;
      });

      await widget.onLoadMore!();

      setState(() {
        isLoadingMore = false;
        showLoadMoreButton = false; // Hide button after loading
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var placeHolder = widget.loadingPlaceholder;
    var height = widget.placeholderHeight;
    var crossFadeState =
        (widget.loading && placeHolder != null && height != null)
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond;

    return AnimatedCrossFade(
      firstChild: widget.loading ? AppLoader() : SizedBox(),
      secondChild: getList(),
      crossFadeState: crossFadeState,
      duration: const Duration(milliseconds: 700),
    );
  }

  Widget getList() {
    return Builder(
      builder: (cx) => Container(
        height:
            (widget.shrinkWrap ?? false) ? null : MediaQuery.of(cx).size.height,
        child: RefreshIndicator(
          onRefresh: widget.onRefresh ?? () async {},
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  physics: (widget.shrinkWrap ?? false)
                      ? NeverScrollableScrollPhysics()
                      : AlwaysScrollableScrollPhysics(),
                  padding: widget.padding,
                  shrinkWrap: widget.shrinkWrap ?? false,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return widget.itemBuilder(context, index);
                  },
                  itemCount: widget.itemCount,
                ),
              ),
              if (showLoadMoreButton &&
                  (widget.hasMore ??
                      false)) // Show load more button when reaching end
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isLoadingMore
                      ? CircularProgressIndicator(
                          color: AppColors.APP_BLUE,
                        )
                      : ElevatedButton(
                          onPressed: isLoadingMore ? null : loadMore,
                          child: CustomText(
                            title: "load_more".tr(),
                            textColor: AppColors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.APP_BLUE,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
