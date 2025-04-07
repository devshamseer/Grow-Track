import 'package:get_it/get_it.dart';
import 'package:grow_track/domain/core/dependencies_injection/injectable.config.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // This is the default initializer name
  preferRelativeImports: true, // This is the default behavior
  asExtension:
      true, // This is the default behavior, ensures extension methods for GetIt
)
configureDependencies() => getIt.init();
