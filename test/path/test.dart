import 'package:get_cli5/functions/path/replace_to_relative.dart';
import 'package:test/test.dart';

void main() {
  test('replace import to relative', () {
    var import =
        "import 'package:ponto_facil/app/presentation/home/views/home.view.dart';";
    var otherFile = 'lib/app/data/file.dart';
    expect(replaceToRelativeImport(import, otherFile),
        equals("import '../presentation/home/views/home.view.dart';"));
  });
}
