
class Item {
  int id;
  String title;
  String thumbUrl ;
  String rating ;

  Item({required this.id, required this.title,required this.thumbUrl,required this.rating});

  factory Item.fromJson( Map<String,dynamic> obj){
    return Item(
        id: obj['mal_id'],
        title: obj['title'],
        thumbUrl: obj['images']['jpg']['image_url'],
        rating: obj['rating'] ?? 'N?A'
    ) ;
  }
}