import 'package:cryptoapp/themeprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
class setting extends StatefulWidget {
  @override
  _settingState createState() => _settingState();
}
bool get isandroid{
  if(android){
    return true;
  }else{
    return false;
  }
}
bool android = true;
class _settingState extends State<setting> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isdarkmode = themeProvider.themeMode == ThemeMode.dark;
    return android ? Scaffold(
       appBar: AppBar(
         backgroundColor: isdarkmode ? Colors.black12 :Colors.white,
         title: Text('Settings',style: TextStyle(color: isdarkmode ? Colors.white :Colors.black),
         ),
         iconTheme: IconThemeData(color: isdarkmode ? Colors.white :Colors.black),
       ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                      Text('Dark Mode',style: TextStyle(fontSize: 20),),
                      Padding(
                        padding: const EdgeInsets.only(left: 185),
                        child: FlutterSwitch(value: themeProvider.isDarkMode, onToggle: (value){
                        final provider = Provider.of<ThemeProvider>(context, listen: false);
                        provider.toggleTheme(value);
                        }),
                        ),
                    ],
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Android View',style: TextStyle(fontSize: 20),),
                  Padding(
                    padding: const EdgeInsets.only(left: 160.0),
                    child: FlutterSwitch(value: android, onToggle: (val){
                          setState(() {
                            android =val;
                          });
                        }
                    ),
                    ),
                    ]
                  )
              ),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    ) : CupertinoPageScaffold(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           Padding(
             padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
             child: Row(
               children: [
                 Text('Dark Mode',style: TextStyle(fontSize: 20,color: isdarkmode ? Colors.white:Colors.black,decoration: TextDecoration.none),),
                 Padding(
                   padding: const EdgeInsets.only(left: 185),
                   child: FlutterSwitch(value: themeProvider.isDarkMode, onToggle: (value){
                     final provider = Provider.of<ThemeProvider>(context, listen: false);
                     provider.toggleTheme(value);
                   }),
                 ),
               ],
             ),
           ),
           Divider(
             thickness: 2,
           ),
           Padding(
               padding: const EdgeInsets.all(8.0),
               child: Row(
                   children: [
                     Text('Android View',style: TextStyle(fontSize: 20,color: isdarkmode ? Colors.white:Colors.black,decoration: TextDecoration.none),),
                     Padding(
                       padding: const EdgeInsets.only(left: 160.0),
                       child: FlutterSwitch(value: android, onToggle: (val){
                         setState(() {
                           android =val;
                         });
                       }
                       ),
                     ),
                   ]
               )
           ),
           Divider(
             thickness: 2,
           ),
         ],
       ),
       navigationBar: CupertinoNavigationBar(
         backgroundColor:  isdarkmode ? Colors.black :Colors.white,
         middle: Text('Setting',style: TextStyle(color: isdarkmode ? Colors.white:Colors.black),),
       ),);
  }
}
