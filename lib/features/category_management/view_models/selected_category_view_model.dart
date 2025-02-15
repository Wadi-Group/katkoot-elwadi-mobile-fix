import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';

class SelectedCategoryViewModel extends StateNotifier<Category?> {

  SelectedCategoryViewModel() : super(null);

  void setState(Category category) {
    state = category;
  }

  void resetSelectedCategoryState() {
    state = null;
  }

  int getCategoryMainTabsNumber(){
    int count = 1 ;
    if(state?.haveTools ?? true)
      count+=1;
    if((state?.haveGuides ?? false) || (state?.haveVideos ?? false) || (state?.haveFaqs ?? false))
      count+=1;
    return count;
  }

  int getCategoryGuidesTabsNumber(){
    int count = 0 ;
    if(state?.haveGuides ?? false)
      count+=1;
    if(state?.haveVideos ?? false)
      count+=1;
    if(state?.haveFaqs ?? false)
      count+=1;
    return count;
  }

}
