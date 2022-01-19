
# Database

* *BalanceMe's database serves multiple purposes:
  it must save the individual user's preferences and settings,such as language, name and currency while simultaneously
  saving his or a group's incomes and expanses in such a way,in order to minimize the impact on the app's performance.


> BalanceMe's database consists of three main elements:
> Firebase authentication table- to utilize Firebase's various authentication functions
* [ ] Email- unique identifier for the other collections.
* [ ] In addition to the standard email and password sign in, sign in by Google or Facebook is possible
* [ ] Only 2 providers ,at most, can be linked at a time
> General info- Individual user's collection. Identified by the user's email
> contains the following:
* [ ] End of month- the day in which the user wishes to archive last month's entries.
* [ ] First name and last name- the user's first name, and last name can be changed in the profile settings.
* [ ] Dark mode- whether the user switched the app to dark mode or not.
* [ ] Currency- the currency number which is used to document the user's incomes and expanses.
* [ ] Group name- the name of the group which the user is a part of. 
* [ ] Profile image- saved in Firebase storage, with its email being a unique identifier.
* [ ] belongsWorkspace- the collection of the names of workspaces, a user belongs to, their invitations to other workspaces, as well as joining requests.
* [ ] userMessages- all joining requests and invites from other workspaces: contains the message type, user it was sent to, and the workspace it was sent from

> for simplicity's sake, a user starts in a singleton workspace with his own email as a name- the default workspace can be deleted,
> a user can open and join multiple workspaces at a time, with each workspace having a unique name.
> categories and transactions are tracked separately in each workspace. Each user has a workspace users collection, with the following parameters:
 

* [ ] leader- the user who opened the workspace, can send invitations to join the workspace, as well as delete it (with the exception of the default workspace)
* [ ] users- all the user emails who belong to that workspace.

> Categories and transactions- a group's collection of transactions- identified by a unique group name
* [ ] category documents are separated by month/year- each is separated to income categories and expense categories 

> Each sub category represents types of transactions, with the following attributes:
* [ ] amount- the sum total of money spent or gained in that category
* [ ] description- optional textual information about the category
* [ ] expected - the budget the group allocated to the category
* [ ] is income - whether the categories reduce the amount of money spent or increase it.
* [ ] name - the name of the category
* [ ] Attached image- saved in Firebase storage, with its date,category,type, and transaction name being its unique identifier.


> Each category has entries which represent individual transactions, with the following attributes:
* [ ] amount- the amount of money spent or gained in the transaction
* [ ] date- when has the transaction taken place day/month/year format
* [ ] description- optional textual information about the entry
* [ ] is constant - whether the entry is a constant expense/income or a one time entry, for user convenience.
* [ ] name - the name of the entry