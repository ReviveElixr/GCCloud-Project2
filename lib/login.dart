import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String _selectedChief = "";
  String _selectedSE = "";
  String _selectedEE = "";
  List<String> chiefs = [];
  List<String> ses = [];
  List<String> ees = [];
  TextEditingController _passwordController = TextEditingController();

  

  @override
  void initState() {
    super.initState();
    fetchChiefs();
  }

  Future<void> fetchChiefs() async {
    try {
      final response = await http.get(Uri.parse('http://117.250.2.226:6060/mobile/ce2'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) { // Check if data is a list
          setState(() {
            chiefs = List<String>.from(data); // Convert list elements to strings
          });
        } else {
          throw Exception('Invalid format for chiefs data');
        }
      } else {
        throw Exception('Failed to load chiefs');
      }
    } catch (e) {
      print('Error fetching chiefs: $e');
      // Handle error gracefully, for example, display an error message
    }
  }

  /*Future<void> fetchChiefs() async {
    try {
      final response = await http.get(Uri.parse('http://117.250.2.226:6060/mobile/ce2'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic>? chiefData = responseData['data'];
        if (chiefData != null) {
          setState(() {
            chiefs = chiefData.cast<String>().toList();
          });
        } else {
          throw Exception('No chiefs data found in response');
        }
      } else {
        throw Exception('Failed to load chiefs: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chiefs: $e');
      // Handle error gracefully, for example, display an error message
    }
  }*/

  Future<void> fetchSEs(String chief) async {
    final response =
        await http.get(Uri.parse('http://117.250.2.226:6060/mobile/se/$chief'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        ses = List<String>.from(data);
      });
    } else {
      throw Exception('Failed to load SEs');
    }
  }

  Future<void> fetchEEs(String se) async {
    final response =
        await http.get(Uri.parse('http://117.250.2.226:6060/mobile/ee/$se'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        ees = List<String>.from(data);
      });
    } else {
      throw Exception('Failed to load EEs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedChief,
              onChanged: (newValue) {
                setState(() {
                  _selectedChief = newValue!;
                  fetchSEs(newValue);
                });
              },
              items: chiefs.map((chief) {
                return DropdownMenuItem(
                  child: Text(chief),
                  value: chief,
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Select Chief'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedSE,
              onChanged: (newValue) {
                setState(() {
                  _selectedSE = newValue!;
                  fetchEEs(newValue);
                });
              },
              items: ses.map((se) {
                return DropdownMenuItem(
                  child: Text(se),
                  value: se,
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Select SE'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedEE,
              onChanged: (newValue) {
                setState(() {
                  _selectedEE = newValue!;
                });
              },
              items: ees.map((ee) {
                return DropdownMenuItem(
                  child: Text(ee),
                  value: ee,
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Select EE'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement login API call here
                // Use _selectedChief, _selectedSE, _selectedEE, and _passwordController.text
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
