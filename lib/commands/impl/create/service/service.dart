import 'dart:io';

import 'package:http/http.dart';

import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../exception_handler/exceptions/cli_exception.dart';
import '../../../../functions/create/create_single_file.dart';
import '../../../../functions/is_url/is_url.dart';
import '../../../../functions/replace_vars/replace_vars.dart';
import '../../../../samples/impl/get_service.dart';
import '../../../interface/command.dart';

/// This command creates a service class with the template:
///```
///class NameService {
///   NameService._();
///   static final _instance = NameService._();
///   factory NameService() {
///     return _instance;  
///   } 
///}
///```
class CreateServiceCommand extends Command {
  @override
  String? get hint => 'Creates a service class';

  @override
  String get codeSample => 'get create service:name [OPTIONAL PARAMETERS] \n'
      '${LocaleKeys.optional_parameters.trArgs(["[on]"])} ';
  
  @override
  bool validate() {
    super.validate();
    if (args.length > 2) {
      var unnecessaryParameter = args.skip(2).toList();
      throw CliException(
          LocaleKeys.error_unnecessary_parameter.trArgsPlural(
            LocaleKeys.error_unnecessary_parameter_plural,
            unnecessaryParameter.length,
            [unnecessaryParameter.toString()],
          ),
          codeSample: codeSample);
    }
    return true;
  }

  @override
  Future<void> execute() async {
    return createService(name, onCommand: onCommand);
  }

  Future<void> createService(String name, {String onCommand = ''}) async {
    var sample = ServiceSample('', name);
    if (withArgument.isNotEmpty) {
      if (isURL(withArgument)) {
        var res = await get(Uri.parse(withArgument));
        if (res.statusCode == 200) {
          var content = res.body;
          sample.customContent = replaceVars(content, name);
        } else {
          throw CliException(
              LocaleKeys.error_failed_to_connect.trArgs([withArgument]));
        }
      } else {
        var file = File(withArgument);
        if (file.existsSync()) {
          var content = file.readAsStringSync();
          sample.customContent = replaceVars(content, name);
        } else {
          throw CliException(
              LocaleKeys.error_no_valid_file_or_url.trArgs([withArgument]));
        }
      }
    }
    
    // Default path is app/data, but if onCommand is specified, use app/data/onCommand
    var folderName = '';
    
    if (onCommand.isNotEmpty) {
      // Create the directory if it doesn't exist
      var dirPath = 'lib/app/data/$onCommand';
      var directory = Directory(Structure.replaceAsExpected(path: dirPath));
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }
      folderName = onCommand;
    }
    
    handleFileCreate(
      name,
      'service',
      onCommand,
      false,  // Don't create an extra folder with the name
      sample,
      folderName,
    );
  }

  @override
  String get commandName => 'service';

  @override
  int get maxParameters => 0;
}