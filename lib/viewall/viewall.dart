import 'package:animecrunch/fullDetail/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/item.dart';

class ViewAll extends StatelessWidget {
  final List<Item> data;
  final String name;

  const ViewAll({super.key, required this.name, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          title: Text(
        name,
        style: const TextStyle(fontFamily: 'os', fontWeight: FontWeight.w500),
      )),
      body: GridView.builder(
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8, crossAxisCount: 3),
          itemBuilder: (context, id) {
            return GestureDetector(
              onTap: () {
                if(name == 'anime')
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(id: data[id].id),
                      ),
                    );
                  }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: 120,
                    margin: const EdgeInsets.only(right: 2, left: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                          image: NetworkImage(data[id].thumbUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 2.0, left: 2),
                    child: SizedBox(
                      width: 100,
                      child: Text(
                        data[id].title,
                        maxLines: 1,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'os'),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
