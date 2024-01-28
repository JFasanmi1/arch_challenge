import 'package:arch_challenge/core/enums/request_type.dart';
import 'package:arch_challenge/core/network/keys.dart';
import 'package:arch_challenge/core/network/network_service.dart';

class DetailsService {
  final NetworkService networkService;

  DetailsService({
    required this.networkService,
  });

  Future getSingleCore(String coreSerial,
      {Map<String, String>? headers}) async {
    return await networkService(
      // headers: headers,
      requestType: RequestType.get,
      url: "${ApiConstants.coreSerial}/$coreSerial",
    );
  }

}
