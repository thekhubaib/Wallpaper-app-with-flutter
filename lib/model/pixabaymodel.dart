// To parse this JSON data, do
//
//     final wallpaper = wallpaperFromJson(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;

Wallpaper wallpaperFromJson(String str) => Wallpaper.fromJson(json.decode(str));

String wallpaperToJson(Wallpaper data) => json.encode(data.toJson());

class Wallpaper {
    int total;
    int totalHits;
    List<Hit> hits;

    Wallpaper({
        required this.total,
        required this.totalHits,
        required this.hits,
    });

    factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(
        total: json["total"],
        totalHits: json["totalHits"],
        hits: List<Hit>.from(json["hits"].map((x) => Hit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "totalHits": totalHits,
        "hits": List<dynamic>.from(hits.map((x) => x.toJson())),
    };
}

class Hit {
    int id;
    String pageUrl;
    Type type;
    String tags;
    String previewUrl;
    int previewWidth;
    int previewHeight;
    String webformatUrl;
    int webformatWidth;
    int webformatHeight;
    String largeImageUrl;
    int imageWidth;
    int imageHeight;
    int imageSize;
    int views;
    int downloads;
    int collections;
    int likes;
    int comments;
    int userId;
    String user;
    String userImageUrl;

    Hit({
        required this.id,
        required this.pageUrl,
        required this.type,
        required this.tags,
        required this.previewUrl,
        required this.previewWidth,
        required this.previewHeight,
        required this.webformatUrl,
        required this.webformatWidth,
        required this.webformatHeight,
        required this.largeImageUrl,
        required this.imageWidth,
        required this.imageHeight,
        required this.imageSize,
        required this.views,
        required this.downloads,
        required this.collections,
        required this.likes,
        required this.comments,
        required this.userId,
        required this.user,
        required this.userImageUrl,
    });

    factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        id: json["id"],
        pageUrl: json["pageURL"],
        type: typeValues.map[json["type"]]!,
        tags: json["tags"],
        previewUrl: json["previewURL"],
        previewWidth: json["previewWidth"],
        previewHeight: json["previewHeight"],
        webformatUrl: json["webformatURL"],
        webformatWidth: json["webformatWidth"],
        webformatHeight: json["webformatHeight"],
        largeImageUrl: json["largeImageURL"],
        imageWidth: json["imageWidth"],
        imageHeight: json["imageHeight"],
        imageSize: json["imageSize"],
        views: json["views"],
        downloads: json["downloads"],
        collections: json["collections"],
        likes: json["likes"],
        comments: json["comments"],
        userId: json["user_id"],
        user: json["user"],
        userImageUrl: json["userImageURL"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pageURL": pageUrl,
        "type": typeValues.reverse[type],
        "tags": tags,
        "previewURL": previewUrl,
        "previewWidth": previewWidth,
        "previewHeight": previewHeight,
        "webformatURL": webformatUrl,
        "webformatWidth": webformatWidth,
        "webformatHeight": webformatHeight,
        "largeImageURL": largeImageUrl,
        "imageWidth": imageWidth,
        "imageHeight": imageHeight,
        "imageSize": imageSize,
        "views": views,
        "downloads": downloads,
        "collections": collections,
        "likes": likes,
        "comments": comments,
        "user_id": userId,
        "user": user,
        "userImageURL": userImageUrl,
    };
}

enum Type {
    ILLUSTRATION,
    PHOTO,
    VECTOR_SVG
}

final typeValues = EnumValues({
    "illustration": Type.ILLUSTRATION,
    "photo": Type.PHOTO,
    "vector/svg": Type.VECTOR_SVG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}



class ApiService {
  final String apiKey = '44627507-ef9f167a0fdc89a7e5aa180a3';
  final String baseUrl = 'https://pixabay.com/api/';

  Future<Wallpaper> fetchWallpapers({String query = ''}) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$query'));
    if (response.statusCode == 200) {
      return Wallpaper.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load wallpapers');
    }
  }
}



