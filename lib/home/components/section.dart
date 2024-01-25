import 'package:animecrunch/fullDetail/detailPage.dart';
import 'package:animecrunch/viewall/viewall.dart';
import 'package:flutter/material.dart';

import '../../models/item.dart';

enum TypeFormat{ anime , manga }

class Section extends StatelessWidget {
  final String type;
  final List<Item> data;

  const Section({super.key, required this.type,required this.data});

  @override
  Widget build(BuildContext context) {
    final Tf = TypeFormat.anime;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      height: 180,
      width: double.maxFinite,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, id) {
            if (id == 4) {
              return Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrangeAccent,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.black,
                    ),
                    iconSize: 24,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewAll(
                            data: data,
                            name: type,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () {
                if(type == 'anime'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(id: data[id].id),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: DecorationImage(
                            image: NetworkImage(data[id].thumbUrl),
                            fit: BoxFit.cover),
                      ),
                      // foregroundDecoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(24),
                      //   gradient: const LinearGradient(
                      //     colors: [Colors.black, Colors.transparent],
                      //     begin: Alignment.bottomCenter,
                      //     end: Alignment.topCenter,
                      //   ),
                      // ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 2.0, left: (id == 0) ? 4 : 0),
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          data[id].title,
                          maxLines: 1,
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'os'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
