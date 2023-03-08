import 'package:dio/dio.dart';

class ApiBase {
  final Dio _dio;

  // final ApiHive _hive;

  ApiBase(
    this._dio,
    // this._hive,
  ) {
    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //
    //   },
    // ));
  }

  Dio get dio => _dio;

  // ApiHive get hive => _hive;
}

// extension MyApiBase on ApiBase {
//   Future<Response> getCached(
//     String path, {
//     Object? data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//     bool cached = true,
//   }) async {
//     final key = "$path$queryParameters";
//     if (cached && hive.has(key)) {
//       final data = jsonDecode(hive.get(key));
//       return Response(
//         statusCode: 221,
//         data: data,
//         requestOptions: RequestOptions(path: path, method: "GET"),
//       );
//     }
//     final response = await dio.get(
//       path,
//       data: data,
//       queryParameters: queryParameters,
//       options: options,
//       cancelToken: cancelToken,
//       onReceiveProgress: onReceiveProgress,
//     );
//     await hive.save(key, jsonEncode(response.data));
//     return response;
//   }
// }
