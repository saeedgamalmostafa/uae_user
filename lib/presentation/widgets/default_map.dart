import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DefaultMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final void Function(LatLng)? onTap;
  final Set<Marker> markers;
  final void Function(GoogleMapController)? onMapCreated;
  final bool myLocationEnabled;
  final bool myLocationButtonEnabled;
  final bool zoomControlsEnabled;
  final bool scrollGesturesEnabled;
  final bool tiltGesturesEnabled;
  final bool rotateGesturesEnabled;
  final bool liteModeEnabled;
  final bool zoomGesturesEnabled;
  final MapType mapType;
  final EdgeInsets padding;
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  const DefaultMap({
    Key? key,
    required this.initialCameraPosition,
    this.onTap,
    this.markers = const {},
    this.onMapCreated,
    this.myLocationEnabled = true,
    this.myLocationButtonEnabled = true,
    this.mapType = MapType.normal,
    this.zoomControlsEnabled = true,
    this.zoomGesturesEnabled = true,
    this.padding = const EdgeInsets.all(0),
    this.gestureRecognizers = const {},
    this.scrollGesturesEnabled = true,
    this.tiltGesturesEnabled = true, this.rotateGesturesEnabled=true, this.liteModeEnabled=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      padding: padding,
      scrollGesturesEnabled: scrollGesturesEnabled,
      tiltGesturesEnabled: tiltGesturesEnabled,
      rotateGesturesEnabled: rotateGesturesEnabled,
      liteModeEnabled:liteModeEnabled ,

      zoomGesturesEnabled: zoomGesturesEnabled,
      zoomControlsEnabled: zoomControlsEnabled,
      initialCameraPosition: initialCameraPosition,
      onTap: onTap,
      markers: markers,
      onMapCreated: onMapCreated,
      myLocationEnabled: myLocationEnabled,
      myLocationButtonEnabled: myLocationButtonEnabled,
      mapType: mapType,
      gestureRecognizers: gestureRecognizers,
    );
  }
}
