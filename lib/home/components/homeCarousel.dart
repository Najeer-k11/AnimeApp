import 'package:animecrunch/shimmers/sectionShimmer.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../homebloc/home_bloc.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const SectionShimmer();
        }
        if (state is HomeLoaded) {
          return CarouselSlider(
            items: [
              state.data[0],
              state.data[1],
              state.data[2],
              state.data[3],
              state.data[4]
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image:
                            DecorationImage(image: NetworkImage(i.thumbUrl),fit: BoxFit.cover),),
                    child: SizedBox(
                      width: 300,
                      child: Center(
                        child: Text(
                          i.title,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: 16.0,
                            fontFamily: 'os',
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Theme.of(context).scaffoldBackgroundColor,
                                offset:const Offset(2, 2)
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 200,
              aspectRatio: 9 / 16,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              scrollDirection: Axis.horizontal,
            ),
          );
        }
        return const SizedBox(
          child: Text('SomeThing Went Wrong'),
        );
      },
    );
  }
}
