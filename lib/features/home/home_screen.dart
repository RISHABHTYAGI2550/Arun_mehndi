import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

import '../../widgets/side_drawer.dart';
import '../../models/user_model.dart';
import '../../core/helpers/storage_helper.dart';

import 'widgets/home_header.dart';
import 'widgets/search_bar.dart';
import 'widgets/offer_banner.dart';
import 'widgets/categories_section.dart';
import 'widgets/featured_courses.dart';
import 'widgets/upcoming_live_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {

    /// USER JSON FROM STORAGE
    String? userJson = await StorageHelper.getUser();

    if(userJson != null){

      Map<String,dynamic> userMap = jsonDecode(userJson);

      setState(() {
        currentUser = UserModel.fromJson(userMap);
      });

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      drawer: const SideDrawer(),

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),

        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.notifications_none,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),

        child: SafeArea(

          child: currentUser == null

          /// LOADING
              ? const Center(child: CircularProgressIndicator())

          /// HOME CONTENT
              : SingleChildScrollView(

            child: Column(
              children: [

                HomeHeader(user: currentUser!),

                const SizedBox(height: 10),

                const SearchBarWidget(),

                const OfferBanner(),

                const CategoriesSection(),

                const FeaturedCourses(),

                const UpcomingLiveClass(),

                const SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }
}