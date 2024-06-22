import 'package:charterer/presentation/screens/add_charterer_screen.dart';
import 'package:charterer/presentation/screens/auth/login_screen.dart';
import 'package:charterer/presentation/screens/auth/sign_up_screen.dart';
import 'package:charterer/presentation/screens/call_screen.dart';
import 'package:charterer/presentation/screens/chats/chat_screen.dart';
import 'package:charterer/presentation/screens/contact_screen.dart';
import 'package:charterer/presentation/screens/home_screen.dart';
import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/screens/notification_screen.dart';
import 'package:charterer/presentation/screens/profiles/edit_profile_screen.dart';
import 'package:charterer/presentation/screens/profiles/profile_screen.dart';
import 'package:charterer/presentation/screens/stories/confirm_stories_screen.dart';
import 'package:charterer/presentation/screens/stories/story_view_screen.dart';
import 'package:get/get.dart';

class Routes {
  static String login = '/loginPage';
  static String signup = '/signup';
  static String homePage = '/homePage';
  static String mainPage = '/mainPage';
  static String callScreen = '/callScreen';
  static String profileScreen = '/profileScreen';
  static String contactScreen = '/contactScreen';
  static String addChartererScreen = '/addChartererScreen';
  static String notificationPage = '/notificationPage';
  static String chatPage = '/chatPage';
  static String editProfile = '/editProfile';
  static String confirmStory = '/confirmStory';
  static String storyview = '/storyview';
}

final getPages = [
  GetPage(name: Routes.login, page: () => const LoginScreen()),
  GetPage(name: Routes.signup, page: () => const SignUpScreen()),
  GetPage(name: Routes.homePage, page: () => const HomeScreen()),
  GetPage(name: Routes.mainPage, page: () => const MainPage()),
  GetPage(name: Routes.callScreen, page: () => const CallScreen()),
  GetPage(name: Routes.profileScreen, page: () => const ProfileScreen()),
  GetPage(name: Routes.editProfile, page: () => const EditProfileScreen()),
  GetPage(name: Routes.contactScreen, page: () => const ContactScreen()),
  GetPage(name: Routes.addChartererScreen, page: () => const AddCharterer()),
  GetPage(name: Routes.chatPage, page: () => const ChatScreen()),
  GetPage(name: Routes.confirmStory, page: () => ConfirmStoryScreen()),
  GetPage(name: Routes.storyview, page: () => const StoryViewScreen()),
  GetPage(
      name: Routes.notificationPage, page: () => const NotificationScreen()),
];
