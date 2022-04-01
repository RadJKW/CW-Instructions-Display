class Coil {
// this class will contain the following coil properties:
// number, division, material, materialWidth, prevStop, actualStop, nextStop,
// and the following coil methods:
// getCoilNumber, getCoilDivision, getCoilMaterial, getCoilMaterialWidth, getCoilPrevStop, getCoilActualStop, getCoilNextStop,
// setCoilNumber, setCoilDivision, setCoilMaterial, setCoilMaterialWidth, setCoilPrevStop, setCoilActualStop, setCoilNextStop,
// each value will be decoded using json  from the MqttAppState.getReceivedMessage() string and the coil number will be used to set the coil properties

  // create a variable to hold the mqtt received message string
  String? receivedMessage;
  final String number;
  final String division;
  final String winding;
  final String material;
  final String materialWidth;
  final String prevStop;
  final String activeStop;
  final String nextStop;

  Coil(this.number, this.division, this.winding, this.material,
      this.materialWidth, this.prevStop, this.activeStop, this.nextStop);

  Coil.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        division = json['division'],
        winding = json['winding'],
        material = json['material'],
        materialWidth = json['materialWidth'],
        prevStop = json['prevStop'],
        activeStop = json['activeStop'],
        nextStop = json['nextStop'];

  Map<String, dynamic> toJson() => {
        'number': number,
        'division': division,
        'winding': winding,
        'material': material,
        'materialWidth': materialWidth,
        'prevStop': prevStop,
        'activeStop': activeStop,
        'nextStop': nextStop,
      };

  String get getNumber => number;
  String get getDivision => division;
  String get getWinding => winding;
  String get getMaterial => material;
  String get getMaterialWidth => materialWidth;
  String get getPrevStop => prevStop;
  String get getActiveStop => activeStop;
  String get getNextStop => nextStop;
}
