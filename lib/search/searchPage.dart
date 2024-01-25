import 'package:animecrunch/fullDetail/detailPage.dart';
import 'package:animecrunch/viewall/viewall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tc = TextEditingController();
    final sb = SearchBloc();
    return BlocProvider(
      create: (context) => sb..add(SearchInitEvent()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: TextField(
            maxLines: 1,
            scribbleEnabled: true,
            controller: tc,
            decoration: InputDecoration(
                hintText: 'search here',
                hintStyle: TextStyle(
                    fontFamily: 'os', color: Theme.of(context).hintColor)),
            onSubmitted: (value) {
              sb.add(SearchFetchEvent(query: tc.text));
            },
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (BuildContext context, SearchState state) {
            if (state is SearchInitial) {
              return const SizedBox();
            } else if (state is SearchFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SearchLoaded) {
              return GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: state.data.length,
                  padding: const EdgeInsets.only(top: 8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7, crossAxisCount: 3),
                  itemBuilder: (context, id) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(id: state.data[id].id),
                          ),
                        );
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
                                  image: NetworkImage(state.data[id].thumbUrl),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0, left: 2),
                            child: SizedBox(
                              width: 100,
                              child: Text(
                                state.data[id].title,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontFamily: 'os',
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
