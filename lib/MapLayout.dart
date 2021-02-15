import 'package:flutter/material.dart';
import 'package:customer/storage/globals.dart'as globals;
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class MapLayout extends StatefulWidget {
  @override
  _MapLayoutState createState() => _MapLayoutState();
}

class _MapLayoutState extends State<MapLayout> {

  LatLng initialPosition = LatLng(51.5, -0.09);
  LatLng changePosition;

  MapController controller = MapController();

  String landMark='';

  @override
  void initState() {
    _getUserCoordinates();
    super.initState();
  }

  _getUserCoordinates()async {
    GeolocatorPlatform.instance.requestPermission().whenComplete(() async{
      Position position = await GeolocatorPlatform.instance.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      Coordinates coordinates = Coordinates(position.latitude, position.longitude);
      var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      setState(() {changePosition = LatLng(position.latitude,position.longitude);landMark = '${address.first.postalCode} ${address.first.thoroughfare} ${address.first.locality} ${address.first.subAdminArea} ${address.first.adminArea}';});
      controller.move(LatLng(position.latitude,position.longitude), 17.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: globals.width,
            height: globals.height/1.12,
            child: FlutterMap(
              mapController: controller,
              options: MapOptions(
                onTap: (val) async{
                  Coordinates coordinates = Coordinates(val.latitude, val.longitude);
                  var address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
                  setState(() {changePosition=val;landMark = '${address.first.postalCode} ${address.first.thoroughfare} ${address.first.locality} ${address.first.subAdminArea} ${address.first.adminArea}';});
                },
                center:initialPosition,
                zoom: 17.0,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:'https://api.mapbox.com/styles/v1/logcat2020/ckgare7kl0mue19nxv8slef1r/tiles/256/{z}/{x}/{y}@2x?access_token=sk.eyJ1IjoibG9nY2F0MjAyMCIsImEiOiJja2dhcmJrcmkwOXU2MnVsNHRjZGQzdjZ6In0.6wjgLjJbk1MoSKftZirDXA',
                  additionalOptions:{
                    'accessToken':'sk.eyJ1IjoibG9nY2F0MjAyMCIsImEiOiJja2dhcmJrcmkwOXU2MnVsNHRjZGQzdjZ6In0.6wjgLjJbk1MoSKftZirDXA',
                    'id':'mapbox.mapbox-streets-v8'
                  }
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: changePosition,
                      builder: (ctx) =>
                          Container(
                            child: Icon(Icons.location_on),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(landMark),
              FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  height: 50,
                  minWidth:globals.width/2.3,onPressed: (){
                  },color: Theme.of(context).primaryColor, child:Text('Get Location',style: TextStyle(letterSpacing:1.0,fontSize: 16,color: Colors.white),)),
            ],
          )
        ],
      ),

    );
  }
}
