import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:my_caculator/widgets/process_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

String write = "0";

class _CalculatorScreenState extends State<CalculatorScreen> {
  String zero = "0";
  String one = "1";
  String two = "2";
  String three = "3";
  String four = "4";
  String five = "5";
  String six = "6";
  String seven = "7";
  String eight = "8";
  String nine = "9";
  String dot = ",";
  String minus = "-";
  String plus = "+";
  String cross = "×";
  String partition = "÷";
  String answer = "=";
  String text = "AC";
  String writeAfter = "";
  String write1 = "";
  String write2 = "";
  bool partitionvalue = false;
  bool crossvalue = false;
  bool plusvalue = false;
  bool minusvalue = false;
  bool x = false;
  void function() {
    if (write != "0") {
      setState(() {
        text == "C";
      });
    }
  }

  loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      write = prefs.getDouble('text').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getDouble('text') == null) {
      } else {
        loadData();
      }
      function();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    MoneyFormatter fmf = MoneyFormatter(amount: double.parse(write ?? '0'));
    MoneyFormatterOutput fo = fmf.output;
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 13, left: 13),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width * .8,
                  child: AutoSizeText(
                    fo.withoutFractionDigits,
                    textAlign: TextAlign.end,
                    style: const TextStyle(color: Colors.white, fontSize: 80),
                    maxLines: 1,
                    maxFontSize: 80,
                    minFontSize: 46,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: width * .2,
                height: height * .1,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      if (text == "C") {
                        text = "AC";
                      }
                      write = "0";
                    });
                  },
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.zero),
                    backgroundColor:
                        const WidgetStatePropertyAll<Color>(Colors.grey),
                    overlayColor:
                        WidgetStateColor.resolveWith((states) => Colors.white),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              ProcessWidget(
                text: "-",
                textColor: Colors.black,
                backGroundColor: Colors.grey,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                    } else {
                      if (write.characters.first != "-") {
                        write = "-$write";
                      } else {
                        String x = "-";
                        write = write.replaceFirst(x, '');
                      }
                    }
                  });
                },
                left: 15,
                right: 15,
              ),
              ProcessWidget(
                  text: "%",
                  textColor: Colors.black,
                  backGroundColor: Colors.grey,
                  left: 0,
                  right: 0,
                  onTap: () {
                    setState(() {
                      if (write == "0") {
                      } else {
                        write = "${int.parse(write) / 100}";
                      }
                    });
                  }),
              ProcessWidget(
                  text: partition,
                  textColor:
                      partitionvalue == false ? Colors.white : Colors.orange,
                  backGroundColor:
                      partitionvalue == false ? Colors.orange : Colors.white,
                  left: 15,
                  right: 0,
                  onTap: () {
                    setState(() {
                      write1 = write;
                      plusvalue = false;
                      minusvalue = false;
                      crossvalue = false;
                      partitionvalue = true;
                    });
                  }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ProcessWidget(
                text: seven,
                textColor: Colors.white,
                backGroundColor: Colors.grey.shade900,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                      write = "";
                      write = "7";
                      text = "C";
                    } else if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}7";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}7";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}7";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}7";
                    } else {
                      write = "${write}7";
                    }
                  });
                },
                left: 0,
                right: 0,
              ),
              ProcessWidget(
                text: eight,
                textColor: Colors.white,
                backGroundColor: Colors.grey.shade900,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                      write = "";
                      write = "8";
                      text = "C";
                    } else if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}8";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}8";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}8";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}8";
                    } else {
                      write = "${write}8";
                    }
                  });
                },
                left: 15,
                right: 15,
              ),
              ProcessWidget(
                  text: nine,
                  textColor: Colors.white,
                  backGroundColor: Colors.grey.shade900,
                  left: 0,
                  right: 0,
                  onTap: () {
                    setState(() {
                      if (write == "0") {
                        write = "";
                        write = "9";
                        text = "C";
                      } else if (partitionvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}9";
                      } else if (crossvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}9";
                      } else if (minusvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}9";
                      } else if (plusvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}9";
                      } else {
                        write = "${write}9";
                      }
                    });
                  }),
              ProcessWidget(
                  text: cross,
                  textColor: crossvalue == false ? Colors.white : Colors.orange,
                  backGroundColor:
                      crossvalue == false ? Colors.orange : Colors.white,
                  left: 15,
                  right: 0,
                  onTap: () {
                    setState(() {
                      write1 = write;
                      plusvalue = false;
                      minusvalue = false;
                      crossvalue = true;
                      partitionvalue = false;
                    });
                  }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ProcessWidget(
                text: four,
                textColor: Colors.white,
                backGroundColor: Colors.grey.shade900,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                      write = "";
                      write = "4";
                      text = "C";
                    } else if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}4";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}4";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}4";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}4";
                    } else {
                      write = "${write}4";
                    }
                  });
                },
                left: 0,
                right: 0,
              ),
              ProcessWidget(
                text: five,
                textColor: Colors.white,
                backGroundColor: Colors.grey.shade900,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                      write = "";
                      write = "5";
                      text = "C";
                    } else if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}5";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}5";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}5";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}5";
                    } else {
                      write = "${write}5";
                    }
                  });
                },
                left: 15,
                right: 15,
              ),
              ProcessWidget(
                  text: six,
                  textColor: Colors.white,
                  backGroundColor: Colors.grey.shade900,
                  left: 0,
                  right: 0,
                  onTap: () {
                    setState(() {
                      if (write == "0") {
                        write = "";
                        write = "6";
                        text = "C";
                      } else if (partitionvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}6";
                      } else if (crossvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}6";
                      } else if (minusvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}6";
                      } else if (plusvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}6";
                      } else {
                        write = "${write}6";
                      }
                    });
                  }),
              ProcessWidget(
                  text: minus,
                  textColor: minusvalue == false ? Colors.white : Colors.orange,
                  backGroundColor:
                      minusvalue == false ? Colors.orange : Colors.white,
                  left: 15,
                  right: 0,
                  onTap: () {
                    setState(() {
                      write1 = write;
                      plusvalue = false;
                      minusvalue = true;
                      crossvalue = false;
                      partitionvalue = false;
                    });
                  }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              ProcessWidget(
                text: one,
                textColor: Colors.white,
                backGroundColor: Colors.grey.shade900,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                      write = "";
                      write = "1";
                      text = "C";
                    } else if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}1";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}1";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}1";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}1";
                    } else {
                      write = "${write}1";
                    }
                  });
                },
                left: 0,
                right: 0,
              ),
              ProcessWidget(
                text: two,
                textColor: Colors.white,
                backGroundColor: Colors.grey.shade900,
                onTap: () {
                  setState(() {
                    if (write == "0") {
                      write = "";
                      write = "2";
                      text = "C";
                    } else if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}2";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}2";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}2";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}2";
                    } else {
                      write = "${write}2";
                    }
                  });
                },
                left: 15,
                right: 15,
              ),
              ProcessWidget(
                  text: three,
                  textColor: Colors.white,
                  backGroundColor: Colors.grey.shade900,
                  left: 0,
                  right: 0,
                  onTap: () {
                    setState(() {
                      if (write == "0") {
                        write = "";
                        write = "3";
                        text = "C";
                      } else if (partitionvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}3";
                      } else if (crossvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}3";
                      } else if (minusvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}3";
                      } else if (plusvalue == true) {
                        if (write == write1) {
                          write = "";
                        }
                        write = "${write}3";
                      } else {
                        write = "${write}3";
                      }
                    });
                  }),
              ProcessWidget(
                  text: plus,
                  textColor: plusvalue == false ? Colors.white : Colors.orange,
                  backGroundColor:
                      plusvalue == false ? Colors.orange : Colors.white,
                  left: 15,
                  right: 0,
                  onTap: () {
                    setState(() {
                      write1 = write;
                      plusvalue = true;
                      minusvalue = false;
                      crossvalue = false;
                      partitionvalue = false;
                    });
                  }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (partitionvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}0";
                    } else if (crossvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}0";
                    } else if (minusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}0";
                    } else if (plusvalue == true) {
                      if (write == write1) {
                        write = "";
                      }
                      write = "${write}0";
                    } else {
                      write = "${write}0";
                    }
                  });
                },
                child: Container(
                  width: width * .44,
                  height: height * .1,
                  margin: const EdgeInsets.only(left: 0, right: 15),
                  padding: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      zero,
                      style: const TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ),
              ),
              ProcessWidget(
                  text: dot,
                  textColor: Colors.white,
                  backGroundColor: Colors.grey.shade900,
                  left: 0,
                  right: 15,
                  onTap: () {
                    setState(() {
                      if (write == write1) {
                        write = "";
                        write = "$write,";
                      }
                      if (write.characters.last == ",") {
                      } else {
                        List<bool> boolList = [];
                        List<String> list = write.split(',');
                        for (int i = 0; i < list.length; i++) {
                          if (list[i] == ",") {
                            boolList.add(true);
                          } else {
                            boolList.add(false);
                          }
                        }
                        if (boolList.contains((element) => element == true)) {
                        } else {
                          write = "$write,";
                        }
                      }
                    });
                  }),
              ProcessWidget(
                  text: answer,
                  textColor: Colors.white,
                  backGroundColor: Colors.orange,
                  left: 0,
                  right: 0,
                  onTap: () {
                    if (partitionvalue == true) {
                      setState(() {
                        write2 = write;
                        write =
                            "${double.parse(write1) / double.parse(write2)}";
                      });
                      partitionvalue = false;
                    } else if (crossvalue == true) {
                      setState(() {
                        write2 = write;
                        write = "${int.parse(write1) * int.parse(write2)}";
                      });
                      crossvalue = false;
                    } else if (minusvalue == true) {
                      setState(() {
                        write2 = write;
                        write =
                            "${double.parse(write1) - double.parse(write2)}";
                      });
                      minusvalue = false;
                    } else if (plusvalue == true) {
                      setState(() {
                        write2 = write;
                        write =
                            "${double.parse(write1) + double.parse(write2)}";
                      });
                      plusvalue = false;
                    }
                  })
            ],
          )
        ],
      ),
    );
  }
}
