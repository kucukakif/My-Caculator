import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_caculator/models/rateOfExchangeModel.dart';
import 'package:http/http.dart' as http;
import 'package:my_caculator/utils/exchande_data.dart';

class RateOfExchangeProvider extends ChangeNotifier {
  Future<double> findValue(String firstData) async {
    for (var element in unitNames) {}
    final baseUrl = Uri.parse(
        'https://v6.exchangerate-api.com/v6/292a605ea645948d46d3ab32/latest/USD');
    final e = await http.get(baseUrl);
    final json = jsonDecode(e.body) as Map<String, dynamic>;
    String value = "";
    double response = 0;
    final response1 = RateOfExchangeModel.fromJson(json);
    for (var list in unitNames) {
      if (list.keys.single == firstData) {
        value = list.values.single;
        break;
      }
    }

    for (var list in response1.conversionRates.entries) {
      if (list.key == value) {
        response = list.value;
        break;
      }
    }
    notifyListeners();
    return response;
  }

  Future<Set<double>> findDifferentValue(
      String firstData, String firstValue, BuildContext context) async {
    final baseUrl = Uri.parse(
        'https://v6.exchangerate-api.com/v6/292a605ea645948d46d3ab32/latest/USD');
    final e = await http.get(baseUrl);
    final json = jsonDecode(e.body) as Map<String, dynamic>;
    String value = "";
    double finishValue1 = 0;
    double finishValue2 = 0;
    final response1 = RateOfExchangeModel.fromJson(json);

    for (var list in unitNames) {
      if (list.keys.single == firstData) {
        value = list.values.single;
        break;
      }
    }
    for (var list in response1.conversionRates.entries) {
      if (list.key == value) {
        finishValue1 = list.value;
        break;
      }
    }
    for (var list in unitNames) {
      if (list.keys.single == firstValue) {
        value = list.values.single;
        break;
      }
    }
    for (var list in response1.conversionRates.entries) {
      if (list.key == value) {
        finishValue2 = list.value;
        break;
      }
    }

    notifyListeners();
    return {finishValue1, finishValue2};
  }

  Future<double> findDifferentValue1(
      String firstData, String firstValue) async {
    String a = "";
    for (var element in unitNames) {
      if (element.keys.single == firstValue) {
        a = element.values.single;
      }
    }
    final baseUrl = Uri.parse(
        'https://v6.exchangerate-api.com/v6/292a605ea645948d46d3ab32/latest/$a');
    final e = await http.get(baseUrl);
    final json = jsonDecode(e.body) as Map<String, dynamic>;
    String value = "";
    double finishValue1 = 0;
    double finishValue2 = 0;
    final response1 = RateOfExchangeModel.fromJson(json);

    for (var element in unitNames) {
      if (element.keys.single == firstData) {
        value = element.values.single;
      }
    }

    for (var element in response1.conversionRates.entries) {
      if (element.key == value) {
        finishValue1 = element.value;
      }
    }

    notifyListeners();
    return finishValue1;
  }
}
