part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Province> provinceData = [];

  ///
  bool isLoading = false;

  // Future<dynamic> getProvinces() async {
  //   ////
  //   await MasterDataService.getProvince().then((value) {
  //     setState(() {
  //       provinceData = value;

  //       ///
  //       isLoading = false;
  //     });
  //   });
  // }
  TextEditingController yourTextController = TextEditingController();
  dynamic courierData;
  dynamic weight;
  dynamic cityDataOrigin;
  dynamic cityIdOrigin;
  dynamic selectedCityOrigin;
  dynamic provinceDataOrigin;
  dynamic provinceIdOrigin;
  dynamic selectedprovinceOrigin;
  dynamic cityDataDestination;
  dynamic cityIdDestination;
  dynamic selectedCityDestination;
  dynamic provinceDataDestination;
  dynamic provinceIdDestination;
  dynamic selectedprovinceDestination;

  Future<List<City>> getCities(var provId) async {
    ////
    dynamic city;
    await MasterDataService.getCity(provId).then((value) {
      setState(() {
        city = value;
      });
    });

    return city;
  }

  Future<List<Province>> getProvince() async {
    ////
    dynamic province;
    await MasterDataService.getProvince().then((value) {
      setState(() {
        province = value;
      });
    });

    return province;
  }

    Future<List<Costs>> getCosts() async {
    ////
    dynamic cost;
    await MasterDataService.getCosts().then((value) {
      setState(() {
        cost = value;
      });
    });

    return cost;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    provinceDataDestination = getProvince();
    provinceDataOrigin = getProvince(); ////
    cityDataOrigin = getCities('');
    cityDataDestination = getCities('');

    int weight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Hitung Ongkir"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Left Dropdown
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(' '),
                            Container(
                              width: 150,
                              child: FutureBuilder<List<City>>(
                                future: cityDataOrigin,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return DropdownButton(
                                      isExpanded: true,
                                      value: courierData,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 4,
                                      style: TextStyle(color: Colors.black),
                                      hint: courierData == null
                                          ? Text('Pilih kurir')
                                          : Text(courierData == 'jne'
                                              ? 'jne'
                                              : courierData == 'pos'
                                                  ? 'pos'
                                                  : courierData == 'tiki'
                                                      ? 'tiki'
                                                      : courierData.cityName),
                                      items: snapshot.hasData
                                          ? [
                                              DropdownMenuItem(
                                                value: 'jne',
                                                child: Text('jne'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'pos',
                                                child: Text('pos'),
                                              ),
                                              DropdownMenuItem(
                                                value: 'tiki',
                                                child: Text('tiki'),
                                              ),
                                              ...snapshot.data!
                                                  .map<DropdownMenuItem<City>>(
                                                      (City value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Text(value.cityName
                                                      .toString()),
                                                );
                                              }).toList(),
                                            ]
                                          : [], // Placeholder when no city data
                                      onChanged: (newValue) {
                                        setState(() {
                                          // Handle the selected courier (JNE, POS, TIKI)
                                          courierData = newValue;
                                          // You may want to set cityIdOrigin to null or handle it differently
                                        });
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Tidak ada data");
                                  }
                                  return UiLoading.loadingSmall();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right Dropdown (Add a similar structure for the right dropdown)
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(''),
                            Container(
                              width: 150,
                              child: TextField(
                                controller: yourTextController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                        r'^\d*\.?\d*$'), // Allow digits and a dot for decimal numbers
                                  ),
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Mass (in grams)',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  // Handle text input changes
                                  print("Input changed: $text");
                                  setState(() {
                                    weight = double.tryParse(text) ??
                                        0.0; // Parse input as double or default to 0.0
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Left Dropdown
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Origin'),
                            Container(
                              width: 150,
                              child: FutureBuilder<List<Province>>(
                                future: provinceDataOrigin,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return DropdownButton(
                                      isExpanded: true,
                                      value: selectedprovinceOrigin,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 4,
                                      style: TextStyle(color: Colors.black),
                                      hint: selectedprovinceOrigin == null
                                          ? Text('Pilih Provinsi')
                                          : Text(
                                              selectedprovinceOrigin.province),
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<Province>>(
                                              (Province value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                                value.province.toString()));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedprovinceOrigin = newValue;
                                          provinceIdOrigin =
                                              selectedprovinceOrigin.provinceId;
                                          print(
                                              "Calling getCities with provinceId: $provinceIdOrigin");
                                          selectedCityOrigin = null;
                                          cityIdOrigin = null;
                                          cityDataOrigin =
                                              getCities(provinceIdOrigin);
                                        });
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Tidak ada data");
                                  }
                                  return UiLoading.loadingSmall();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right Dropdown (Add a similar structure for the right dropdown)
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(' '),
                            Container(
                              width: 150,
                              child: FutureBuilder<List<City>>(
                                future: cityDataOrigin,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return UiLoading.loadingSmall();
                                  } else if (snapshot.hasData) {
                                    return DropdownButton(
                                      isExpanded: true,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 4,
                                      style: TextStyle(color: Colors.black),
                                      hint: selectedCityOrigin == null
                                          ? Text('Pilih kota')
                                          : Text(selectedCityOrigin.cityName),
                                      value: selectedCityOrigin,
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<City>>(
                                              (City value) {
                                        print("City in list: $value");
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                                value.cityName.toString()));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCityOrigin = newValue;
                                          cityIdOrigin =
                                              selectedCityOrigin.cityId;
                                        });
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Tidak ada data");
                                  }
                                  return UiLoading.loadingSmall();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Left Dropdown
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Destination'),
                            Container(
                              width: 150,
                              child: FutureBuilder<List<Province>>(
                                future: provinceDataDestination,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return DropdownButton(
                                      isExpanded: true,
                                      value: selectedprovinceDestination,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 4,
                                      style: TextStyle(color: Colors.black),
                                      hint: selectedprovinceDestination == null
                                          ? Text('Pilih Provinsi')
                                          : Text(selectedprovinceDestination
                                              .province),
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<Province>>(
                                              (Province value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                                value.province.toString()));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedprovinceDestination =
                                              newValue;
                                          provinceIdOrigin =
                                              selectedprovinceDestination
                                                  .provinceId;
                                          selectedCityDestination = null;
                                          cityIdDestination = null;
                                          cityDataDestination =
                                              getCities(provinceIdOrigin);
                                        });
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Tidak ada data");
                                  }
                                  return UiLoading.loadingSmall();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Right Dropdown (Add a similar structure for the right dropdown)
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(' '),
                            Container(
                              width: 150,
                              child: FutureBuilder<List<City>>(
                                future: cityDataDestination,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return UiLoading.loadingSmall();
                                  } else if (snapshot.hasData) {
                                    return DropdownButton(
                                      isExpanded: true,
                                      value: selectedCityDestination,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 30,
                                      elevation: 4,
                                      style: TextStyle(color: Colors.black),
                                      hint: selectedCityDestination == null
                                          ? Text('Pilih kota')
                                          : Text(
                                              selectedCityDestination.cityName),
                                      items: snapshot.data!
                                          .map<DropdownMenuItem<City>>(
                                              (City value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                                value.cityName.toString()));
                                      }).toList(),
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectedCityDestination = newValue;
                                          cityIdDestination =
                                              selectedCityDestination.cityId;
                                        });
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return Text("Tidak ada data");
                                  }
                                  return UiLoading.loadingSmall();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(''), // Add some space above the button
                    Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(
                          vertical: 2.0), // Adjust padding as needed
                      child: ElevatedButton(
                        onPressed: () {
                          // Add the functionality you want when the button is pressed
                          // For example, you can open a new screen or perform an action.
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue, // Set the button color
                          onPrimary: Colors.white, // Set the text color
                        ),
                        child: Text('Calculate'),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: provinceData.isEmpty
                        ? const Align(
                            alignment: Alignment.center,
                            child: Text("Data tidak ditemukan"),
                          )
                        : ListView.builder(
                            itemCount: provinceData.length,
                            itemBuilder: (context, index) {
                              return CardProvince(provinceData[index]);
                            })),
              ),
            ],
          ),
          // isLoading == true ? UiLoading.loadingBlock() : Container()
        ],
      ),
    );
  }
}
