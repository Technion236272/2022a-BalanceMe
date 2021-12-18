// ================= Sentry performance monitor of transactions =================
import 'package:sentry/sentry.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:balance_me/global/config.dart' as config;


/// This class allows you to create transactions, in order to test the performance of asynchronous operations
/// you can use the default transaction, or create your own.
/// information from transaction is sampled according to parameters in main
/// transactions receive data in key,value form.
/// to stop monitoring the performance of the app, finish a transaction with the type of error you've received.
/// exceptions can be sent to Sentry by using the sendToSentry in a catch block.
class SentryMonitor {
  static final ISentrySpan sentrySpan = Sentry.startTransaction(
      config.transactionName, config.transactionOperation);

  ISentrySpan createTransaction(String operation, {String? description}) {
    return sentrySpan.startChild(operation, description: description);
  }

  Future<void> finishTransaction(
      ISentrySpan transaction, SpanStatus? error) async {
    if (!transaction.finished) {
      SpanStatus normal = const SpanStatus.ok();
      error == null
          ? transaction.finish(status: normal)
          : transaction.finish(status: error);
    }
  }

  void addData(ISentrySpan transaction, String key, dynamic value) {
    transaction.setData(key, value);
  }

  void sendTransaction(ISentrySpan transaction) {
    transaction.toSentryTrace();
  }

  Duration getTransactionDuration(ISentrySpan transaction) {
    if (transaction.finished) {
      return transaction.endTimestamp!.difference(transaction.startTimestamp);
    }
    return const Duration();
  }

  Future<void> sendToSentry(Object e, dynamic stackTrace) async {
    await Sentry.captureException(
      e,
      stackTrace: stackTrace,
    );
  }
}
