import 'dart:convert';
import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../../utils/util_functions.dart';
import '../../utils/utils.dart';
import '../app_exceptions.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getApi(String url) async {
    String? idToken = await getIdToken();
    final headers = {
      'Authorization': 'Bearer $idToken',
    };

    dynamic responseJson;
    try {
      final response = await http
          .get(
        Uri.parse(url),
        headers: headers,
      ).timeout(const Duration(seconds: 20));

      debugPrint(idToken);
      debugPrint("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    return responseJson;
  }

  @override
  Future getApiWithParams(String url, var params) async {
    debugPrint("param = $params");
    String? idToken = await getIdToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };

    dynamic responseJson;
    try {
      final response = await http
          .get(
        Uri.parse(url).replace(queryParameters: params),
        headers: headers,
      )
          .timeout(const Duration(seconds: 20));

      debugPrint(idToken);
      debugPrint("get param response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    return responseJson;
  }

  @override
  Future postApi(String url, var data, {int time = 50}) async {
    debugPrint("data -----------------  ${jsonEncode(data)}");
    String? idToken = await getIdToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };
    dynamic responseJson;
    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      debugPrint(idToken);
      debugPrint("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    return responseJson;
  }

  @override
  Future postApiWithParams(String url, var data, var params,
      {bool sendJson = true}) async {
    debugPrint("params -----------------  ${jsonEncode(params)}");
    String? idToken = await getIdToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };
    dynamic responseJson;
    try {
      final response = await http
          .post(
        Uri.parse(url).replace(queryParameters: params),
        headers: headers,
        body: jsonEncode(data),
      );
      debugPrint(idToken);

      if (sendJson) {
        responseJson = returnResponse(response);
      } else {
        if (response.statusCode == 200) {
          return response.bodyBytes;
        } else {
          throw Exception('${jsonDecode(response.body)["detail"]}');
        }
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    if (sendJson) {
      return responseJson;
    }
  }


  @override
  Future putApi(String url, var data, var param) async {
    debugPrint("data -----------------  $data");
    String? idToken = await getIdToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };
    dynamic responseJson;
    try {
      final response = await http
          .put(
        Uri.parse(url + param),
        headers: headers,
        body: jsonEncode(data),
      )
          .timeout(
        const Duration(seconds: 25),
      );
      debugPrint(idToken);
      debugPrint("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    return responseJson;
  }

  @override
  Future deleteApi(String url, var data) async {
    debugPrint("data -----------------  $data");
    String? idToken = await getIdToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };
    dynamic responseJson;
    try {
      final response = await http
          .delete(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      )
          .timeout(
        const Duration(seconds: 20),
      );
      debugPrint(idToken);
      debugPrint("response ${response.body}");
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }

    if (kDebugMode) {
      print(responseJson);
    }
    return responseJson;
  }

  @override
  Future deleteApiWithParams(String url, var params) async {
    String? idToken = await getIdToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };

    dynamic responseJson;
    try {
      final response = await http
          .delete(
        Uri.parse(url).replace(queryParameters: params),
        headers: headers,
      )
          .timeout(const Duration(seconds: 20));

      debugPrint(idToken);
      debugPrint("param response ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    return responseJson;
  }

  Future<Map<String, dynamic>> multipartRequestApi({
    required String url,
    required String filePath,
    required var params,
  }) async {
    final request = http.MultipartRequest(
        'POST', Uri.parse(url).replace(queryParameters: params));

    String? idToken = await getIdToken();
    final headers = {
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'multipart/form-data',
    };
    // Add file to the request
    final file = await http.MultipartFile.fromPath(
      'file',
      filePath,
    );
    request.files.add(file);
    // Set headers
    request.headers.addAll(headers);
    dynamic responseJson;
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint(idToken);
      debugPrint("file response ${response.body}");

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    return responseJson;
  }

  Future<String> multipartRequestApiForImage({
    required String url,
    required String filePath,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));

    String? idToken = await getIdToken();
    final headers = {
      'Authorization': 'Bearer $idToken',
      'Content-Type': 'multipart/form-data',
    };
    // Add file to the request
    final file = await http.MultipartFile.fromPath(
      'file',
      filePath,
    );
    request.files.add(file);
    // Set headers
    request.headers.addAll(headers);
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      debugPrint(idToken);
      debugPrint("response ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      }
      else if (response.statusCode == 400) {
        Utils.toastMsg(jsonDecode(response.body)["detail"]);
        return "400";
      } else {
        throw Exception('Error: statusCode= ${response.statusCode}');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
  }

  Future downloadFile(String url, var params, String fileName,
      String fileExtension) async {
    String? idToken = await getIdToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };
    try {
      final response = await http
          .get(
        Uri.parse('$url$fileName/download').replace(queryParameters: params),
        headers: headers,
      );

      final timestamp = DateTime
          .now()
          .millisecondsSinceEpoch;
      if (fileExtension == '.yt') {
        fileExtension = '.txt';
      }
      final completeFileName = '$fileName-$timestamp$fileExtension'.trim();
      debugPrint(idToken);

      await writeFileBytes(completeFileName, response.bodyBytes);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
  }

  Future postApiForFileBytes(String url, var data) async {
    debugPrint("data -----------------  $data");
    String? idToken = await getIdToken();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $idToken',
    };
    try {
      final response = await http
          .post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      debugPrint(idToken);
      if (response.statusCode == 200) {
        // await writeFileBytes(completeFileName, response.bodyBytes);
        return response.bodyBytes;
      }
      else if (response.statusCode == 400) {
        Get.back();
        throw Exception(jsonDecode(response.body)["detail"]);
      } else {
        throw Exception('Error: statusCode= ${response.statusCode}');
      }
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
  }

  Future<void> writeFileBytes(String fileName, List<int> bytes) async {
    // Check for permission and request if not granted
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      final downloadsDirectory = await ExternalPath
          .getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);

      final filePath = path.join(downloadsDirectory, fileName);

      final file = File(filePath);

      await file.writeAsBytes(Uint8List.fromList(bytes));
      Utils.toastMsg('File downloaded at ${file.path}');
      OpenFile.open(file.path);
    } else {
      Utils.toastMsg('Storage Permission denied');
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 409:
      case 400:
      case 403:
        return jsonDecode(response.body);
      case 401:
        throw ValidationException("Invalid Authentication");
      case 404:
        throw ServerException();
      case 422:
        throw ValidationException("Validation Error");
      case 500:
      case 503:
        throw FetchDataException(
            'Server under maintenance,Try again later!. Status: ${response
                .statusCode.toString()}');
      default:
        throw FetchDataException(
            'Error occurred while communicating with server. Status: ${response
                .statusCode.toString()}');
    }
  }
}
