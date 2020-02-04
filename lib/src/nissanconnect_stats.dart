import 'package:dartnissanconnect/src/unit_calculator.dart';
import 'package:intl/intl.dart';

class NissanConnectStats {
  DateTime date;
  int tripsNumber;
  String milesPerKWh;
  String kilometersPerKWh;
  String kWhPerMiles;
  String kWhPerKilometers;
  String kWhUsed;
  String kWhGained;
  String travelDistanceMiles;
  String travelDistanceKilometers;
  String travelSpeedAverageMph;
  String travelSpeedAverageKmh;
  Duration travelTime;

  NissanConnectStats(Map trip) {
    UnitCalculator unitCalculator = UnitCalculator();

    this.tripsNumber = trip['tripsNumber'];
    this.milesPerKWh = unitCalculator.milesPerKWhPretty(
            trip['consumedElectricity'], trip['distance']) +
        ' mi/kWh';
    this.kWhPerMiles = unitCalculator.kWhPerMilesPretty(
            trip['consumedElectricity'], trip['distance']) +
        ' kWh/mi';
    this.kilometersPerKWh = unitCalculator.kilometersPerKWhPretty(
            trip['consumedElectricity'], trip['distance']) +
        ' km/kWh';
    this.kWhPerKilometers = unitCalculator.kWhPerKilometersPretty(
            trip['consumedElectricity'], trip['distance']) +
        ' kWh/km';
    this.kWhUsed =
        unitCalculator.WhtoKWhPretty(trip['consumedElectricity']) + ' kWh';
    this.kWhGained =
        unitCalculator.WhtoKWhPretty(trip['savedElectricity']) + ' kWh';
    this.travelDistanceKilometers =
        unitCalculator.toKilometersPretty(trip['distance']) + ' km';
    this.travelDistanceMiles =
        unitCalculator.toMilesPretty(trip['distance']) + ' mi';
    this.travelTime = Duration(minutes: trip['duration']);
    this.travelSpeedAverageKmh = unitCalculator.averageSpeedKmhPretty(
            trip['distance'], travelTime.inMinutes) +
        ' km/h';
    this.travelSpeedAverageMph = unitCalculator.averageSpeedMphPretty(
            trip['distance'], travelTime.inMinutes) +
        ' mph';
    this.date =
        DateFormat("yyyy-MM-dd'T'H:m:s'Z'").parse(trip['firstTripStart']);
  }

  static List<NissanConnectStats> list(Map map) {
    var trips = map['data']['attributes']['summaries'];
    List<NissanConnectStats> result = List();
    for (Map trip in trips) {
      result.add(NissanConnectStats(trip));
    }
    return result;
  }
}
