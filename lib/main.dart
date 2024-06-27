import 'package:charterer/di/injection.dart';
import 'package:charterer/domain/usecases/end_call_usecase.dart';
import 'package:charterer/domain/usecases/end_group_call_usecase.dart';
import 'package:charterer/domain/usecases/get_call_usecase.dart';
import 'package:charterer/domain/usecases/make_call_usecase.dart';
import 'package:charterer/domain/usecases/make_group_call_usecase.dart';
import 'package:charterer/firebase_options.dart';
import 'package:charterer/presentation/getx/controllers/call_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/auth/login_screen.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DependencyInjector.inject();
  Get.put(CallController(
      getCallStreamUseCase: Get.find<GetCallStreamUseCase>(),
      makeCallUseCase: Get.find<MakeCallUseCase>(),
      makeGroupCallUseCase: Get.find<MakeGroupCallUseCase>(),
      endCallUseCase: Get.find<EndCallUseCase>(),
      endGroupCallUseCase: Get.find<EndGroupCallUseCase>()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    getLoggedInStatus();
  }

  Future<void> getLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Charterer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? const MainPage(initialIndex: 0) : const LoginScreen(),
      getPages: getPages,
    );
  }
}
