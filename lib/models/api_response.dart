class ApiResponse {
  final String status;
  final dynamic data;
  final String? error;

  ApiResponse({required this.status, required this.data, this.error});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      status: json['status'] is String ? json['status'] : 'error',
      data: json['data'],
      error: json['error'],
    );
  }
}
