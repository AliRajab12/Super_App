import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../utils/google_search/geo_coding.dart';
import 'dart:convert';
import '../utils/google_search/geo_location.dart';
import '../utils/google_search/place.dart';
import '../utils/google_search/place_type.dart';

class SearchLocation extends StatefulWidget {
  //final Key ? key;

  /// API Key of the Google Maps API.
  final String apiKey;
  //text change im search
  final void Function(String value)? onChangeText;

  final void Function()? onClearIconPress;

  /// Placeholder text to show when the user has not entered any input.
  final String placeholder;

  /// The callback that is called when one Place is selected by the user.
  final void Function() onSelected;

  /// The callback that is called when the user taps on the search icon.
  final void Function(Place place)? onSearch;

  /// Language used for the autocompletion.
  ///
  /// Check the full list of [supported languages](https://developers.google.com/maps/faq#languagesupport) for the Google Maps API
  final String language;

  /// set search only work for a country
  ///
  /// While using country don't use LatLng and radius
  final String? country;

  /// The point around which you wish to retrieve place information.
  ///
  /// If this value is provided, `radius` must be provided aswell.
  final LatLng? location;

  /// The distance (in meters) within which to return place results. Note that setting a radius biases results to the indicated area, but may not fully restrict results to the specified area.
  ///
  /// If this value is provided, `location` must be provided aswell.
  ///
  /// See [Location Biasing and Location Restrict](https://developers.google.com/places/web-service/autocomplete#location_biasing) in the documentation.
  final int? radius;

  /// Returns only those places that are strictly within the region defined by location and radius. This is a restriction, rather than a bias, meaning that results outside this region will not be returned even if they match the user input.
  final bool strictBounds;

  /// Place type to filter the search. This is a tool that can be used if you only want to search for a specific type of location. If this no place type is provided, all types of places are searched. For more info on location types, check https://developers.google.com/places/web-service/autocomplete?#place_types
  final PlaceType? placeType;

  /// The initial icon to show in the search box
  final IconData icon;

  /// Makes available "clear textfield" button when the user is writing.
  final bool hasClearButton;

  /// The icon to show indicating the "clear textfield" button
  final IconData clearIcon;

  /// The color of the icon to show in the search box
  final Color iconColor;

  TextEditingController llg;
  final TextEditingController controller;

  /// Enables Dark Mode when set to `true`. Default value is `false`.
  final bool darkMode;
  final String? initvalue;
  SearchLocation({
    required this.apiKey,
    this.placeholder = 'Search',
    this.icon = Icons.search,
    required this.llg,
    this.hasClearButton = true,
    this.clearIcon = Icons.clear,
    this.iconColor = Colors.blue,
    required this.onSelected,
    this.onSearch,
    this.initvalue,
    this.onChangeText,
    this.onClearIconPress,
    this.language = 'en',
    this.country,
    this.location,
    this.radius,
    this.strictBounds = false,
    this.placeType,
    this.darkMode = false,
    Key? key, required this.controller,
  }) : super(key: key);

  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation>
    with TickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  late AnimationController _animationController;
  // SearchContainer height.
  Animation? _containerHeight;
  // Place options opacity.
  Animation? _listOpacity;

  List<dynamic> _placePredictions = [];
  bool _isEditing = false;
  Geocoding? geocode;

  String _tempInput = "";
  String _currentInput = "";

  FocusNode _fn = FocusNode();

  late CrossFadeState _crossFadeState;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      geocode = Geocoding(apiKey: widget.apiKey, language: widget.language);
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 500));
      _containerHeight = Tween<double>(begin: 55, end: 364).animate(
        CurvedAnimation(
          curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
          parent: _animationController,
        ),
      );
      _listOpacity = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
          parent: _animationController,
        ),
      );

      _textEditingController.addListener(_autocompletePlace);


      if (widget.hasClearButton) {
        _fn.addListener(() async {
          if (_fn.hasFocus)
            setState(() => _crossFadeState = CrossFadeState.showSecond);
          else
            setState(() => _crossFadeState = CrossFadeState.showFirst);
        });
        _crossFadeState = CrossFadeState.showFirst;
      }
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() { });
    if (widget.initvalue != null) {
      _textEditingController.text = widget.initvalue!;
      setState(() {});
    }
  }

  void _autocompletePlace() async {
    if (_fn.hasFocus) {
      setState(() {
        _currentInput = _textEditingController.text;
        _isEditing = true;
      });

      _textEditingController.removeListener(_autocompletePlace);

      if (_currentInput.length == 0) {

        _textEditingController.addListener(_autocompletePlace);
        return;
      }

      if (_currentInput == _tempInput) {
        final predictions = await _makeRequest(_currentInput);
        await _animationController.animateTo(0.4);
        setState(() => _placePredictions = predictions);
        await _animationController.forward();

        _textEditingController.addListener(_autocompletePlace);
        return;
      }

      Future.delayed(Duration(milliseconds: 400), () {
        _textEditingController.addListener(_autocompletePlace);
        if (_isEditing == true) _autocompletePlace();
      });
    }
  }

  Future<dynamic> _makeRequest(input) async {
    // address
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${widget.apiKey}&language=${widget.language}";
    if (widget.location != null && widget.radius != null) {
      url +=
          "&location=${widget.location!.latitude},${widget.location!.longitude}&radius=${widget.radius}";
      if (widget.strictBounds) {
        url += "&strictbounds";
      }
    }

    if (widget.placeType != null) {
      url += "&types=${widget.placeType!.apiString}";
    }

    if (widget.country != null) {
      url += "&components=country:${widget.country}";
    }
    final response = await http.get(Uri.parse(url));
    final extractedData = json.decode(response.body);

    if (extractedData['error_message'] != null) {
      var error = extractedData['error_message'];
      if (error == 'This API project is not authorized to use this API.')
        error +=
            ' Make sure the Places API is activated on your Google Cloud Platform';
      throw Exception(error);
    } else {
      final predictions = extractedData['predictions'];
      List list2=List.from(predictions);

      return list2;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();
    widget.controller.removeListener(() { });
    _fn.dispose();
    super.dispose();
  }

List<Place> l1=[];
List<String> l2=[];

  @override
  Widget build(BuildContext context) {
    return _searchInput(context);
  }

  Widget _searchInput(BuildContext context) {
    return Container(alignment: Alignment.center,
    padding: EdgeInsets.all(10),child:
      EasyAutocomplete(
        controller: widget.controller,
            asyncSuggestions: (searchValue) async=>_onChange(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Type Location',
               border: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50)
               ) ,
              focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50)
              ),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(50)
              )
            ),
            suggestionBuilder: (data)=>l2.isEmpty?SizedBox(height: 0,width: 0):ListTile(
              title: Text(data),
              leading: Icon(Icons.location_on),
              onTap: ()async{
                Geolocation? gl=await l1.firstWhere((element) => element.description==data).geolocation;
                widget.llg.text=LatLng(gl!.fullJSON['geometry']['location']['lat'],gl.fullJSON['geometry']['location']['lng']).toString();
                  widget.controller.text=data;FocusManager.instance.primaryFocus!.unfocus();
                  widget.onSelected;
              },
            ),
            onChanged: (value) => _onChange,
            onSubmitted: (value) => _onChange
        ));
  }

Future<List<String>> _onChange() async {
    if(widget.controller.text.isNotEmpty) {
      List l = await _makeRequest(widget.controller.text); l1.clear();
      l.forEach((element) {
        l1.addAll([Place.fromJSON(element, geocode!)]);
      });
      l2.clear(); l2.addAll(l1.map((e) => e.description).toList());
    }
    return widget.controller.text.isNotEmpty?l2:[];
  }

}
