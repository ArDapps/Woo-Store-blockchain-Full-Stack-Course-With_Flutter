import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:woostorestackflutter/pages/CreateProductPage.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';
import 'package:woostorestackflutter/widgets/CustomProductCardWidget.dart';
import 'package:woostorestackflutter/widgets/CustomTextFieldWidgets.dart';
import 'package:woostorestackflutter/widgets/HeadingCoverWidget.dart';

import '../utils/Constants.dart';

class DiscoveryPage extends StatelessWidget {
  DiscoveryPage({Key? key}) : super(key: key);
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.mainBGColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateProductPage()));
        },
        backgroundColor: constants.mainYellowColor,
        child: Icon(
          Icons.add,
          size: 40,
          color: constants.mainBlackColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headingCoverWidget(context),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10),
              child: Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              child: ListView.builder(
                  itemCount: constants.categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 8),
                      child: Text(
                        constants.categoryList[index],
                        style: TextStyle(
                            fontSize: 15, color: constants.mainGrayColor),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10),
              child: Text(
                "Newest Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Container(
              child: AlignedGridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  padding: EdgeInsets.all(15),
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return customProductCardWidget(
                        context,constants.imageMoke, "Product ${index + 1}", "0.8");
                  }),
            )
          ],
        ),
      ),
    );
  }
}
