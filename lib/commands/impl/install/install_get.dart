import '../../../common/utils/pubspec/pubspec_utils.dart';

// Future<void> installGet([bool runPubGet = false]) async {
//   PubspecUtils.removeDependencies('get', logger: false);
//   await PubspecUtils.addDependencies('get', version: getVersion, runPubGet: runPubGet);
// }

///Yuriy: changed to GetX 5 last version
String getVersion = '^5.0.0-release-candidate-9.3.2';
//String getVersion = '>=5.0.0-release-candidate-9.3.2<6.0.0';
Future<void> installGet([bool runPubGet = false]) async {
  PubspecUtils.removeDependencies('get', logger: false);
  await PubspecUtils.addDependencies(
    'get',
    version: getVersion,
    runPubGet: runPubGet,
  );
}
