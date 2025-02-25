import 'dart:typed_data';

import 'package:http/http.dart';

import 'package:http_interceptor/http/http.dart';

class ResponseData {
  String? url;
  int? statusCode;
  Method? method;
  Map<String, String>? headers;
  String? body;

  /// The bytes comprising the body of this response.
  Uint8List bodyBytes;
  int? contentLength;
  bool? isRedirect;
  bool? persistentConnection;
  BaseRequest? baseRequest;

  ResponseData({
    this.method,
    this.url,
    this.statusCode,
    this.headers,
    this.body,
    required this.bodyBytes,
    this.contentLength,
    this.baseRequest,
    this.isRedirect,
    this.persistentConnection,
  });

  factory ResponseData.fromHttpResponse(Response response) {
    return ResponseData(
      baseRequest: response.request,
      statusCode: response.statusCode,
      headers: response.headers,
      body: response.body,
      bodyBytes: response.bodyBytes,
      contentLength: response.contentLength,
      isRedirect: response.isRedirect,
      url: response.request!.url.toString(),
      method: methodFromString(response.request!.method),
      persistentConnection: response.persistentConnection,
    );
  }

  Response toHttpResponse() {
    return Response.bytes(bodyBytes, statusCode!,
        headers: headers!, persistentConnection: persistentConnection!, isRedirect: isRedirect!, request: baseRequest);
  }

  @override
  String toString() {
    return 'ResponseData(url: $url, statusCode: $statusCode, method: $method, headers: $headers, body: $body, bodyBytes: $bodyBytes, contentLength: $contentLength, isRedirect: $isRedirect, persistentConnection: $persistentConnection, baseRequest: $baseRequest)';
  }
}
