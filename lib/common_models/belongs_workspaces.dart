// ================= Belongs Workspaces Model =================
import 'package:sorted_list/sorted_list.dart';
import 'package:balance_me/global/types.dart';
import 'package:balance_me/global/utils.dart';

class BelongsWorkspaces {
  BelongsWorkspaces(String userEmail) {
    this.belongs = getNoEmailSortedList();
    belongs.add(userEmail);

    this.joiningRequests = getNoEmailSortedList();
  }

  late SortedList<String> belongs;
  late SortedList<String> joiningRequests;

  BelongsWorkspaces.fromJson(Json json) {
    if (json["belongs"] != null) {
      belongs = getNoEmailSortedList();
      belongs.addAll(jsonToElementList(json["belongs"], (workspace) => workspace).cast<String>());
    }
    if (json["joiningRequests"] != null) {
      joiningRequests = getNoEmailSortedList();
      joiningRequests.addAll(jsonToElementList(json["joiningRequests"], (workspace) => workspace).cast<String>());
    }
  }

  Json toJson() => {
    'belongs': belongs.toList(),
    'joiningRequests': joiningRequests.toList()
  };
}
