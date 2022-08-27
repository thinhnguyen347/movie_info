import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_slide/components/popular/popular_view.dart';
import 'package:movie_slide/components/top_rated/top_rated_view.dart';
import 'package:movie_slide/components/upcoming/upcoming_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  List<Widget> tabs = const [
    Text('Popular'),
    Text('Top Rated'),
    Text('Upcoming'),
    Text('Watched')
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: tabs.length);
    initialization();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DefaultTabController(
              initialIndex: 0,
              length: tabs.length,
              child: tabBar(controller: tabController, tabs: tabs),
            ),
            DefaultTabController(
                length: tabs.length,
                initialIndex: 0,
                child: tabBarView(controller: tabController)),
          ],
        )
      ],
    ));
  }
}

void initialization() async {
  await Future.delayed(const Duration(seconds: 5))
      .then((value) => {FlutterNativeSplash.remove()});
}

tabBar({required controller, required List<Widget> tabs}) {
  return Padding(
    padding: const EdgeInsets.only(top: 70, left: 25, bottom: 10),
    child: TabBar(
      controller: controller,
      tabs: tabs,
      indicatorColor: Colors.white,
      indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
      labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white38,
      isScrollable: true,
      labelStyle: const TextStyle(
          fontFamily: 'Comfortaa', fontSize: 24, fontWeight: FontWeight.bold),
    ),
  );
}

tabBarView({required controller}) {
  return Expanded(
      child: TabBarView(
    controller: controller,
    children: [
      const PopularView(),
      const TopRatedMovies(),
      const UpcomingMovies(),
      Container(color: Colors.pink.withAlpha(30)),
    ],
  ));
}