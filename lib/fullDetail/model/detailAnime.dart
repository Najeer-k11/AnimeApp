class Data {
  int id;
  String imageUrl;
  String url;
  bool approved;
  String title;
  String titleEnglish;
  String type;
  int episodes;
  bool airing;
  String status;
  String airedFrom;
  String airedTo;
  String duration;
  String synopsis;
  double score;
  int scoredBy;
  String rating;

  Data(
      {required this.id,
      required this.imageUrl,
      required this.url,
      required this.approved,
      required this.title,
      required this.titleEnglish,
      required this.type,
      required this.episodes,
      required this.airing,
      required this.status,
      required this.airedFrom,
      required this.airedTo,
      required this.duration,
      required this.synopsis,
      required this.score,
      required this.scoredBy,
      required this.rating});

  factory Data.fromJson(Map<String, dynamic> obj) {
    return Data(
        id: obj['mal_id'],
        imageUrl: obj['images']['jpg']['image_url'] ?? 'https://raw.githubusercontent.com/Najeer-k11/Najeer-k11.github.io/main/nf.png',
        url: obj['url'],
        approved: obj['approved'] ?? false,
        title: obj['title'] ?? 'N/A',
        titleEnglish: obj['title_english'],
        type: obj['type'],
        episodes: obj['episodes'],
        airing: obj['airing'],
        status: obj['status'],
        airedFrom: obj['aired']['from'],
        airedTo: obj['aired']['to'],
        duration: obj['duration'],
        synopsis: obj['synopsis'],
        score: obj['score'],
        scoredBy: obj['scored_by'],
        rating: obj['rating']);
  }
}
