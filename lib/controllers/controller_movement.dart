import 'package:desafio_byebnk/api/movement_api.dart';
import 'package:intl/intl.dart';

class ControllerMovement extends MovementApi {
  double getBalance(List? list) {
    var redeemValue = list
        ?.map((e) => e.type == 'resgate' ? e.value : 0)
        .reduce((value, element) => value + element);
    var applicationValue = list
        ?.map((e) => e.type == 'aplicacao' ? e.value : 0)
        .reduce((value, element) => value + element);
    var total = applicationValue - redeemValue;
    return total!.toDouble();
  }

  getIncludeCurrentData() {
    DateFormat("'Data:' dd/MM/yyyy").format(DateTime.now()).toString();
  }
}
