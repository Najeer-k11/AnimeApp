import 'package:animecrunch/home/data/dataProvider.dart';
import 'package:get_it/get_it.dart' ;

final sl = GetIt.asNewInstance();

void setup()
{
  sl.registerSingleton<DataProvider>(DataProvider());
}