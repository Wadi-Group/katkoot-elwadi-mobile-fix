import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/katkoot_elwadi_icons.dart';

class PdfViewer extends StatefulWidget {
  static const routeName = "./pdf-viewer";

  final String previewUrl;
  final String printUrl;

  PdfViewer({required this.previewUrl, required this.printUrl});

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  String? _localFilePath;
  bool _isLoading = true;
  bool _hasError = false;
  bool _isDownloading = false;
  bool _showPrintBtn = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  /// Generate a unique filename based on the URL
  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        widget.previewUrl.split('/').last; // Extract filename from URL
    return File('${directory.path}/$fileName');
  }

  /// Load the PDF (Check local storage first)
  Future<void> _loadPdf() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final localFile = await _getLocalFile();

      if (localFile.existsSync()) {
        setState(() {
          _localFilePath = localFile.path;
          _isLoading = false;
          _showPrintBtn = true;
        });
      } else if (connectivityResult != ConnectivityResult.none) {
        await _downloadPdf(widget.previewUrl, localFile);
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  /// Download the PDF and save it locally
  Future<void> _downloadPdf(String url, File file) async {
    try {
      setState(() {
        _isDownloading = true;
      });

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        setState(() {
          _localFilePath = file.path;
          _isLoading = false;
          _showPrintBtn = true;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.white,
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _hasError
                      ? Center(
                          child: Text(
                            'str_general_error'.tr(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  AppColors.APPLE_GREEN.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : SfPdfViewer.file(File(_localFilePath!)),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.Pastel_gray.withValues(alpha: 0.6),
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _showPrintBtn
          ? FloatingActionButton(
              child: !_isDownloading
                  ? Icon(
                      KatkootELWadyIcons.print,
                      size: 25,
                      color: AppColors.white_smoke,
                    )
                  : CircularProgressIndicator(color: AppColors.white_smoke),
              onPressed: () async {
                if (!_isDownloading) {
                  final localFile = await _getLocalFile();
                  await _downloadPdf(widget.printUrl, localFile);
                }
              },
              backgroundColor: AppColors.DARK_SPRING_GREEN,
            )
          : null,
    );
  }
}
