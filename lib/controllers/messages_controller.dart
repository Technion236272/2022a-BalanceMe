// ================= Messages Controller =================
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:balance_me/firebase_wrapper/storage_repository.dart';
import 'package:balance_me/localization/resources/resources.dart';
import 'package:balance_me/firebase_wrapper/google_analytics_repository.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class MessagesController {
  static BuildContext? context = globalNavigatorKey.currentContext;
  static late UserStorage userStorage;

  static void handleUserMessages(List<dynamic> messages) {
    try {
      if (context == null) {
        return;
      }

      userStorage = Provider.of<UserStorage>(context!, listen: false);
      for (var message in messages) {
        if (_isMessageValid(message)) {
          switch (indexToEnum(UserMessage.values, message["type"])) {
            case UserMessage.JoinWorkspace:
              _handleJoinWorkspace(message);
              break;

            case UserMessage.InviteWorkspace:
              _handleInviteWorkspace(message);
              break;

            case UserMessage.ShowMessage:
              _handleShowMessage(message);
              break;

            default:
              GoogleAnalytics.instance.logHandleUnknownMessage(message.toString());
              break;
          }

          GoogleAnalytics.instance.logHandleMessageSuccess(message.toString());
        }
      }

    } catch (e) {
        GoogleAnalytics.instance.logHandleMessageFailed();
    }
  }

  static void _handleJoinWorkspace(Message message) {
    void replyRequest(bool isApproved) {
      userStorage.replyUserJoiningRequest(context!, message["user"], isApproved, message["workspace"]);
    }

    message["message"] = Languages.of(context!)!.strUserRequestJoiningToWorkspace;
    _handleShowMessage(message, [[() => {replyRequest(true)}, Languages.of(context!)!.strApprove], [() => {replyRequest(false)}, Languages.of(context!)!.strReject]]);
    userStorage.SEND_updatePendingJoiningRequest(message["workspace"], message["user"], true);
  }

  static void _handleInviteWorkspace(Message message) {
    void replyRequest(bool isAccepted) {
      userStorage.replyWorkspaceInvitation(context!, message["workspace"], isAccepted);
    }

    message["message"] = Languages.of(context!)!.strUserInvitedToWorkspace;
    _handleShowMessage(message, [[() => {replyRequest(true)}, Languages.of(context!)!.strApprove], [() => {replyRequest(false)}, Languages.of(context!)!.strReject]]);
  }

  static void _handleShowMessage(Message message, [List<List>? actions]) {
    showDismissBanner(message["message"].replaceAll("%", message["workspace"]).replaceAll("#", message["user"]), actions);
  }

  static bool _isMessageValid(Message message) {
    return message["type"] != null && message["workspace"] != null && message["user"] != null;
  }
}
