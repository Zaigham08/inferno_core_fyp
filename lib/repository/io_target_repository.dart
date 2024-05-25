// import '../data/network/network_api_services.dart';
// import '../res/app_urls.dart';
//
// class IoTargetRepository{
//
//   final _apiService = NetworkApiServices();
//
//   Future<dynamic> receiveCommandResponse({var data}) async{
//     return await _apiService.postApi(AppUrl.receiveCommandResponseApi, data);
//   }
//
//   Future<dynamic> receiveFileCommandResponse({var params, var filePath}) async{
//     return await _apiService.multipartRequestApi(url: AppUrl.receiveFileCommandResponseApi, params: params, filePath: filePath);
//   }
//
// }