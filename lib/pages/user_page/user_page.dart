import 'package:desafio_byebnk/urls/urls.dart';
import 'package:desafio_byebnk/controllers/controller_application.dart';
import 'package:desafio_byebnk/controllers/controller_movement.dart';
import 'package:desafio_byebnk/controllers/controller_redeem.dart';
import 'package:desafio_byebnk/model/user_page_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserPage extends StatefulWidget {
  String? token;
  UserPage({this.token});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String? type;
  String? date;
  double? totalBalance;
  double? valueApplication;
  double? valueRedeem;
  List<UserPageModel>? list;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    ControllerMovement().movementApi(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserPageModel>>(
        future: ControllerMovement().movementApi(widget.token),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Center(
                        child: Text(
                            'Aguarde até a página retornar ou a recarregue')),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            list = snapshot.data ?? [];
            var balance = ControllerMovement().getBalance(list);
            var currentDate = ControllerMovement().getIncludeCurrentData();
            var redeem = ControllerRedeemApi().applicationAndRedeemApi(
              widget.token,
              date,
              valueRedeem,
              kUrlRedeem,
            );
            var application =
                ControllerApplicationApi().applicationAndRedeemApi(
              widget.token,
              date,
              valueApplication,
              kUrlApplication,
            );
            var textResultTotalBalance = num.parse((totalBalance == null
                    ? balance.toStringAsFixed(2)
                    : totalBalance?.toStringAsFixed(2))
                .toString());
            return Scaffold(
              body: SafeArea(
                  child: Container(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Center(
                      child: Card(
                        child: Text(
                          'Faça sua movimentação abaixo',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Card(
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: "Valor:",
                        ),
                        controller: controller,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            child: Text('Resgatar'),
                            onPressed: () {
                              setState(() {
                                try {
                                  redeem;
                                  currentDate;
                                  valueRedeem = double.parse(controller.text);
                                  controller.text = '';
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              ('Por favor digite um valor')),
                                        );
                                      });
                                }
                              });
                            }),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            child: Text('Aplicar'),
                            onPressed: () {
                              setState(() {
                                try {
                                  application;
                                  currentDate;
                                  valueApplication =
                                      double.parse(controller.text);
                                  controller.text = '';
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              ('Por favor digite um valor')),
                                        );
                                      });
                                }
                              });
                            }),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Center(
                          child: Card(
                            child: Text(
                              'Seu saldo é R\$ ${balance.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: Text(
                        'Aqui estão suas movimentações',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: list?.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              return Card(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('tipo: ${list?[index].type}'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('data: ${list?[index].date}'),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                    Text(
                                        'valor: ${list?[index].value.toString().replaceAll('.', ',')}'),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02),
                                  ],
                                ),
                              );
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    )
                  ],
                ),
              )),
            );
          }
          return Scaffold(
              body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Aguarde um instante',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Caso demore muito, reinicie sua conxão de internet',
                  style: TextStyle(fontSize: 20),
                ),
                CircularProgressIndicator(),
              ],
            ),
          ));
        });
  }
}
