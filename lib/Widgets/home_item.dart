import 'package:fashion_cart_driver2/Widgets/map.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String nextWidget;
  final Function nextWidgetFunction;

  HomeItem(this.id, this.title, this.imageUrl,this.nextWidget, this.nextWidgetFunction);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        nextWidgetFunction(nextWidget);
      }),
      child: Container(
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 20,
              right: 10,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.35,
                color: Colors.black54,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 26, color: Colors.white),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
