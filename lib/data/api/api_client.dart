import 'dart:convert';

import 'package:getinforme/data/api/api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class ApiClient {

  dynamic get(String path) async {
    print('${ApiEndPoints.BASE_URL}$path');
    final response = await http.get(
      Uri.parse(ApiEndPoints.BASE_URL+path),
      headers: {
        'Authorization': 'Basic cmVzdFVzZXI6ckVzdEAjMjAyMg==',
      },
    );
    print('path >>>>>>>>>>' + path);
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200||response.statusCode == 400||response.statusCode == 500) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }


  dynamic post(String path, Map<String, dynamic> map) async {
    // if (await _connectivity.check()) {
    print('API_>>>>${ApiEndPoints.BASE_URL}$path');
    print('body>>>>>>DATA' + map.toString());
    final response = await http.post(Uri.parse(ApiEndPoints.BASE_URL+path),
        headers: {
          'Authorization': 'Basic cmVzdFVzZXI6ckVzdEAjMjAyMg==',
        },
        body : map);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.body);
      return json.decode(response.body);
    }

  }
  dynamic put(String path,  Map<String, dynamic> body,
      ) async {
    print('${ApiEndPoints.BASE_URL}$path');
    print('body' + body.toString());
    final response = await http.put(Uri.parse(ApiEndPoints.BASE_URL+path),
        headers: {
          'Content-Type': 'application/json',

        },
        body: json.encode(body));
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200||response.statusCode == 400) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic delete(String path) async {
    print(
      path,
    );
    final response = await http.delete(
      Uri.parse(ApiEndPoints.BASE_URL+path),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print('path >>>>>>>>>>' + path);
    print('response >>>>>>>>>>' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
  dynamic postMultiPart(String api,String filePath, int? userId) async {
    try {
      print('filePath postMultiPart ->' + filePath);
      print('userId postMultiPart ->' + userId.toString());
      var request = new http.MultipartRequest(
          'POST', Uri.parse(ApiEndPoints.BASE_URL+api));
      request.fields.addAll({'userId': userId.toString()});
      request.files.add(await http.MultipartFile.fromPath('avatar', filePath,
          contentType: MediaType('image', 'png')));

      var response = await request.send();

      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        print(res.body);

        print('uploaded');
        // response.stream.transform(utf8.decoder).listen((value) {
        //   print(value);
        return json.decode(res.body);
        // });
      } else {
        print('upload error');
        print(response.reasonPhrase);
      }
    } catch (err) {
      print('ERROR in  postMultiPart upload image $err');
    }
  }

}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'Network error occurred. '});
}
