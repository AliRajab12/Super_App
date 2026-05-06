import 'package:dio/dio.dart';

class MyAppointmentApiProvider{
  final Dio dio = Dio();

  Future<dynamic> getAppointments() async {
    final result = await dio.get(
      'path',
    );
    return result.data;
  }
}