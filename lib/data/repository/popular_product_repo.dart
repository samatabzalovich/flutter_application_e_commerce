import 'package:flutter_application_e_commerce/data/api/api_client.dart';
import 'package:flutter_application_e_commerce/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});
  Future<Response> getPopularProductList() async {
    return await apiClient.getData('/popular.json');
  }
  
}
