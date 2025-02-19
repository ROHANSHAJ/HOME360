import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAb_61s6k2Eq0Wd_S9A8oNcHYj1DwprHjE",
      authDomain: "home-360-94ca3.firebaseapp.com",
      databaseURL: "https://home-360-94ca3-default-rtdb.firebaseio.com",
      projectId: "home-360-94ca3",
      storageBucket: "home-360-94ca3.firebasestorage.app",
      messagingSenderId: "107181179937",
      appId: "1:107181179937:web:b53f4ae96eefab6e964f60",
      measurementId: "G-3WE87PMR21",
    ),
  );
  runApp(const Home360App());
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
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    // Predefined credentials for testing
    const String predefinedUsername = 'team17';
    const String predefinedPassword = 'password';

    // Check if the entered credentials match the predefined ones
    if (_emailController.text == predefinedUsername &&
        _passwordController.text == predefinedPassword) {
      // Navigate to the HomeScreen directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      return; // Exit the function early
    }

    // If credentials don't match, proceed with Firebase authentication
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or Image
                Image.asset(
                  'assets/icon.png', // Add your image asset path
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to Home 360',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Email Field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Login id',
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),
                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Rest of the code remains the same (HomeScreen, FeatureCard, FeatureDetailScreen, LightControlScreen)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home 360',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            FeatureCard(
              title: 'Home Control',
              icon: Icons.control_camera_sharp,
              color: const Color.fromARGB(255, 111, 5, 140),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LightControlScreen()),
              ),
            ),
            FeatureCard(
              title: 'Theft Detection',
              icon: Icons.security,
              color: Colors.redAccent,
              onTap: () => navigateToFeature(
                context,
                'Theft Detection',
                Icons.security,
                'Detects unauthorized access and sends alerts.',
              ),
            ),
            FeatureCard(
              title: 'Live Cam',
              icon: Icons.videocam,
              color: Colors.blueAccent,
              onTap: () => navigateToFeature(
                context,
                'Live Cam',
                Icons.videocam,
                'Streams live video from home cameras.',
              ),
            ),
            FeatureCard(
              title: 'Fitness',
              icon: Icons.fitness_center,
              color: Colors.greenAccent,
              onTap: () => navigateToFeature(
                context,
                'Fitness',
                Icons.fitness_center,
                'Monitors workouts and health metrics.',
              ),
            ),
            FeatureCard(
              title: 'Vehicle Management',
              icon: Icons.directions_car,
              color: Colors.orangeAccent,
              onTap: () => navigateToFeature(
                context,
                'Vehicle Management',
                Icons.directions_car,
                'Tracks and manages vehicle status.',
              ),
            ),
            FeatureCard(
              title: 'Energy Meter',
              icon: Icons.electric_meter,
              color: Colors.purpleAccent,
              onTap: () => navigateToFeature(
                context,
                'Energy Meter',
                Icons.electric_meter,
                'Monitors electricity usage efficiently.',
              ),
            ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            Text(title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Demo'),
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
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
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

class LightControlScreen extends StatefulWidget {
  const LightControlScreen({super.key});

  @override
  _LightControlScreenState createState() => _LightControlScreenState();
}

class _LightControlScreenState extends State<LightControlScreen> {
  bool _isLightOn = false;
  final DatabaseReference _lightRef =
      FirebaseDatabase.instance.ref('lights/light1');

  @override
  void initState() {
    super.initState();
    _listenToLightStatus();
  }

  void _listenToLightStatus() {
    _lightRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          _isLightOn = data['isOn'] ?? false;
        });
      }
    });
  }

  void _toggleLight() async {
    setState(() {
      _isLightOn = !_isLightOn;
    });

    // Update the value in Firebase Realtime Database
    await _lightRef.set({
      'isOn': _isLightOn,
      'lastUpdated': ServerValue.timestamp,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Light Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isLightOn ? Icons.lightbulb : Icons.lightbulb_outline,
              size: 100,
              color: _isLightOn ? Colors.yellow : Colors.grey,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleLight,
              child: Text(_isLightOn ? 'Turn Off' : 'Turn On'),
            ),
          ],
        ),
      ),
    );
  }
}
