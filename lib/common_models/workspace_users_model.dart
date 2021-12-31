// ================= Workspace Users Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/global/utils.dart';
import 'package:balance_me/global/types.dart';

class WorkspaceUsers {
  WorkspaceUsers(String leaderEmail) {
    users = getStringSortedList();
    users.add(leaderEmail);
    leader = leaderEmail;
  }

  WorkspaceUsers.fromJson(Json workspaceUsersJson) {
    users = getStringSortedList();
    users.addAll(jsonToElementList(workspaceUsersJson["users"], (user) => user).cast<String>());
    leader = workspaceUsersJson["leader"];
  }

  WorkspaceUsers copy() {
    WorkspaceUsers newWorkspace = WorkspaceUsers(leader);
    newWorkspace.users.addAll(users);
    return newWorkspace;
  }

  late SortedList<String> users;
  late String leader;

  Json toJson() => {
    'users': users.toList(),
    'leader': leader,
  };

  bool get isEmpty => users.length == 1;

  void addUser(String user) {
    users.add(user);
  }

  void removeUser(String user) {
    users.remove(user);
  }

  void setLeader(String newLeader) {
    leader = newLeader;
  }
}
