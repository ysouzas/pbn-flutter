import 'package:dio/dio.dart';
import 'package:pbn_flutter/services/abstracts/idio_service.dart';
import 'package:pbn_flutter/utils/environment.utils.dart';

class DioService implements IDioService {
  final Environment environment;

  DioService(this.environment);

  @override
  Dio getDio() {
    return Dio(BaseOptions(baseUrl: environment.baseUrl ?? ""));
  }
}
