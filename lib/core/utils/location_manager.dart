
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationManager {

  static Future<LocationData?> getCurrentLocation() async {
    Location location = new Location();

    final hasPermission = await handlePermission();
    if (!hasPermission) {
      return null;
    }

    try{
      final position = await location.getLocation();
      return position;
    }catch(e){
      return null;
    }
  }

  static Future<bool> handlePermission() async {
    bool serviceEnabled;
    PermissionStatus permission;
    Location location = new Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  static LatLngBounds boundsFromLatLngList(Set<Marker> markers) {
    List<LatLng> latLongs = markers.map<LatLng>((m) => m.position).toList();
    double? x0, x1, y0, y1;
    for (LatLng latLng in latLongs) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng((x1 ?? 0), (y1 ?? 0)), southwest: LatLng((x0 ?? 0), (y0 ?? 0)));
  }

}