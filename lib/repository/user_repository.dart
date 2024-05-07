import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class UserRepository{

  final _apiService = NetworkApiServices();

  Future<dynamic> createUser() async{
    return await _apiService.postApi(AppUrl.userApi, "");
  }

  Future<dynamic> getUser() async{
    return await _apiService.getApi(AppUrl.userApi);
  }

  Future<dynamic> deleteUser() async{
    return await _apiService.deleteApi(AppUrl.userApi,'');
  }

}