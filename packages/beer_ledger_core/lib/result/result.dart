import 'package:fpdart/fpdart.dart';

import '../failure/failure.dart';

/// Результат domain-операции.
///
/// **Left** = [Failure], **Right** = успех.
typedef Result<T> = Either<Failure, T>;
