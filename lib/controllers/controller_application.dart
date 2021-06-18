import 'package:desafio_byebnk/api/application_redeem_api.dart';

class ControllerApplicationApi extends ApplicationAndRedeemApi {
  @override
  Future applicationAndRedeemApi(
      String? token, String? date, double? value, kUrlApplication);
}
