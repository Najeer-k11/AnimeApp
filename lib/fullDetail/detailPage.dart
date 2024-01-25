import 'package:animecrunch/favourites/favouritesPage.dart';
import 'package:animecrunch/favourites/localProvider/localData.dart';
import 'package:animecrunch/fullDetail/bloc/detail_bloc.dart';
import 'package:animecrunch/models/item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../favourites/bloc/fav_bloc.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final db = DetailBloc();
    final fb = FavBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => db..add(DetailFetchEvent(id: id.toString(),),),),
        BlocProvider(create: (context) => fb)
      ],
      child: const DetailScaffold(),
    );
  }
}

class DetailScaffold extends StatelessWidget {
  const DetailScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading || state is DetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailLoaded) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                CachedNetworkImage(
                  imageUrl: state.detail.imageUrl,
                  placeholder: (context,url) => const CircularProgressIndicator(),
                  imageBuilder:(context,provider) => Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover)),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(LineIcons.chevronLeft),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: IconButton(
                              onPressed: () {
                                Item itm = Item(
                                    id: state.detail.id,
                                    title: state.detail.title,
                                    thumbUrl: state.detail.imageUrl,
                                    rating: state.detail.rating);
                                BlocProvider.of<FavBloc>(context)
                                    .add(FavInsert(it: itm));
                                showSnack(context);
                              },
                              icon: const Icon(LineIcons.heart),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).shadowColor.withOpacity(0.25),
                          offset: const Offset(2, 4),
                          blurRadius: 5,
                        )
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 25,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Row(
                          children: [
                            const Text(
                              "Title : ",
                              style: TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.deepOrange,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            Text(
                              state.detail.titleEnglish,
                              style: const TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                      ),
                      SizedBox(
                        height: 25,
                        child: Row(
                          children: [
                            const Text(
                              "Rating : ",
                              style: TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.deepOrange,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            Text(
                              state.detail.rating,
                              style: const TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: [
                            const Text(
                              "Score : ",
                              style: TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.deepOrange,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            Text(
                              state.detail.score.toString(),
                              style: const TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          children: [
                            Text(
                              state.detail.scoredBy.toString(),
                              style: const TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Colors.deepOrange,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                            const Text(
                              " reviews",
                              style: TextStyle(
                                  fontFamily: 'os',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Synopsis',
                    style: TextStyle(
                        fontFamily: 'os',
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    state.detail.synopsis ?? 'N/A',
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: 'os'),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text(
                  "SomeThing Went wrong restart your app or check connection ",
                  style: TextStyle(fontFamily: 'os')),
            );
          }
        },
      ),
    );
  }
  void showSnack(BuildContext context) {
    SnackBar snack = const SnackBar(content: Text('Added to Favourites'),duration: Duration(seconds: 3),);
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
