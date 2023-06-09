import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:woostorestackflutter/utils/Constants.dart';

import '../services/ContractFactoryServies.dart';
import '../widgets/CustomProductCardWidget.dart';

class CategoryProductsPage extends StatelessWidget {
  String categoryName;
   CategoryProductsPage({ required this.categoryName,Key? key}) : super(key: key);
   Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    var contractFactory = Provider.of<ContractFactoryServies>(context);
    var reversedProducts = (contractFactory.categoryProducts).reversed.toList();

    return  Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: constants.mainYellowColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
           reversedProducts.isNotEmpty ? Container(
             child: AlignedGridView.count(
                 physics: NeverScrollableScrollPhysics(),
                 mainAxisSpacing: 15,
                 crossAxisSpacing: 15,
                 padding: EdgeInsets.all(15),
                 itemCount: reversedProducts.length,
                 shrinkWrap: true,
                 scrollDirection: Axis.vertical,
                 crossAxisCount: 2,
                 itemBuilder: (context, index) {
                   return customProductCardWidget(
                       context,reversedProducts[index].image, reversedProducts[index].name, reversedProducts[index].price.toString(),reversedProducts[index]);
                 }),
           ):Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(child: Text("No Product at This Category ",style: TextStyle(color: constants.mainRedColor,fontWeight: FontWeight.bold),)),
           )
          ],
        ),
      ),
    );
  }
}
