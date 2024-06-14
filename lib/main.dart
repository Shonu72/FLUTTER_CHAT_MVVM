import 'package:charterer/firebase_options.dart';
import 'package:charterer/presentation/getx/controllers/auth_controller.dart';
import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/home_screen.dart';
import 'package:charterer/presentation/screens/login_screen.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/screens/sign_up_screen.dart';
import 'package:charterer/presentation/widgets/custom_loading_widget.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'core/theme/theme.dart';
import 'core/utils/environment.dart';
import 'di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  DependencyInjector.inject();
  Dio dio = Dio();

  Get.put(AuthController(dio));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
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
      _isLoggedIn = prefs.getBool('loggedIn') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Charterer',
        theme: ApplicationTheme.getAppThemeData(),
        home: _isLoggedIn ? const MainPage() : const LoginScreen(),
        getPages: getPages,
        builder: FlutterSmartDialog.init(
          loadingBuilder: (String msg) => const CustomLoadingWidget(),
        ),
      );
    });
  }
}
