class CapturedSwing{
  CapturedSwing({required this.name, required this.parameters});
  final String name;
  final SwingParameters parameters;

  static CapturedSwing fromJson(String swingName,Map<String, dynamic> jsonMap) {
    return CapturedSwing(name: swingName , parameters: SwingParameters.fromJson(jsonMap['parameters']));
  }
}

class SwingParameters{
  SwingParameters({required this.flexEx, required this.radUln});
  final HFAFlexEx flexEx;
  final HFARadUln radUln;
  static SwingParameters fromJson(Map<String, dynamic> jsonMap) {
    var nestedMap = jsonMap['HFA_crWrFlexEx'];
    var nestedMap2 = jsonMap['HFA_crWrRadUln'];
    var value = nestedMap['values'];
    var value2 = nestedMap2['values'];

    //Converting dynamic list to List<double>
    List<double> flexExValues = (value as List).map((e) => _toDouble(e)).toList();
    List<double> radUlnValues = (value2 as List).map((e) => _toDouble(e)).toList();
    return SwingParameters(flexEx: HFAFlexEx(values: flexExValues), radUln: HFARadUln(values: radUlnValues));
  }
   static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    } else {
      throw FormatException("Cannot convert $value to double");
    }
  }
}

class HFAFlexEx{
  HFAFlexEx({required this.values});
  final List<double> values;
}

class HFARadUln{
  HFARadUln({required this.values});
  final List<double> values;
}