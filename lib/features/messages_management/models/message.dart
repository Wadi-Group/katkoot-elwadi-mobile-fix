import 'package:easy_localization/easy_localization.dart';
import 'package:katkoot_elwady/core/constants/app_constants.dart';
import 'package:katkoot_elwady/features/category_management/models/category.dart';
import 'package:katkoot_elwady/features/tools_management/models/tool.dart';
import 'package:easy_localization/easy_localization.dart';

class Message {
  int? id;
  String? title;
  String? content;
  String? schedule;
  String? type;
  DateTime? date;
  bool? isSeen;
  String? attachmentId;
  String? attachment;
  String? attachmentPrint;
  String? attachmentType;
  String? attachmentTitle;
  Tool? tool;
  Category? category;
  Message(
      {this.id,
      this.content,
      this.schedule,
      this.title,
      this.type,
      this.date,
      this.isSeen,
      this.attachment,
      this.attachmentPrint,
      this.attachmentId,
      this.attachmentType,
      this.attachmentTitle,
      this.tool,
      this.category});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    content = json['content'];
    attachment = json['attachment'] != null ? json['attachment'] : null;
    attachmentPrint = json['attachment_print'] != null ? json['attachment_print'] : null;
    attachmentId = (json['attachment_id'].toString());
    attachmentType = json['attachment_type'];
    schedule = json['schedule'];
    isSeen = json["is_seen"];
    attachmentTitle = json["attachment_title"];
    if (attachmentType == "Tool") {
      tool = Tool.fromJson(Map<String, dynamic>.from(json["tool"]));
      category = Category.fromJson(Map<String, dynamic>.from(json["category"]));
    }
    if (schedule != null) {
      date = DateTime.parse(schedule!);
    }
    var context = AppConstants.navigatorKey.currentContext;
    if (context != null) {
      context.locale.languageCode == "en"
          ? schedule = DateFormat("d MMM y").format(date!)
          : schedule = DateFormat.yMMMd('ar').format(date!);
    }
    print(schedule);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['content'] = this.content;
    data['schedule'] = this.schedule;

    return data;
  }
}
