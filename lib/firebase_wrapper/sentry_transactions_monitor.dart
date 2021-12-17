// ================= Sentry performance monitor of transactions =================
import 'package:sentry/sentry.dart';

class SentryMonitor {
  ISentrySpan createTransaction(String name, String operation) {
    final transaction = Sentry.startTransaction(name, operation);
    return transaction;
  }

  Future<void> processOrderBatch(
      ISentrySpan span, String name, String? description) async {
    final innerSpan = span.startChild(name, description: description);

    try {} catch (exception) {
      innerSpan.throwable = exception;
      innerSpan.status = const SpanStatus.notFound();
    } finally {
      await innerSpan.finish();
    }
  }

  Future<void> testTransaction(
      ISentrySpan transaction, String name, String? description) async {
    try {
      await processOrderBatch(transaction, name, description);
    } catch (exception) {
      transaction.throwable = exception;
      transaction.status = const SpanStatus.internalError();
    } finally {
      await transaction.finish();
    }
  }
}
