import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/model/pixabaymodel.dart';
import 'package:wallpaper_app/view/imagescreen.dart';
import 'package:wallpaper_app/controller/providers/imagescreenprovider.dart';

class SearchResults extends StatelessWidget {
  final String query;

  const SearchResults({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    // Trigger the search when this widget is built
    Provider.of<SearchResultsProvider>(context, listen: false).searchWallpapers(query);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              height: 40,
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "S E A R C H",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                ),
                onSubmitted: (value) {
                  // Trigger the search when a new query is submitted
                  Provider.of<SearchResultsProvider>(context, listen: false).searchWallpapers(value);
                },
              ),
            ),
            SizedBox(height: 20),
            Text("Results :", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<SearchResultsProvider>(
                builder: (context, searchProvider, child) {
                  return FutureBuilder<Wallpaper>(
                    future: searchProvider.futureWallpapers,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.hits.isEmpty) {
                        return Center(child: Text('No wallpapers found'));
                      } else {
                        final wallpapers = snapshot.data!.hits;
                        return MasonryGridView.builder(
                          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: wallpapers.length,
                          itemBuilder: (context, index) {
                            final wallpaper = wallpapers[index];
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: InkWell(
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                        wallpaper.largeImageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageScreen(
                                        imageUrl: wallpaper.largeImageUrl,
                                        views: wallpaper.views,
                                        downloads: wallpaper.downloads,
                                        likes: wallpaper.likes,
                                        comments: wallpaper.comments,
                                        userId: wallpaper.userId,
                                        userImageURL: wallpaper.userImageUrl,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
