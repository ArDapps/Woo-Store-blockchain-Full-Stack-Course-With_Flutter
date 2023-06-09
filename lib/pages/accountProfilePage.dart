
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woostorestackflutter/utils/Constants.dart';
import 'package:woostorestackflutter/widgets/CustomProductCardWidget.dart';

import '../services/ContractFactoryServies.dart';

class AccountProfilePage extends StatelessWidget {
  String account;
   AccountProfilePage({required this.account,Key? key}) : super(key: key);
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    var contractFactory = Provider.of<ContractFactoryServies>(context);

    return  Scaffold(
      backgroundColor: constants.mainBGColor,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: constants.mainYellowColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Account Address",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text(account,style: TextStyle(fontSize: 11,fontWeight: FontWeight.normal),),
                        SizedBox(height: 10,),
                        Text("Account Balance",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Text("ETH ${contractFactory.myBalance}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:22.0),
              child: Container(height: 40,
              width: 130,
              decoration: BoxDecoration(color: constants.mainYellowColor),child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height *0.70,
                child: ListView.builder(
                  itemCount: contractFactory.allUserProducts.length,
                    itemBuilder: (context,index){
                  return customProductCardWidget(context, contractFactory.allUserProducts[index].image, contractFactory.allUserProducts[index].name, contractFactory.allUserProducts[index].price.toString(), contractFactory.allUserProducts[index]);
                }),
              ),
            ),


          ],
        ),
      ),

    );
  }
}
