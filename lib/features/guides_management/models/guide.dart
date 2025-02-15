class Guide {
  int? id;
  String? title;
  String? filePath;
  String? printFilePath;
  String? url;
  String? type;
  int? categoryId;
  String? parentTitle;

  Guide(
      {this.id,
      this.title,
      this.filePath,
      this.url,
      this.type,
      this.parentTitle,
      this.categoryId});

  Guide.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    filePath = json['file_path'];
    printFilePath = json['print_file_path'];
    url = json['url'];
    type = json['type'];
    parentTitle = json["parent_category_title"];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['file_path'] = this.filePath;
    data['print_file_path'] = this.printFilePath;
    data['url'] = this.url;
    data['type'] = this.type;
    data['category_id'] = this.categoryId;
    return data;
  }
}
