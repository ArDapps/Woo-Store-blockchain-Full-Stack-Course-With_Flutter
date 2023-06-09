import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woostorestackflutter/pages/accountProfilePage.dart';
import 'package:woostorestackflutter/widgets/CustomButtonWIdget.dart';

import '../services/ContractFactoryServies.dart';
import '../utils/Constants.dart';

class headingCoverWidget extends StatefulWidget {
  const headingCoverWidget({Key? key}) : super(key: key);

  @override
  State<headingCoverWidget> createState() => _headingCoverWidgetState();
}

var _session;

class _headingCoverWidgetState extends State<headingCoverWidget> {
  Constants constants = Constants();
  @override
  Widget build(BuildContext context) {
    var contractFactory = Provider.of<ContractFactoryServies>(context);

    // Subscribe to events
    contractFactory.connector.on(
        'connect',
        (session) => setState(() {
              _session = session;
            }));
    contractFactory.connector.on(
        'session_update',
        (session) => setState(() {
              _session = session;
            }));
    contractFactory.connector.on(
        'disconnect',
        (session) => setState(() {
              _session = session;
            }));


    var account = _session?.accounts[0];

    if(account !=null){
       contractFactory.saveAccountAddress(account);

    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.40,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/cover.png"),
                  fit: BoxFit.cover,
                  scale: 1)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: Text(
                    "Discovery Web3 Products",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
            _session == null

                    ? customButtonWidget(() async {
                        await contractFactory.connectWallet();

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>AccountProfilePage()));
                      }, 25, constants.mainBGColor, "Connect Wallet",
                        constants.mainBlackColor, 150)
                    : (account != null)?customButtonWidget(() async {
              contractFactory.getUserProducts();
                      await contractFactory.fetchMyBalance(account);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountProfilePage(account: account,)));
                      }, 25, constants.mainRedColor, account.toString().substring(1,10),
                        constants.mainWhiteGColor, 150)
                : Text("Account Not Found")
          ],
        )
      ],
    );
  }
}
