import 'dart:async';
import 'dart:convert';
import 'package:cryptoapp/setting.dart';
import 'package:cryptoapp/themeprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'DataModel.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(

         create: (context) => ThemeProvider(),
         builder: (context, _) {
         final themeProvider = Provider.of<ThemeProvider>(context);

         return MaterialApp(
         themeMode: themeProvider.themeMode,
         theme: MyThemes.lightTheme,
         darkTheme: MyThemes.darkTheme,
      home: Home(),
    );
  },
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<DataModel>> fetchCoin() async {
    DataList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            DataList.add(DataModel.fromJson(map));
          }
        }
        setState(() {
          DataList;
        });
      }
      return DataList;
    } else {
      throw Exception('Failed to load coins');
    }
  }
  @override
  void initState() {
    fetchCoin();
    Timer.periodic(Duration(seconds: 5), (timer) => fetchCoin());
    super.initState();
  }
  String dropdownValue ='USD';
  @override
  Widget build(BuildContext context) {
    debugShowCheckedModeBanner: false;
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isdarkmode = themeProvider.themeMode == ThemeMode.dark;
    if (isandroid) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: isdarkmode ? Colors.black :Colors.pinkAccent ,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(onPressed:(){
              Navigator.push((context),MaterialPageRoute(builder: (context)=>setting()));
              }
              , icon: Icon(Icons.settings),
                color: isdarkmode ? Colors.white:Colors.black,
                iconSize: 30,
              ),
            )
          ],
          title: Text(
            'Crypto App',
            style: TextStyle(
              color: isdarkmode ? Colors.white:Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: isdarkmode ? Colors.black:Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['USD', 'Euro', 'INR', 'Yuan']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: DataList.length,
          itemBuilder: (context, index) {
            String price=DataList[index].price.toDouble().toString();
            String price_ch=DataList[index].price_ch.toDouble()<0 ? DataList[index].price_ch.toDouble().toStringAsFixed(3): '+' +DataList[index].price_ch.toDouble().toStringAsFixed(3);
            String name =DataList[index].name;
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding:  const EdgeInsets.fromLTRB(0,8, 0,0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(name[0],),
                                radius: 25.0,
                              ) ,
                              title: Text(DataList[index].name,style: TextStyle(fontSize: 20),),
                              subtitle:Text('\$'+price+'\n'+'1 hour  '+price_ch+'%'),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },

        )
    );
    } else {
      return Column(
        //mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 760,
            child: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor:  isdarkmode ? Colors.black :Colors.white,
                middle: Text('Crypto App',style: TextStyle(color: isdarkmode ? Colors.white:Colors.black),),
                trailing: CupertinoButton(
                  child: Icon(CupertinoIcons.settings,color: isdarkmode ? Colors.white:Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(builder: (context){
                      return setting();
                    }));
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: DataList.length,
              itemBuilder: (context, index) {
                String price=DataList[index].price.toDouble().toString();
                String price_ch=DataList[index].price_ch.toDouble()<0 ? DataList[index].price_ch.toDouble().toStringAsFixed(3): '+' +DataList[index].price_ch.toDouble().toStringAsFixed(3);
                String name =DataList[index].name;
                return Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 0,
                              child: Padding(
                                padding:  const EdgeInsets.fromLTRB(0,8, 0,0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(name[0],),
                                    radius: 25.0,
                                  ) ,
                                  title: Text(DataList[index].name,style: TextStyle(fontSize: 20),),
                                  subtitle:Text('\$'+price+'\n'+'1 hour  '+price_ch+'%'),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            ),
          ),
          Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  color: isdarkmode ? Colors.black:Colors.white,
                  child: Center(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      onSelectedItemChanged: (int value) {  },
                      children: [
                        Text("USD",style: TextStyle(color: isdarkmode ? Colors.white:Colors.black)),
                        Text("Euro" ,style: TextStyle(color: isdarkmode ? Colors.white:Colors.black)),
                        Text("INR",style: TextStyle(color: isdarkmode ? Colors.white:Colors.black)),
                        Text("Yuan",style: TextStyle(color: isdarkmode ? Colors.white:Colors.black))],),
                  ),
                ),
              )
          )
        ],
      );

    }
  }
}