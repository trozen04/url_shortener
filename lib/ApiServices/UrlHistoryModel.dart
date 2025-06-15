class UrlHistoryModel {
  final String originalUrl;
  final String shortUrl;
  final String? webpageTitle;
  final DateTime createdOn;

  UrlHistoryModel({
    required this.originalUrl,
    required this.shortUrl,
    this.webpageTitle,
    required this.createdOn,
  });

  factory UrlHistoryModel.fromJson(Map<String, dynamic> json) {
    return UrlHistoryModel(
      originalUrl: json['originalUrl'],
      shortUrl: json['shortUrl'],
      webpageTitle: json['webpageTitle'],
      createdOn: DateTime.parse(json['createdOn']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'originalUrl': originalUrl,
      'shortUrl': shortUrl,
      'webpageTitle': webpageTitle,
      'createdOn': createdOn.toIso8601String(),
    };
  }
}
