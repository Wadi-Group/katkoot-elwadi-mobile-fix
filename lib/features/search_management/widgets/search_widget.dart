import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/core/constants/app_colors.dart';
import 'package:katkoot_elwady/features/app_base/widgets/app_text_field.dart';

import '../../../core/di/injection_container.dart' as di;

class SearchWidget extends StatefulWidget {
  final Function()? onSearchSubmit;

  const SearchWidget({
    Key? key,
    required this.onSearchSubmit,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.text = ProviderScope.containerOf(context, listen: false)
        .read(di.searchContentProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 10),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            onSubmitted: () {
              FocusManager.instance.primaryFocus?.unfocus();

              ProviderScope.containerOf(context, listen: false)
                  .read(di.searchContentProvider.state)
                  .state = searchController.text;
              if (widget.onSearchSubmit != null) widget.onSearchSubmit!();
            },
            contentPadding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
            controller: searchController,
            backgroundColor: AppColors.white,
            fillColor: AppColors.white,
            textInputAction: TextInputAction.search,
            hintText: "search".tr(),
            prefixIcon: Icon(Icons.search),
            hintColor: AppColors.TEXTFIELD_HINT,
          )),
          GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();

              ProviderScope.containerOf(context, listen: false)
                  .read(di.searchContentProvider.state)
                  .state = searchController.text;
              if (widget.onSearchSubmit != null) widget.onSearchSubmit!();
            },
            child: Container(
              alignment: context.locale.languageCode == 'ar'
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              height: 45,
              width: 40,
              margin: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(10.0),
                color: AppColors.APP_BLUE,
              ),
              child: Icon(
                Icons.search,
                size: 25,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
