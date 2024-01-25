import 'package:animecrunch/favourites/bloc/fav_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fullDetail/detailPage.dart';
import '../models/item.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fb = FavBloc();
    return BlocProvider(
      create: (context) => fb..add(FavInit()),
      child: BlocBuilder<FavBloc,FavState>(
        builder: (context,state){
          if(state is FavLoading){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if(state is FavLoaded && state.data.isNotEmpty){
            return FavPage(data: state.data);
          }else if(state is FavDel){
            return const Scaffold(
              body: Center(
                child: Text('Hold up deleting item'),
              ),
            );
          }else {
            return const Scaffold(
              body: Center(
                child: Text("Nothing here"),
              ),
            );
          }
        },
      ),
    );
  }
}

class FavPage extends StatelessWidget {
  final List<Item> data;
  const FavPage({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Favourites'),
      ),
      body: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.67,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 2),
          padding: const EdgeInsets.only(top: 3),
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context,id){
            return GestureDetector(
              onTap: () {
                // if(name == 'anime')
                // {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(id: data[id].id),
                    ),
                  );
                // }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: data[id].thumbUrl,
                    placeholder: (context,url) => const CupertinoActivityIndicator(),
                    imageBuilder: (context,provider) => Container(
                      height: MediaQuery.of(context).size.width * 0.45 * 1.5,
                      width: MediaQuery.of(context).size.width * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: IconButton(
                            icon: const Icon(Icons.delete_rounded),
                            onPressed: (){
                              BlocProvider.of<FavBloc>(context).add(FavDelete(it: data[id]));
                              showSnack(context);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      data[id].title,
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'os'),
                    ),
                  )
                ],
              ),
            );
         }
       ),
    );
  }
  void showSnack(BuildContext context) {
    SnackBar snack = const SnackBar(content: Text('Deleted from Favourites'),duration: Duration(seconds: 3),);
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}

