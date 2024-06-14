import 'package:charterer/presentation/screens/main_page.dart';
import 'package:charterer/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 37, 34, 51),
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 37, 34, 51),
            title: const Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Colors.white,
              ),
            ),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.short_text_rounded,
                        size: 30,
                        color: Colors.white,
                      )))
            ]),
        body: Column(
          children: [
            const Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
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
                                  color: Color.fromARGB(255, 44, 43, 52),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 30,
                                      backgroundImage: AssetImage(
                                        'assets/images/boy.png',
                                      ),
                                    ),
                                    title: const Row(
                                      children: [
                                        Text(
                                          "John Doe",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          " ~ 2h ago",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      "Liked your post",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                    trailing: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            "assets/images/bg.jpg"))),
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
