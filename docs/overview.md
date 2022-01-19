
# Overview
 

Welcome to the BalanceMe app project,
this page will provide a brief overview on
the project's structure as well as
important directories and files in the app.


common models


> this folder contains the models used in the app,
> for more detailed information-please read the models document.


controllers


> this folder contains controllers and associated functions
> for features which are required for most of the app
* [ ] messages_controller- handles workspace messages, such as invitations and join requests.
* [ ] theme_controller- handles dark mode, as well as the colors used in the app's UI


firebase_wrapper


> this folder contains wrapper classes 
> for Firebase functions,
> as well as various analytics tools
* [ ] auth_repository- functions related to FirebaseAuth, such as sign in, sign up,
   recover password and retrieving profile pictures.
* [ ] google_analytics_repository - wrapper for using the Google analytics tool,
  logging events such as opening the app, logging in with third party providers, 
  and how often certain app features are used.
* [ ] sentry_repository- wrapper for using the Sentry tool,
logging errors and exceptions to Sentry,
in order to determine which elements of the app require refinement.
* [ ] storage_repository- wrapper to the user model, receives and updates 
  information about the user from and to the database
  

global


> this folder contains constants and
> functions, which are used in multiple files
> to ensure their reusability.
* [ ] config- constants which pertain to project settings, 
  Firebase settings, and Sentry, such as name, version, collection names etc.
* [ ] constants- constants which are related to specific widget settings,
such as colors, icons, default values,padding sizes, etc.
* [ ] login_utils- functions which are used for authentication, such as login and signing up via different providers.
* [ ] types- enumerations and typedefs for complex types such as callbacks, authentication status, currency, etc.
* [ ] utils- functions which are used in multiple files such as navigation and validators.
* [ ] dispatcher- a list of methods which need to be listened to and modify the app's consumers
* [ ] rate_us- a widget which allows a user to rate the app on Google play, as well as add a description.


assets


> this folder contains static images
> which we display in the app
> regardless of user input.


localization


> this folder contains the required
> files to support different languages
* [ ] resources- contains all the strings which are displayed to the user in the app, in English,Hebrew and Russian.
* [ ] language and locale controllers- determine which language is used and change it based on the app's settings.


pages


> this folder contains the main screens
> displayed to the user (whether signed in or not).
* [ ] authentication - pages related to signing in/up.
* [ ] balance- existing incomes and expenses page, shown when a user is signed in.
* [ ] home- wrapper for balance and welcome
* [ ] profile_settings- the page where a user can change their name and image
* [ ] set_category- a page where the user adds a category (after pressing FAB)
* [ ] set_transaction-a page where the user adds a transaction (after pressing FAB)
* [ ] settings- the main settings page
* [ ] welcome- the home page shown if a user isn't signed in.
* [ ] archive- a page where the user can view past transactions, category, by month/year
* [ ] connection_lost- an error page shown if the user has no internet connection
* [ ] set_workspace- the page where users can create, join and invite to workspaces
* [ ] summary- a page which shows the user the total difference between expected and total incomes/expenses


widgets


> generic widgets used
> in different pages, to ensure uniform design as
> as well as reusability
* [ ] authentication - widgets used in login pages.
* [ ] balance - widgets used for the balance (main) page
* [ ] action_button- generic button which shows a loading circle until function ends
* [ ]  appbar- appbar design shown throughout the app
* [ ] bottom_navigation- widget to navigate between the three main screens
* [ ] date_picker- widget for displaying a calender to choose a date
* [ ] user_avatar- widget for displaying the user's profile image
* [ ] text box widgets- for uniform look for text fields and customizable optional fields
* [ ] ring_pie_chart- shows pie charts in the balance page
* [ ]  language_drop_down and generic_drop_down_button-widget to choose app language in settings
* [ ]  image_picker-for picking an image, by camera or by gallery.
* [ ]  generic_tabs- widget for pages with tabs
* [ ]  generic_radio_button-widget for choosing one of many options
* [ ]  generic_listview- widgets for showing multiple items in a ListView
* [ ] generic_info- for displaying entries in the balance page
* [ ]  generic_edit_button- a button which indicates certain widgets can be changed
* [ ] dark_mode_switcher- the switch for dark mode in settings
* [ ] generic_dismissible- widget for items which can be removed by swiping
* [ ] generic_tooltip- a widget which shows a hint about the functionality of another widget.
