import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/view_utils.dart';

class ProjectRequests {
  static Future<http.Response> makePostRequest({
    required String controller,
    required String method,
    bool? withToken,
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
          headers: (withToken is bool)
              ? {
                  'content-type': "application/json",
                  'Authorization': 'Bearer ${Globals.user.user.token!}'
                }
              : {
                  'content-type': "application/json",
                });
    } catch (e) {
      ViewUtils.errorSnackBar(message: 'خطا در ارتباط با سرور',);
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
