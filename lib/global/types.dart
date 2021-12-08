// ================= Global Types =================

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

enum AppPages {Settings, Balance, Statistics, Login}

typedef VoidCallbackInt = void Function(int);

class PrimitiveWrapper{
  var value;

  PrimitiveWrapper(this.value);
}
