import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class TargetRepository{

  final _apiService = NetworkApiServices();

  Future<dynamic> getTarget(var params) async{
    return await _apiService.getApiWithParams(AppUrl.targetApi, params);
  }

  Future<dynamic> getAllTargets() async{
    return await _apiService.getApi(AppUrl.getAllTargetsApi);
  }

  Future<dynamic> getAllTargetsOnline() async{
    return await _apiService.getApi(AppUrl.getOnlineTargetsApi);
  }

  Future<dynamic> getAllTargetFiles() async{
    return await _apiService.getApi(AppUrl.getAllTargetFilesApi);
  }

  Future<dynamic> getTargetFileDownload(var params) async{
    return await _apiService.getApiWithParams(AppUrl.getTargetFileDownloadApi, params);
  }

  Future<dynamic> createTarget(var data) async{
    return await _apiService.postApiForFileBytes(AppUrl.targetApi, data);
  }

  Future<dynamic> addUserToTarget({required String targetId, required String userId}) async{
    return await _apiService.postApi("${AppUrl.targetApi}$targetId/add_user/$userId", "");
  }

  Future<dynamic> removeUserFromTarget({required String targetId, required String userId}) async{
    return await _apiService.postApi("${AppUrl.targetApi}$targetId/remove_user/$userId", "");
  }

  Future<dynamic> deleteTarget(var params) async{
    return await _apiService.deleteApiWithParams(AppUrl.targetApi, params);
  }

  Future<dynamic> createFile(String fileName, List<int> bytes) async{
    return await _apiService.writeFileBytes(fileName,bytes);
  }

}