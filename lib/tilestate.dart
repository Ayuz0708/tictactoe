import 'dart:math';
enum Tilestate{
 Empty,Cross,Circle

}
List<List<Tilestate>> chunk(List<Tilestate> list, int size) {
 return List.generate(
     (list.length / size).ceil(),
         (index) =>
         list.sublist(index * size, min(index * size + size, list.length)));
}