import 'package:flutter/material.dart';
import 'package:my_caculator/screens/calculator_screen.dart';
import 'package:my_caculator/service/rate_of_exchange.service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/exchande_data.dart';

class RateOfExchangeScreen extends StatefulWidget {
  const RateOfExchangeScreen({super.key});

  @override
  State<RateOfExchangeScreen> createState() => _RateOfExchangeScreenState();
}

class _RateOfExchangeScreenState extends State<RateOfExchangeScreen> {
  Object dropdownValue1 = unitNames[146].entries.first.key;
  Object dropdownValue2 = unitNames[43].entries.first.key;
  Object dropdownValue3 = unitNames.first.entries.first.key;
  Object dropdownValue4 = unitNames[1].entries.first.key;
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('text', double.parse(write));
  }

  initMethod() async {
    double response2 =
        await Provider.of<RateOfExchangeProvider>(context, listen: false)
            .findValue(dropdownValue2.toString());
    double response3 =
        await Provider.of<RateOfExchangeProvider>(context, listen: false)
            .findValue(dropdownValue3.toString());
    double response4 =
        await Provider.of<RateOfExchangeProvider>(context, listen: false)
            .findValue(dropdownValue4.toString());
    setState(() {
      controller1.text = '1';
      controller2.text = response2.toString();
      controller3.text = response3.toString();
      controller4.text = response4.toString();
    });
  }

  @override
  void initState() {
    initMethod();
    saveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: width * 0.53,
                height: height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.white38,
                        width: 1.2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    elevation: 0,
                    dropdownColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    onChanged: (value) async {
                      if (dropdownValue2 == value ||
                          dropdownValue3 == value ||
                          dropdownValue4 == value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Transaction Message",
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: const Text(
                                  "This unit exists. Therefore, this transaction will be deemed invalid.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        setState(() {
                          dropdownValue1 = value!;
                        });
                        double response2 =
                            await Provider.of<RateOfExchangeProvider>(context,
                                    listen: false)
                                .findDifferentValue1(dropdownValue2.toString(),
                                    dropdownValue1.toString());
                        double response3 =
                            await Provider.of<RateOfExchangeProvider>(context,
                                    listen: false)
                                .findDifferentValue1(dropdownValue3.toString(),
                                    dropdownValue1.toString());
                        double response4 =
                            await Provider.of<RateOfExchangeProvider>(context,
                                    listen: false)
                                .findDifferentValue1(dropdownValue4.toString(),
                                    dropdownValue1.toString());
                        setState(() {
                          controller2.text =
                              (response2 * int.parse(controller1.text))
                                  .toString();
                          controller3.text =
                              (response3 * int.parse(controller1.text))
                                  .toString();
                          controller4.text =
                              (response4 * int.parse(controller1.text))
                                  .toString();
                        });
                      }
                    },
                    value: dropdownValue1,
                    isExpanded: true,
                    isDense: true,
                    items: [
                      for (int i = 0; i < unitNames.length; i++)
                        DropdownMenuItem(
                          value: unitNames[i].keys.single,
                          child: Container(
                            width: 185,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color:
                                            unitNames.indexOf(unitNames[i]) == 0
                                                ? Colors.transparent
                                                : Colors.grey,
                                        width: 1))),
                            child: Text(
                              unitNames[i].keys.single,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onTap: () async {},
                        )
                    ],
                    selectedItemBuilder: (item) {
                      return unitNames.map((e) {
                        return Text(
                          e.keys.single,
                          style: const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
              Container(
                  width: width * 0.35,
                  height: height * 0.08,
                  margin: const EdgeInsets.only(right: 15, top: 25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white38, width: 1.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white38, width: 1.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.white38, width: 1.2)),
                          alignLabelWithHint: true,
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        controller: controller1,
                        style: const TextStyle(color: Colors.white),
                        onFieldSubmitted: (value) async {
                          double response2 =
                              await Provider.of<RateOfExchangeProvider>(context,
                                      listen: false)
                                  .findDifferentValue1(
                                      dropdownValue2.toString(),
                                      dropdownValue1.toString());
                          double response3 =
                              await Provider.of<RateOfExchangeProvider>(context,
                                      listen: false)
                                  .findDifferentValue1(
                                      dropdownValue3.toString(),
                                      dropdownValue1.toString());
                          double response4 =
                              await Provider.of<RateOfExchangeProvider>(context,
                                      listen: false)
                                  .findDifferentValue1(
                                      dropdownValue4.toString(),
                                      dropdownValue1.toString());
                          setState(() {
                            controller2.text =
                                (response2 * int.parse(controller1.text))
                                    .toString();
                            controller3.text =
                                (response3 * int.parse(controller1.text))
                                    .toString();
                            controller4.text =
                                (response4 * int.parse(controller1.text))
                                    .toString();
                          });
                        },
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: width * 0.53,
                height: height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.white38,
                        width: 1.2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    elevation: 0,
                    dropdownColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    onChanged: (value) async {
                      if (dropdownValue1 == value ||
                          dropdownValue2 == value ||
                          dropdownValue4 == value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Transaction Message",
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: const Text(
                                  "This unit exists. Therefore, this transaction will be deemed invalid.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        setState(() {
                          dropdownValue2 = value!;
                        });
                        double response2 =
                            await Provider.of<RateOfExchangeProvider>(context,
                                    listen: false)
                                .findDifferentValue1(dropdownValue2.toString(),
                                    dropdownValue1.toString());
                        setState(() {
                          controller2.text =
                              (response2 * int.parse(controller1.text))
                                  .toString();
                        });
                      }
                    },
                    value: dropdownValue2,
                    isExpanded: true,
                    isDense: true,
                    items: [
                      for (int i = 0; i < unitNames.length; i++)
                        DropdownMenuItem(
                          value: unitNames[i].keys.single,
                          child: Container(
                            width: 185,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color:
                                            unitNames.indexOf(unitNames[i]) == 0
                                                ? Colors.transparent
                                                : Colors.grey,
                                        width: 1))),
                            child: Text(
                              unitNames[i].keys.single,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onTap: () {},
                        )
                    ],
                    selectedItemBuilder: (item) {
                      return unitNames.map((e) {
                        return Text(
                          e.keys.single,
                          style: const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
              Container(
                  width: width * 0.35,
                  height: height * 0.08,
                  margin: const EdgeInsets.only(right: 15, top: 25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: TextField(
                        enabled: false,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white38, width: 1.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignLabelWithHint: true,
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        controller: controller2,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: width * 0.53,
                height: height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.white38,
                        width: 1.2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    elevation: 0,
                    dropdownColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    onChanged: (value) async {
                      if (dropdownValue1 == value ||
                          dropdownValue3 == value ||
                          dropdownValue4 == value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Transaction Message",
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: const Text(
                                  "This unit exists. Therefore, this transaction will be deemed invalid.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        dropdownValue3 = value!;
                        double response2 =
                            await Provider.of<RateOfExchangeProvider>(context,
                                    listen: false)
                                .findDifferentValue1(dropdownValue3.toString(),
                                    dropdownValue1.toString());
                        setState(() {
                          controller3.text =
                              (response2 * int.parse(controller1.text))
                                  .toString();
                        });
                      }
                    },
                    value: dropdownValue3,
                    isExpanded: true,
                    isDense: true,
                    items: [
                      for (int i = 0; i < unitNames.length; i++)
                        DropdownMenuItem(
                          value: unitNames[i].keys.single,
                          child: Container(
                            width: 170,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color:
                                            unitNames.indexOf(unitNames[i]) == 0
                                                ? Colors.transparent
                                                : Colors.grey,
                                        width: 1))),
                            child: Text(
                              unitNames[i].keys.single,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onTap: () {},
                        )
                    ],
                    selectedItemBuilder: (item) {
                      return unitNames.map((e) {
                        return Text(
                          e.keys.single,
                          style: const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
              Container(
                  width: width * 0.35,
                  height: height * 0.08,
                  margin: const EdgeInsets.only(right: 15, top: 25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white38, width: 1.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          alignLabelWithHint: true,
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        controller: controller3,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15, top: 25),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                width: width * 0.53,
                height: height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.white38,
                        width: 1.2,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: DropdownButton(
                    underline: const SizedBox(),
                    elevation: 0,
                    dropdownColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    onChanged: (value) async {
                      if (dropdownValue2 == value ||
                          dropdownValue3 == value ||
                          dropdownValue4 == value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text(
                                  "Transaction Message",
                                  style: TextStyle(fontSize: 18),
                                ),
                                content: const Text(
                                  "This unit exists. Therefore, this transaction will be deemed invalid.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'Ok',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      } else {
                        dropdownValue4 = value!;
                        double response2 =
                            await Provider.of<RateOfExchangeProvider>(context,
                                    listen: false)
                                .findDifferentValue1(dropdownValue4.toString(),
                                    dropdownValue1.toString());
                        setState(() {
                          controller4.text =
                              (response2 * int.parse(controller1.text))
                                  .toString();
                        });
                      }
                    },
                    value: dropdownValue4,
                    isExpanded: true,
                    isDense: true,
                    items: [
                      for (int i = 0; i < unitNames.length; i++)
                        DropdownMenuItem(
                          value: unitNames[i].keys.single,
                          child: Container(
                            width: 185,
                            padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color:
                                            unitNames.indexOf(unitNames[i]) == 0
                                                ? Colors.transparent
                                                : Colors.grey,
                                        width: 1))),
                            child: Text(
                              unitNames[i].keys.single,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          onTap: () async {
                            Set response1 =
                                await Provider.of<RateOfExchangeProvider>(
                                        context,
                                        listen: false)
                                    .findDifferentValue(
                                        dropdownValue4.toString(),
                                        dropdownValue1.toString(),
                                        context);
                            setState(() {
                              controller4.text =
                                  (response1.first / response1.last).toString();
                            });
                          },
                        )
                    ],
                    selectedItemBuilder: (item) {
                      return unitNames.map((e) {
                        return Text(
                          e.keys.single,
                          style: const TextStyle(color: Colors.white),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
              Container(
                  width: width * 0.35,
                  height: height * 0.08,
                  margin: const EdgeInsets.only(right: 15, top: 25),
                  child: Center(
                    child: SingleChildScrollView(
                      child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white38, width: 1.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          alignLabelWithHint: true,
                          hintStyle: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        controller: controller4,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
