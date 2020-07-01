import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

List preview = [];
List<String> change = [];

class PreviewVideo {
  String name;
  var duration;

  PreviewVideo(this.name, this.duration);

  @override
  String toString() {
    return '{ ${this.name}, ${this.duration} }';
  }
}

void main() async {
  final response = await http.Client().get(
      Uri.parse('https://www.udemy.com/course/flutter-mobile-development/'));

  if (response.statusCode == 200) {
    var document = parse(response.body);
    var linkLength = document
        .getElementsByClassName('section--previewable-lecture-title--cRADT')
        .length;
    for (int i = 0; i < linkLength; i++) {
      var buttonPreview = document.getElementsByClassName(
          'udlite-btn udlite-btn-large udlite-btn-ghost udlite-heading-md udlite-block-list-item udlite-block-list-item-small udlite-text-sm udlite-block-list-item-link')[i];
      var videoName = document.getElementsByClassName(
          'section--previewable-lecture-title--cRADT')[i];

      change.add(buttonPreview.text);
      var editDur = change[i].split('Preview').last;

      preview.add(PreviewVideo(videoName.text, editDur));
      print(preview[i].name);
    }

    if (preview.length > 0 || preview != null) {
      preview.sort((a, b) => a.duration.compareTo(b.duration));
      print('Sort by duration: ' + preview.toString());
    }
  } else {
    throw Exception();
  }
}
