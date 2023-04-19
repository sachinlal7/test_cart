import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment_yebolo/model/product.dart';

class TestCartApp extends StatefulWidget {
  const TestCartApp({super.key});

  @override
  State<TestCartApp> createState() => _TestCartAppState();
}

class _TestCartAppState extends State<TestCartApp> {
  String value = "All";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: readJson(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Center(
                            child: DropdownButton(
                              value: value,
                              items: filterCategories(snapshot.data ?? [])
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  this.value = value ?? "All";
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children:
                                filterMenu(snapshot.data ?? [], value).map(
                                      (e) {
                                        return Card(
                                          child: ListTile(
                                            leading: const Icon(Icons.person),
                                            title: Text(e.name),
                                            subtitle: Text(e.details),
                                          ),
                                        );
                                      },
                                    ).toList() ??
                                    [],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<String> filterCategories(List<Product> products) {
    List<String> res = ['All'];
    res.addAll(products.map((e) => e.category).toSet().toList());
    return res;
  }

  List<Product> filterMenu(List<Product> products, String filter) {
    if (filter == 'All') {
      return products;
    } else {
      return products.where((element) => element.category == filter).toList();
    }
  }
}

Future<List<Product>> readJson() async {
  final String response = await rootBundle.loadString('assets/items.json');
  final data = await json.decode(response);
  List<Product> result =
      List<Product>.of((data as List).map((e) => Product.fromJson(e)));
  return result;
  // ...
}
