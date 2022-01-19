
# Overview
 

Welcome to the BalanceMe app project,
this page will provide a brief overview on
the project's structure as well as
important directories and files in the app.


Common Models


> This folder contains the models used in the app,
> for more detailed information-please read the models document.


Controllers


> This folder contains controllers and associated functions
> for features which are required for most of the app
* [ ] Messages_controller- handles workspace messages, such as invitations and join requests.
* [ ] Theme_controller- handles dark mode, as well as the colors used in the app's UI


Firebase_wrapper


> This folder contains wrapper classes 
> for Firebase functions,
> as well as various analytics tools
* [ ] Auth_repository- functions related to FirebaseAuth, such as sign in, sign up,
   recover password and retrieving profile pictures.
* [ ] Google_analytics_repository - wrapper for using the Google analytics tool,
  logging events such as opening the app, logging in with third party providers, 
  and how often certain app features are used.
* [ ] Sentry_repository- wrapper for using the Sentry tool,
logging errors and exceptions to Sentry,
in order to determine which elements of the app require refinement.
* [ ] Storage_repository- wrapper to the user model, receives and updates 
  information about the user from and to the database
  

Global


> This folder contains constants and
> functions, which are used in multiple files
> to ensure their reusability.
* [ ] Config- constants which pertain to project settings, 
  Firebase settings, and Sentry, such as name, version, collection names etc.
* [ ] Constants- constants which are related to specific widget settings,
such as colors, icons, default values,padding sizes, etc.
* [ ] Login_utils- functions which are used for authentication, such as login and signing up via different providers.
* [ ] Types- enumerations and typedefs for complex types such as callbacks, authentication status, currency, etc.
* [ ] Utils- functions which are used in multiple files such as navigation and validators.
* [ ] Dispatcher- a list of methods which need to be listened to and modify the app's consumers
* [ ] Rate_us- a widget which allows a user to rate the app on Google play, as well as add a description.


Assets


> This folder contains static images
> which we display in the app
> regardless of user input.


Localization


> This folder contains the required
> files to support different languages
* [ ] Resources- contains all the strings which are displayed to the user in the app, in English,Hebrew and Russian.
* [ ] Language and locale controllers- determine which language is used and change it based on the app's settings.


Pages


> This folder contains the main screens
> displayed to the user (whether signed in or not).
* [ ] Authentication - pages related to signing in/up.
* [ ] Balance- existing incomes and expenses page, shown when a user is signed in.
* [ ] Home- wrapper for balance and welcome
* [ ] Profile_settings- the page where a user can change their name and image
* [ ] Set_category- a page where the user adds a category (after pressing FAB)
* [ ] Set_transaction-a page where the user adds a transaction (after pressing FAB)
* [ ] Settings- the main settings page
* [ ] Welcome- the home page shown if a user isn't signed in.
* [ ] Archive- a page where the user can view past transactions, category, by month/year
* [ ] Connection_lost- an error page shown if the user has no internet connection
* [ ] Set_workspace- the page where users can create, join and invite to workspaces
* [ ] Summary- a page which shows the user the total difference between expected and total incomes/expenses


Widgets


> Generic widgets used
> in different pages, to ensure uniform design as
> as well as reusability
* [ ] Authentication - widgets used in login pages.
* [ ] Balance - widgets used for the balance (main) page
* [ ] Action_button- generic button which shows a loading circle until function ends
* [ ] Appbar- appbar design shown throughout the app
* [ ] Bottom_navigation- widget to navigate between the three main screens
* [ ] Date_picker- widget for displaying a calender to choose a date
* [ ] User_avatar- widget for displaying the user's profile image
* [ ] Text box widgets- for uniform look for text fields and customizable optional fields
* [ ] Ring_pie_chart- shows pie charts in the balance page
* [ ] Language_drop_down and generic_drop_down_button-widget to choose app language in settings
* [ ] Image_picker-for picking an image, by camera or by gallery.
* [ ] Generic_tabs- widget for pages with tabs
* [ ] Generic_radio_button-widget for choosing one of many options
* [ ] Generic_listview- widgets for showing multiple items in a ListView
* [ ] Generic_info- for displaying entries in the balance page
* [ ] Generic_edit_button- a button which indicates certain widgets can be changed
* [ ] Dark_mode_switcher- the switch for dark mode in settings
* [ ] Generic_dismissible- widget for items which can be removed by swiping
* [ ] Generic_tooltip- a widget which shows a hint about the functionality of another widget.
