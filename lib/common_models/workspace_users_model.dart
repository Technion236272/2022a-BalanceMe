// ================= Workspace Users Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/constants.dart' as gc;

class WorkspaceUsers {
  WorkspaceUsers(String leaderEmail) {
    _initSortedLists();
    users.add(leaderEmail);
    leader = leaderEmail;
    lastUpdatedDate = getCurrentMonthPerEndMonthDay(gc.defaultEndOfMonthDay, DateTime.now());
  }

  void _initSortedLists() {
    users = getNoEmailSortedList();
    pendingJoiningRequests = getStringSortedList();
  }

  WorkspaceUsers.fromJson(Json workspaceUsersJson) {
    _initSortedLists();
    users.addAll(jsonToElementList(workspaceUsersJson["users"], (user) => user).cast<String>());
    leader = workspaceUsersJson["leader"];
    pendingJoiningRequests.addAll(jsonToElementList(workspaceUsersJson["pendingJoiningRequests"], (user) => user).cast<String>());
    lastUpdatedDate = workspaceUsersJson["lastUpdatedDate"];
  }

  WorkspaceUsers copy() {
    WorkspaceUsers newWorkspace = WorkspaceUsers(leader);
    newWorkspace.users.addAll(users);
    newWorkspace.pendingJoiningRequests.addAll(pendingJoiningRequests);
    newWorkspace.lastUpdatedDate = lastUpdatedDate;
    return newWorkspace;
  }

  late SortedList<String> users;
  late String leader;
  late SortedList<String> pendingJoiningRequests;
  late String lastUpdatedDate;

  Json toJson() => {
    'users': users.toList(),
    'leader': leader,
    'pendingJoiningRequests': pendingJoiningRequests.toList(),
    'lastUpdatedDate': lastUpdatedDate
  };

  bool get isEmpty => users.isEmpty;

  bool get isOnlyLeader => users.length == 1;

  bool get isPendingJoiningRequests => pendingJoiningRequests.isNotEmpty;

  void removeUser(String user) {
    users.remove(user);
  }

  void setLeader([String? newLeader]) {
    if (users.isNotEmpty) {
      newLeader = (newLeader == null) ? users.first : newLeader;
      leader = newLeader;
    }
  }

  static bool isWorkspaceUsersValid(Json json) {
    return json["users"] != null && json["leader"] != null && json["pendingJoiningRequests"] != null && json["lastUpdatedDate"] != null;
  }
}
