import 'package:flutter/material.dart';
import 'package:battleships/Utils/Authorization.dart';
import 'models/battleshiphome.dart';

void main() {
  runApp(Battleship());
}

class Battleship extends StatelessWidget {
  final AuthService authService = AuthService();

  Battleship({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BattleshipPage(),
    );
  }
}

class BattleshipPage extends StatefulWidget {
  final AuthService authService = AuthService();

  BattleshipPage({super.key});

  @override
  _BattleshipPageState createState() => _BattleshipPageState();
}

class _BattleshipPageState extends State<BattleshipPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://wallpapercave.com/uwp/uwp3828149.png',
                ), // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Form Container
          Center(
            child: Container(
              padding: EdgeInsets.all(20.0),
              margin: EdgeInsets.symmetric(horizontal: 40.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5), // Adds transparency to the background color
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Title
                  const Text(
                    'Battleship',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // Username Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.white),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: const Color.fromARGB(255, 59, 213, 255)), 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: const Color.fromARGB(255, 59, 190, 255)), 
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white), // White border color
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.white), // White border color
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  // Register Button
                  ElevatedButton(
                    onPressed: () async {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      try {
                        final response = await widget.authService.registerUser(username, password);
                        if (response.containsKey('message')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('User created successfully'),
                            ),
                          );
                        } else {
                          throw Exception(response['error']);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$e'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Color.fromARGB(255, 59, 213, 255),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // Login Button
                  TextButton(
                    onPressed: () async {
                      final username = usernameController.text;
                      final password = passwordController.text;
                      try {
                        final response = await widget.authService.loginUser(
                          username,
                          password,
                        );
                        if (response.containsKey('message')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login successful'),
                            ),
                          );
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoggedInScreen(
                                user_name: username,
                                access_token: response['access_token']),
                          ));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$e'),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
