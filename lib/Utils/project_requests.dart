import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_note/Utils/view_utils.dart';

class ProjectRequests {
  static Future<http.Response> makePostRequest({
    required String controller,
    required String method,
    body,
  }) async {
    Response? response;
    print('\n$body');
    print('\n$controller');
    print('\n$method');
    try {
      response = await http.post(
          await makePath(controller: controller, method: method),
          body: jsonEncode(body),
          headers: {'content-type': "application/json"});
    } catch (e) {
      ViewUtils.errorSnackBar(message: e.toString());
    }
    return response!;
  }

  static Future<Uri> makePath({
    required String controller,
    required String method,
  }) async {
    return Uri.parse('https://challenge.reval.me/v1/$controller/$method');
  }
}
