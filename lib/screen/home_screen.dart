import 'package:flutter/material.dart';
import 'package:ott101/component/colors.dart';
import 'package:ott101/component/star_range_bar.dart';
import 'package:ott101/provider/app_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appProvider.loadTopRatedMovieList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final topRatedMovie = appProvider.topRatedMovieList.isNotEmpty
        ? appProvider.topRatedMovieList.first : null;

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Stack(
          children: [
            if (topRatedMovie != null) SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height*0.7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          topRatedMovie.posterUrl,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: AlignmentGeometry.topCenter,
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: AlignmentGeometry.topCenter,
                                end: AlignmentGeometry.bottomCenter,
                                colors: [
                                  kBackground,
                                  kBackground.withAlpha(0)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: AlignmentGeometry.bottomCenter,
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: AlignmentGeometry.bottomCenter,
                                end: AlignmentGeometry.topCenter,
                                colors: [
                                  kBackground,
                                  kBackground.withAlpha(0),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              Text(
                                topRatedMovie.vote_average.toStringAsFixed(1),
                                style: TextStyle(color: Colors.white, fontSize: 46),
                              ),
                              SizedBox(height: 14),
                              StarRangeBar(starRate: topRatedMovie.vote_average)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF232935),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(14)
                )
              ),
              child: Row(
                children: [
                  SizedBox(width: 14),
                  Image.asset('assets/showtime_logo.png', width: 36),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: appProvider.genreList.length,
                      itemBuilder: (context, index) {
                        final genre = appProvider.genreList[index];
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              genre.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
