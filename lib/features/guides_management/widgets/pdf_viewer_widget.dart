import 'package:flutter/material.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/core/constants/katkoot_elwadi_icons.dart';
import 'package:katkoot_elwady/features/app_base/screens/main_bottom_app_bar.dart';
import 'package:katkoot_elwady/features/app_base/view_models/base_view_model.dart';
import 'package:katkoot_elwady/features/app_base/widgets/custom_text.dart';
import 'package:katkoot_elwady/features/guides_management/mixins/pdf_mixin.dart';
import 'package:katkoot_elwady/features/menu_management/screens/change_language_screen.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/di/injection_container.dart' as di;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PdfViewer extends StatefulWidget {
  static const routeName = "./pdf-viewer";

  final String previewUrl;
  final String printUrl;
  bool isLoading = false;
  bool showPrintBtn = false;
  bool showErrorMsg = false;

  PdfViewer({required this.previewUrl, required this.printUrl});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> with PdfMixin, BaseViewModel {
  @override
  void initState() {
    togglePrintVisibility(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          // appBar: BackAppBar(),
          body: SafeArea(
            child: Container(
                color: AppColors.white,
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    (!widget.showErrorMsg)
                        ? SfPdfViewer.network(
                            widget.previewUrl,
                            canShowScrollHead: false,
                            canShowScrollStatus: true,
                            canShowPaginationDialog: true,
                            pageLayoutMode: PdfPageLayoutMode.continuous,
                            enableDoubleTapZooming: true,
                            onDocumentLoadFailed: (error) {
                              toggleShowErrorMsg();
                              togglePrintVisibility(false);
                            },
                            onDocumentLoaded: (document) {
                              togglePrintVisibility(true);
                            },
                          )
                        : Center(
                            child: CustomText(
                              textAlign: TextAlign.center,
                              fontSize: 18,
                              textColor: AppColors.APPLE_GREEN.withOpacity(0.6),
                              title: 'str_general_error'.tr(),
                              maxLines: 10,
                              fontWeight: FontWeight.bold,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                            ),
                          ),
                    IconButton(
                        onPressed: () async {
                          if (await onWillPop()) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Container(
                          padding: EdgeInsetsDirectional.all(2),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.Pastel_gray.withOpacity(0.5)),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )),
          ),
          floatingActionButton: widget.showPrintBtn
              ? FloatingActionButton(
                  child: !widget.isLoading
                      ? Icon(
                          KatkootELWadyIcons.print,
                          size: 25,
                          color: AppColors.white_smoke,
                        )
                      : CircularProgressIndicator(
                          color: AppColors.white_smoke,
                        ),
                  onPressed: () {
                    if (widget.isLoading) return;
                    togglePrintBtnState();
                    downloadPdf();
                  },
                  backgroundColor: AppColors.DARK_SPRING_GREEN,
                )
              : Container()),
    );
  }

  Future downloadPdf() async {
    await downloadPdfAndPrint(widget.printUrl);
    togglePrintBtnState();
  }

  void togglePrintBtnState() {
    setState(() {
      widget.isLoading = !widget.isLoading;
    });
  }

  void togglePrintVisibility(bool status) {
    setState(() {
      widget.showPrintBtn = status;
    });
  }

  void toggleShowErrorMsg() {
    setState(() {
      widget.showErrorMsg = !widget.showErrorMsg;
    });
  }

  Future<bool> onWillPop() async {
    if (di.appRedirectedFromNotificationNotifier.value) {
      if (await ProviderScope.containerOf(context,
          listen: false).read(di.changeLanguageViewModelProvider.notifier)
          .isOnBoardingComplete()) {
        navigateToScreen(MainBottomAppBar.routeName, removeTop: true);
      } else {
        navigateToScreen(ChangeLanguageScreen.routeName, removeTop: true);
      }
      di.appRedirectedFromNotificationNotifier.value = false;
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
