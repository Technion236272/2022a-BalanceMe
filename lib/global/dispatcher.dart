// ================= Dispatcher =================
import 'package:flutter/material.dart';

class GeneralInfoDispatcher {
  static List<VoidCallback> methods = [];
  static bool isArrived = false;

  static void subscribe(VoidCallback method) {
    isArrived ? method.call() : methods.add(method);
  }

  static void notifyAll() {
    if (!isArrived) {
      for (var method in methods) {
        method.call();
      }
      isArrived = true;
    }
  }

  static void reset() {
    methods = [];
    isArrived = false;
  }
}
