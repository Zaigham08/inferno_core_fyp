import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class IoAttackerRepository{

  final _apiService = NetworkApiServices();

  Future<dynamic> submitCommand({var data, required String targetId}) async{
    return await _apiService.postApi("${AppUrl.submitCommandApi}$targetId", data);
  }

  Future<dynamic> checkResponseAvailability({required String commandId}) async{
    return await _apiService.getApi("${AppUrl.checkResponseAvailabilityApi}$commandId");
  }

  Future<dynamic> getCommandResponse({required String commandId}) async{
    return await _apiService.getApi("${AppUrl.getCommandResponseApi}$commandId");
  }

}