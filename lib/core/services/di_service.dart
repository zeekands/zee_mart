import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:zee_mart/core/services/di_service.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => locator.init();
