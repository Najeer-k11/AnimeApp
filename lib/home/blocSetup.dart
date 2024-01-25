import 'package:animecrunch/home/components/homeCarousel.dart';
import 'package:animecrunch/search/searchPage.dart';
import 'package:animecrunch/shimmers/sectionShimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/section.dart';
import 'package:line_icons/line_icons.dart';
import 'homebloc/home_bloc.dart';

class BlocPage extends StatelessWidget {
  const BlocPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Anime',
                style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontWeight: FontWeight.bold,
                fontFamily: 'os'),
              ),
              Text(
                'Crunch',
                style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'os'),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CarouselPage(),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 30,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'Top Anime',
                  style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'os', fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return Section(data: state.data,type: 'anime',);
                  }
                  return const SectionShimmer();
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 30,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'Top Manga',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18,fontFamily: 'os'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return Section(data: state.rand,type: 'manga',);
                  }
                  return const SectionShimmer();
                },
              ),
            ],
          ),
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.45,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          elevation: 0.3,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.primaries.first),
                child: const Text("Anime Crunch",style: TextStyle(fontFamily: 'os',fontWeight: FontWeight.w700),),
              ),
              ListTile(
                title: const Text("Search",style: TextStyle(fontFamily: 'os'),),
                leading: const Icon(LineIcons.search),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Settings',style: TextStyle(fontFamily: 'os'),),
                leading: const Icon(Icons.settings_rounded),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Favourites',style: TextStyle(fontFamily: 'os'),),
                leading: const Icon(Icons.favorite_outline_rounded),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
