class BaseResponse<T> {
  final bool status;
  final String message;
  final T? data;

  BaseResponse({
    required this.status,
    required this.message,
    this.data,
  });

  /// Dành cho `data` là 1 OBJECT (Map)
  factory BaseResponse.fromJsonObject(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT,
      ) {
    return BaseResponse<T>(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  factory BaseResponse.fromJsonGeneric(
      Map<String, dynamic> json,
      ) {
    return BaseResponse<T>(
      status: json['status'] ?? false,
      message: json['message'],
      data: json['data'] != null ? json['data'] as T : null,
    );
  }

  /// Dành cho `data` là 1 LIST
  factory BaseResponse.fromJsonList(
      Map<String, dynamic> json,
      T Function(List<dynamic>) fromJsonListT,
      ) {
    return BaseResponse<T>(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? fromJsonListT(json['data']) : null,
    );
  }

  bool get isSuccess => status;
}
