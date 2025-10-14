import 'package:recase/recase.dart';

import '../interface/sample_interface.dart';

/// [Sample] file for Service class creation.
class ServiceSample extends Sample {
  final String _fileName;
  ServiceSample(super.path, this._fileName, {super.overwrite});

  @override
  String get content => '''
class ${_fileName.pascalCase}Service {
   ${_fileName.pascalCase}Service._();
   static final _instance = ${_fileName.pascalCase}Service._();
   factory ${_fileName.pascalCase}Service() {
     return _instance;  
   } 
}
''';
}