import 'package:charterer/presentation/getx/routes/routes.dart';
import 'package:charterer/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 34, 51),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 37, 34, 51),
            title: const Text(
              "Messages",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
            leading: Transform.rotate(
                angle: 360 * math.pi / 180,
                child: IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MySearchDelegate(),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.white,
                  ),
                )),
            actions: [
              GestureDetector(
                onTap: () {
                  // Get.toNamed(Routes.profileScreen);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                      'assets/images/boy.png',
                    ),
                  ),
                ),
              )
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Stories",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    // stories list
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            top: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 25,
                                backgroundImage: AssetImage(
                                  'assets/images/boy.png',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text("Conversations",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                    ),
                    Expanded(
                      // conversations list
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                top: 10,
                                right: 10,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 47, 45, 57),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.chatPage);
                                  },
                                  child: ListTile(
                                      leading: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        maxRadius: 30,
                                        backgroundImage: AssetImage(
                                          'assets/images/boy.png',
                                        ),
                                      ),
                                      title: const Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "Message",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white.withOpacity(0.5),
                                        ),
                                      ),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("03:17 pm",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              )),
                                          const SizedBox(height: 5),
                                          Text("2",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.blue
                                                    .withOpacity(0.5),
                                              )),
                                        ],
                                      )),
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class MySearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search...';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "null");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your result display logic here
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your suggestion display logic here
    return Container();
  }

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return Theme.of(context).copyWith(
  //     inputDecorationTheme: searchFieldDecorationTheme?.copyWith(
  //       labelStyle: TextStyle(color: Colors.white),
  //     ),
  //     scaffoldBackgroundColor: Colors.black.withOpacity(0.5),
  //     appBarTheme: Theme.of(context).appBarTheme.copyWith(
  //           backgroundColor: Colors.black.withOpacity(0.5),
  //           iconTheme: IconThemeData(color: Colors.white),
  //           titleTextStyle: TextStyle(color: Colors.white),
  //         ),
  //     textTheme: Theme.of(context).textTheme.copyWith(
  //           titleSmall: const TextStyle(color: Colors.white),
  //         ),
  //   );
  // }
}
