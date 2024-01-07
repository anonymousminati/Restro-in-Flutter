import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restro/widget/reusable_card.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.restaurantResponse,
      this.locationName});

  final double latitude;
  final double longitude;
  final Map<String, dynamic> restaurantResponse;
  final String? locationName; // Add this property

  static const String id = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> restaurants = [];
  List<Map<String, dynamic>> filteredRestaurants = [];
  @override
  void initState() {
    super.initState();

    // Extract the restaurant data from the API response
    if (widget.restaurantResponse['status'] == 'SUCCESS') {
      restaurants =
          List<Map<String, dynamic>>.from(widget.restaurantResponse['data']);
      filteredRestaurants = List<Map<String, dynamic>>.from(restaurants);

      print('Total restaurants: ${restaurants.length}');
      print(
          'First restaurant: ${restaurants.isNotEmpty ? restaurants[0] : null}');
    } else {
      print('API Error: ${widget.restaurantResponse['message']}');
      restaurants = [];
      filteredRestaurants = [];
    }
  }

  void _filterRestaurants(String query) {
    setState(() {
      filteredRestaurants = restaurants
          .where((restaurant) => restaurant['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 1],
          colors: [
            Color(0xFFF3B8B8),
            Color(0xffffffff),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.black,
                    size: 19,
                  ),
                  Text(
                    widget.locationName ?? "Unknown Location",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 21.0, vertical: 20),
                child: SizedBox(
                  height: 40,
                  child: FilterList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: _filterRestaurants,
                  cursorColor: Colors.black,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Food Items',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Nearby Restaurants",
                  style: TextStyle(
                      fontSize: 12,
                      height: 2,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = filteredRestaurants[index];
                    return ReusableCard(
                      imageURL: restaurant['primary_image'],
                      name: restaurant['name'],
                      rating: restaurant['rating'].toString(),
                      discount: restaurant['discount'].toString(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterList extends StatelessWidget {
  const FilterList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                elevation: 5,
                padding: EdgeInsets.all(10),
                backgroundColor: Colors.white),
            child: Text("All",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    backgroundColor: Colors.white,
                    color: Colors.black)),
          ),
          SizedBox(
            width: 10,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              backgroundColor: Colors.red,
            ),
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.pizzaSlice,
              color: Colors.orangeAccent,
              size: 24,
            ),
            label: Text(
              "Pizza",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.pizzaSlice,
              color: Colors.orangeAccent,
              size: 24,
            ),
            label: Text(
              "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.pizzaSlice,
              color: Colors.orangeAccent,
              size: 24,
            ),
            label: Text(
              "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              elevation: 5,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              backgroundColor: Colors.white,
            ),
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.pizzaSlice,
              color: Colors.orangeAccent,
              size: 24,
            ),
            label: Text(
              "",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
