class Faq {
  int? id;
  String? question;
  String? answer;
  int? parentCategoryId;
  String? parentCategoryTitle;
  int? parentId;
  bool expanded = false;

  Faq({
    this.id,
    this.question,
    this.answer,
    this.parentCategoryTitle,
    this.parentCategoryId,
    this.parentId,
    this.expanded = false,
  });

  Faq.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    parentCategoryTitle = json["parent_category_title"];
    parentCategoryId = json['parent_category_id'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['parent_category_id'] = this.parentCategoryId;
    data['parent_id'] = this.parentId;
    return data;
  }
}
