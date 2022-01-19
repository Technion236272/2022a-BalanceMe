
# Models

In order to simplify the code and the user experience,
BalanceMe contains several models. 
 In this document, we will describe each model's purpose
and its attributes


## Balance model
> The balance model is a wrapper model used to create, 
> copy, and find categories and its entries easily
* [ ] IncomeCategories - A nullable list of categories whose entries earn money.
* [ ] ExpensesCategories - A nullable list of categories whose entries spend money.

## Category model
> The transaction model is used to represent
> information about new and current categories of expenses and incomes,
> sort between categories, and calculate the sum of money spent or earned.
> The category model has the following properties:
* [ ] Name - A required string the name of the category, not necessarily unique.
* [ ] IsIncome - A boolean, if false, then any entry will decrease from the available budget of this category, true otherwise.   
* [ ] Expected - A double, represents the budget allocated for this expense category.
* [ ] Description - A string which describes the category.
* [ ] Amount - A nullable double, the sum of money earned or spent ,of all entries, in a category.
* [ ] Transactions - A nullable SortedList of transactions, represents all of the transaction object which belong to the category. 

## Transaction model
> The transaction model is used to represent
> information about new and current entries, 
> and sort between them.
> The transaction model has the following properties:
* [ ] Name - A required string the name of the transaction, not necessarily unique.
* [ ] Date - The date ,as a string, when the transaction occurred day/month/year format.
* [ ] Amount - The amount of money earned/spent in the transaction, as a double.
* [ ] Description - A string which describes the transaction.
* [ ] IsConstant - A boolean, if true, the entry will be taken into account in the sum of money spent each month, false otherwise.

## User model
> The user model is used to retrieve and update 
> information about the current user, which FirebaseAuth doesn't hold.
> The user model has the following properties:

* [ ] GroupName - A string which represents the group a user belongs to, the default value is a user's own email
* [ ] EndOfMonthDay - An integer which represents the day the user wishes to archive last month's incomes and expenses, default is the tenth.
* [ ] UserCurrency - An enum which represents the currency with which the user wishes to register incomes and expenses with, default is NIS.
* [ ] FirstName - A nullable string which represents the first name of the user, optional, default is null.
* [ ] LastName - A nullable string which represents the last name of the user, optional, default is null.
* [ ] IsDarkMode - A boolean which represents whether the user switched dark mode on, default is false.
* [ ] Language - A string which represents the language of the app, default is the user's language setting in his phone.

## Workspace model
> The workspace model is used to maintain the members of a workspace.
> A workspace is a group of users, which maintains its own categories and transactions.
> The workspace model has the following properties:

* [ ] Users - A sorted list of user emails, which represents the members of the workspace.
* [ ] Leader - A string which represents the user who added the workspace.
* [ ] PendingJoiningRequests - A sorted list of users, which requested to join into the current workspace.
* [ ] LastUpdatedDate - A Datetime which represents the last date in which the workspace was changed.

## Belongs Workspace model
> The belongs-workspace model is used to maintain the workspaces a user belongs to.
> A user can be the leader of a workspace (by creating it) or a member of an existing workspace.
> The belongs-workspace model has the following properties:
* [ ] Belongs - A sorted list of strings, which represents the workspaces the user is in.
* [ ] JoiningRequests - A sorted list of strings, which represents requests to join other workspaces by their names.
* [ ] Invitations - A sorted list of strings, which represents the workspaces which a user has been invited into.
