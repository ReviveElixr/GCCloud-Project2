import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'SuccessPage.dart';
import 'ErrorPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? selectedChief;
  String? selectedSE;
  String? selectedEE;
  List<String> chiefs = [];
  List<String> seList = [];
  List<String> eeList = [];
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchChiefs();
  }

  Future<void> fetchChiefs() async {
    try {
      final response = await http.get(Uri.parse("http://117.250.2.226:6060/mobile/ce2"));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> uniqueChiefs = responseData['data'].toList();
        setState(() {
          chiefs = uniqueChiefs.cast<String>();
        });
      } else {
        throw Exception('Failed to load chiefs');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchSEs(String chief) async {
    try {
      final response = await http.get(Uri.parse("http://117.250.2.226:6060/mobile/se/$chief"));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> uniqueSEs = responseData['data'].toSet().toList();
        setState(() {
          seList = uniqueSEs.cast<String>();
        });
      } else {
        throw Exception('Failed to load SEs');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchEEs(String se) async {
    try {
      final response = await http.get(Uri.parse("http://117.250.2.226:6060/mobile/ee/$se"));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> uniqueEEs = responseData['data'].toList();
        setState(() {
          eeList = uniqueEEs.cast<String>();
        });
      } else {
        throw Exception('Failed to load EEs');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> loginUser() async {
    if (selectedEE != null) {
      final String username = selectedEE!;
      final String password = passwordController.text;
      final response = await http.post(
        Uri.parse("http://117.250.2.226:6060/mobile/login?username=$username&password=$password"),
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SuccessPage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ErrorPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DropdownButton<String>(
                value: selectedChief,
                hint: Text('Select Chief'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedChief = newValue;
                    selectedSE = null; // Reset SE selection when Chief changes
                    selectedEE = null; // Reset EE selection when Chief changes
                    fetchSEs(selectedChief!);
                  });
                },
                items: chiefs.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedSE,
                hint: Text('Select SE'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSE = newValue;
                    selectedEE = null; // Reset EE selection when SE changes
                    fetchEEs(selectedSE!);
                  });
                },
                items: seList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedEE,
                hint: Text('Select EE'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedEE = newValue;
                  });
                },
                items: eeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  loginUser();
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

