enum DrawerItemType {
  home,
  search,
  editProfile,
  drawer,
  sendSupportMessage,
  whereToFindUs,
  messagesList,
  contactUS,
  videos,
  changeLanguageScreen,
  loginScreen,
  registerScreen
}

extension DrawerItemData on DrawerItemType {
  int get index {
    switch (this) {
      case DrawerItemType.home:
        return 0;
      case DrawerItemType.search:
        return 1;
      case DrawerItemType.editProfile:
        return 2;
      case DrawerItemType.drawer:
        return 3;
      case DrawerItemType.sendSupportMessage:
        return 4;
      case DrawerItemType.whereToFindUs:
        return 5;
      case DrawerItemType.messagesList:
        return 6;
      case DrawerItemType.contactUS:
        return 7;

      case DrawerItemType.videos:
        return 8;

      case DrawerItemType.changeLanguageScreen:
        return 9;

      case DrawerItemType.loginScreen:
        return 10;

      case DrawerItemType.registerScreen:
        return 11;
      default:
        return 0;
    }
  }
}
