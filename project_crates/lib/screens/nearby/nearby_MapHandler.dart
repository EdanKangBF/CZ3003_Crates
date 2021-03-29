import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as LocationManager;

class MapHandler {
  double _longitudeData;
  double _latitudeData;

  Future<LatLng> getCurrentLocation() async {
    final geoposition = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _latitudeData = geoposition.latitude;
    _longitudeData = geoposition.longitude;
    //print(_longitudeData);
    //print(_latitudeData);
    final _center = LatLng(_latitudeData, _longitudeData);
    return _center;
  }
  Future<LatLng> getUserLocation() async {
    LocationManager.LocationData currentLocation;
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation();
      final lat = currentLocation.latitude;
      final lng = currentLocation.longitude;
      final center = LatLng(lat, lng);
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }
  Future<double> getLatitudeDouble() async {
    final geoposition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _latitudeData = geoposition.latitude;
      return geoposition.longitude;
  }
  Future<double> getLongitudeDouble() async {
    final geoposition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return geoposition.longitude;
  }

  createMarker(context, customIcon1) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/location_icon.png')
          .then((icon) {
        customIcon1 = icon;
      });
      print('Found Image');
    }
    else {
      print('cannot find customIcon');
    }
  }

}