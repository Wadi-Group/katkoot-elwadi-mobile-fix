enum ToolFields{
  LIVABILITY,
  LIVE_WEIGHT,
  AGE,
  FCR,
  FEED_WEIGHT,
  MEAT_WEIGHT,

}

extension ToolFieldsExtension on ToolFields {
  String get field {
    switch (this) {
      case ToolFields.LIVABILITY:
        return 'LIVABILITY';
      case ToolFields.LIVE_WEIGHT:
        return 'LIVE_WEIGHT';
      case ToolFields.AGE:
        return 'AGE';
      case ToolFields.FCR:
        return 'FCR';
      case ToolFields.FEED_WEIGHT:
        return 'FEED_WEIGHT';
        case ToolFields.MEAT_WEIGHT:
      return 'MEAT_WEIGHT';
      default:
        return '';
    }
  }
}