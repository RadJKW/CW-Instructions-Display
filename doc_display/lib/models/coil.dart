class Coil {
// this class will contain the following coil properties:
// number, division, material, materialWidth, prevStop, actualStop, nextStop,
// and the following coil methods:
// getCoilNumber, getCoilDivision, getCoilMaterial, getCoilMaterialWidth, getCoilPrevStop, getCoilActualStop, getCoilNextStop,
// setCoilNumber, setCoilDivision, setCoilMaterial, setCoilMaterialWidth, setCoilPrevStop, setCoilActualStop, setCoilNextStop,
// each value will be decoded using json  from the MqttAppState.getReceivedMessage() string and the coil number will be used to set the coil properties

  // create a variable to hold the mqtt received message string
  String? receivedMessage;
  final String _number;
  final String _division;
  final String _winding;
  final String _material;
  final String _materialWidth;
  final String _prevStop;
  final String _activeStop;
  final String _nextStop;

  Coil({
      required String number,
      required String division,
      required String winding,
      required String material,
      required String materialWidth,
      required String prevStop,
      required String activeStop,
      required String nextStop}) : _number = number,
            _division = division,
            _winding = winding,
            _material = material,
            _materialWidth = materialWidth,
            _prevStop = prevStop,
            _activeStop = activeStop,
            _nextStop = nextStop;

  Coil.fromJson(Map<String, dynamic> json)
      : _number = json['number'],
        _division = json['division'],
        _winding = json['winding'],
        _material = json['material'],
        _materialWidth = json['materialWidth'],
        _prevStop = json['prevStop'],
        _activeStop = json['activeStop'],
        _nextStop = json['nextStop'];

  Map<String, dynamic> toJson() => {
        'number': _number,
        'division': _division,
        'winding': _winding,
        'material': _material,
        'materialWidth': _materialWidth,
        'prevStop': _prevStop,
        'activeStop': _activeStop,
        'nextStop': _nextStop,
      };

  String get getNumber => _number;
  String get getDivision => _division;
  String get getWinding => _winding;
  String get getMaterial => _material;
  String get getMaterialWidth => _materialWidth;
  String get getPrevStop => _prevStop;
  String get getActiveStop => _activeStop;
  String get getNextStop => _nextStop;
  
}
