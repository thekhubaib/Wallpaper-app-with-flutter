import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/pixabaymodel.dart';

class SearchResultsProvider extends ChangeNotifier {
  Future<Wallpaper>? _futureWallpapers;

  Future<Wallpaper>? get futureWallpapers => _futureWallpapers;

  void searchWallpapers(String query) {
    _futureWallpapers = ApiService().fetchWallpapers(query: query);
    notifyListeners();
  }
}
