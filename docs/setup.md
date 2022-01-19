
# Setup

* BalanceMe, despite having a relatively small number of screens, can be difficult to set up.
  The purpose of this section is to explain the requirements for installing and using BalanceMe and its files.
  failure to install and set up any of the following package may result in undefined behaviour


## Requirements
> Dart IDE
> Flutter sdk-version 2.14.0 and above 
> kotlin- version 1.6.0 and above

## Dependencies and packages
> firebase packages-firebase_core,firebase_auth,cloud_firestore,firebase_storage,firebase_analytics 
> in addition requires a firebase account, more information in https://firebase.flutter.dev/
> 
> provider- for listeners and changing app states to save correctly https://pub.dev/packages/provider
> 
> for choosing a profile image in settings, as well as choosing an attached image:
> image_picker- for choosing a profile image in settings https://pub.dev/packages/image_picker
> permission_handler- for requesting permission when accessing a user's gallery, or camera
> cross_file-https://pub.dev/packages/cross_file
>cached_network_image-https://pub.dev/packages/cross_file


> for charts in balance page, as well as archive:
> percent_indicator- from https://pub.dev/packages/percent_indicator/install
> syncfusion_flutter_charts- from https://pub.dev/packages/syncfusion_flutter_charts/install

> sentry_flutter- for catching and documenting exceptions, requires sign-in and following instructions in sentry.io
> 
> for third party sign in functionality and matching buttons:
> flutter_signin_button-https://pub.dev/packages/flutter_signin_button
> google_sign_in-https://pub.dev/packages/google_sign_in 
> auth_buttons-https://pub.dev/packages/auth_buttons
> flutter_facebook_auth-requires Facebook for developer's account https://pub.dev/packages/flutter_facebook_auth

>for workspace and network functionality
> cross_connectivity-https://pub.dev/packages/cross_connectivity
> rxdart-https://pub.dev/packages/rxdart


> Packages for widgets:
> awesome_dropdown-https://pub.dev/packages/awesome_dropdown/example
> syncfusion_flutter_datepicker-https://pub.dev/packages/syncfusion_flutter_datepicker/example
> sorted_list-https://pub.dev/packages/sorted_list
> email_validator-https://pub.dev/packages/email_validator
> rating_dialog- https://pub.dev/packages/rating_dialog
> mailer-https://pub.dev/packages/mailer
> share_plus-https://pub.dev/packages/share_plus
> flutter_masked_text-https://pub.dev/packages/flutter_masked_text2
