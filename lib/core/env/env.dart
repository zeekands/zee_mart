import 'package:secure_dotenv/secure_dotenv.dart';

part 'env.g.dart';

@DotEnvGen(fieldRename: FieldRename.screamingSnake)
abstract class Env {
  const factory Env() = _$Env;

  const Env._();

  @FieldKey(defaultValue: 1, name: 'apiSecret')
  String get apiSecret;
}
