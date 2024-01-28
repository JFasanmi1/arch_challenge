import 'package:arch_challenge/core/enums/request_type.dart';
import 'package:arch_challenge/core/network/keys.dart';
import 'package:arch_challenge/core/network/network_service.dart';

class HomeService {
  final NetworkService networkService;

  HomeService({
    required this.networkService,
  });

  Future getCoreList(
      {Map<String, String>? headers}) async {
    return await networkService(
      // headers: headers,
      requestType: RequestType.get,
      url: ApiConstants.cores,
    );
  }

}
