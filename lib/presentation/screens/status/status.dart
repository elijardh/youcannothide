import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class StatusPage extends StatefulWidget {
  const StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  double long  = 0;
  double lat = 0;



  Set<Marker> list = Set();

  Future getLocation() async {
    try {
      var userLocation = await Location().getLocation();
      setState(() {
        long = userLocation.longitude;
        lat = userLocation.latitude;
      });
    }
    catch (e) {
      throw e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    Marker marker = Marker(markerId: MarkerId("nanananan"),infoWindow: InfoWindow(
      title: "Dare YOO",
      snippet: "Needs Money",
    ),
      position: LatLng(
          lat,long
      ),
    );
    print(long + lat);

    list.add(marker);
  }

  GoogleMapController _googleMapController;

  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
                7.396389, 3.916667
            ),
            zoom: 11
        ),
        onMapCreated: (controller) => _googleMapController = controller,
        markers: list,
        mapType: MapType.normal,

      ),

      floatingActionButton: Column(
        children: [
          InkWell(
            onTap: () {
              _googleMapController.animateCamera(
                  CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                      lat, long
                  ))));
            },
            child: Icon(Icons.center_focus_strong_sharp),
          ),
          InkWell(
            child: Icon(Icons.center_focus_strong_sharp),
          ),
        ],
      ),
    );
  }
}
