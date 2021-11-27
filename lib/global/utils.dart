import 'dart:convert';



Map convertToJSON(List<Object> fields)
{
    Map toJSON={};
    fields.forEach((element) { toJSON[element.toString()]=element;});
    return toJSON;
}
String objectAsJSON(Object o)
{
  return jsonEncode(o);
}
//converting object from json depends on the fields but looks like this
//requires constructor
// Object fromJSON(Map json)
// {
//   return Object(json['first field'],json['second fields'],etc..);
// }