class FileItem {
  final String name;
  final String type;

  FileItem({
    required this.name,
    required this.type,
  });

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      name: json['name'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}

class FileItemsResponse {
  final List<FileItem> result;

  FileItemsResponse({
    required this.result,
  });

  factory FileItemsResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['result'] as List;
    List<FileItem> itemsList =
    resultList.map((item) => FileItem.fromJson(item)).toList();

    return FileItemsResponse(
      result: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result.map((item) => item.toJson()).toList(),
    };
  }
}
