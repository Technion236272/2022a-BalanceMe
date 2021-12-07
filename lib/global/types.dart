// ================= Global Types =================

enum Status {Uninitialized, Authenticated, Authenticating, Unauthenticated}

enum AppPages {Settings, Balance, Statistics, Login}

enum Currency {NIS, USD, EURO}

typedef Json = Map<String, dynamic>;

typedef VoidCallbackInt = void Function(int);

typedef JsonCallbackJson = void Function(Json);
