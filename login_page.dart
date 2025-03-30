import 'package:flutter/material.dart';
import 'buffer_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controllers for email and password inputs
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          // Background image for the login page
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Centered login form
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                color: Colors.white70,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Main heading
                      Text(
                        'BUFFER CAPACITY CALCULATOR',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      // Fun subline
                      Text(
                        'Keep your buffers happy!',
                        style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      // Existing 'Login' title
                      Text(
                        'Login',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      // Email field
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email ID",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Password field
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the buffer calculation page on successful login
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BufferCalculationPage()),
                          );
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
