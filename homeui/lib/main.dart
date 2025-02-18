import 'package:flutter/material.dart';

void main() {
  runApp(Home360App());
}

class Home360App extends StatelessWidget {
  const Home360App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home 360',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void _login() {
    if (userController.text == 'team17' && passController.text == 'password') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: 'User ID'),
            ),
            TextField(
              controller: passController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home 360', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            FeatureCard(
                title: 'HOME CONTROL',
                icon: Icons.security,
                color: const Color.fromARGB(255, 111, 5, 140),
                onTap: () => navigateToFeature(
                    context,
                    'HOME CONTROL',
                    Icons.security,
                    'Detects unauthorized access and sends alerts.')),
            FeatureCard(
                title: 'Theft Detection',
                icon: Icons.security,
                color: Colors.redAccent,
                onTap: () => navigateToFeature(
                    context,
                    'Theft Detection',
                    Icons.security,
                    'Detects unauthorized access and sends alerts.')),
            FeatureCard(
                title: 'Live Cam',
                icon: Icons.videocam,
                color: Colors.blueAccent,
                onTap: () => navigateToFeature(context, 'Live Cam',
                    Icons.videocam, 'Streams live video from home cameras.')),
            FeatureCard(
                title: 'Fitness',
                icon: Icons.fitness_center,
                color: Colors.greenAccent,
                onTap: () => navigateToFeature(
                    context,
                    'Fitness',
                    Icons.fitness_center,
                    'Monitors workouts and health metrics.')),
            FeatureCard(
                title: 'Vehicle Management',
                icon: Icons.directions_car,
                color: Colors.orangeAccent,
                onTap: () => navigateToFeature(
                    context,
                    'Vehicle Management',
                    Icons.directions_car,
                    'Tracks and manages vehicle status.')),
            FeatureCard(
                title: 'Energy Meter',
                icon: Icons.electric_meter,
                color: Colors.purpleAccent,
                onTap: () => navigateToFeature(
                    context,
                    'Energy Meter',
                    Icons.electric_meter,
                    'Monitors electricity usage efficiently.')),
          ],
        ),
      ),
    );
  }
}

void navigateToFeature(
    BuildContext context, String title, IconData icon, String description) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => FeatureDetailScreen(
          title: title, icon: icon, description: description),
    ),
  );
}

class FeatureDetailScreen extends StatelessWidget {
  final String title;
  final IconData icon;
  final String description;

  const FeatureDetailScreen(
      {super.key,
      required this.title,
      required this.icon,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text(title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(description,
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('Demo'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}