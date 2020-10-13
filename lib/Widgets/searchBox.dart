import 'package:ecom/Store/searchProduct.dart';
import 'package:flutter/material.dart';

class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      InkWell(
        onTap: () {
          Route route = MaterialPageRoute(builder: (c) => SearchProduct());
          Navigator.pushReplacement(context, route);
        },
        child: Hero(
          tag: "searchBar",
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(0),
              ),
            ),
            alignment: Alignment.center,
            height: 80.0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: InkWell(
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => SearchProduct());
                    Navigator.pushReplacement(context, route);
                  },
                  child: TextField(
                    enabled: false,
                    showCursor: false,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle:
                          TextStyle(color: Colors.blueGrey[300], fontSize: 16),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 14.0),
                      suffixIcon: Material(
                        color: Colors.blue,
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        child: InkWell(
                          onTap: () {
                            Route route = MaterialPageRoute(
                                builder: (c) => SearchProduct());
                            Navigator.pushReplacement(context, route);
                          },
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
