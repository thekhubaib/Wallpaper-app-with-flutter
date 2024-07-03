import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper_app/components/customdrawer.dart';
import 'package:wallpaper_app/model/pixabaymodel.dart';
import 'package:wallpaper_app/view/imagescreen.dart';
import 'package:wallpaper_app/view/searchresults.dart'; // Add this import for ApiService

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<Wallpaper> futureWallpapers;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureWallpapers = ApiService().fetchWallpapers();
  }

  void navigateToSearchResults(String query) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResults(query: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "W A L L I E",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      drawer: Customdrawer(),
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
                controller: searchController,
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
                  navigateToSearchResults(value);
                },
              ),
            ),
            SizedBox(height: 20),

            Text("Trending :", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<Wallpaper>(
                future: futureWallpapers,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
