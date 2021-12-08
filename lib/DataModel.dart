class DataModel{
  DataModel({
    required this.name,
    required this.price,
    required this.price_ch
  });
  String name;
  num price;
  double price_ch;

  DataModel.fromJson(Map<String,dynamic> json)
      : name = json['name'],
        price_ch=json['price_change_percentage_1h_in_currency'] ?? 0,
        price=json['current_price'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
    'name': name,
    'price_change_percentage_1h_in_currency': price_ch,
    'current_price':price
  };
}
List<DataModel> DataList =[];