import 'package:counter/views/pages/widget/category_tab_view.dart';
import 'package:counter/views/pages/widget/home_tab_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return 
       SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              TabBar(
                controller: _tabController,
                tabs: [Tab(text: "Home"), Tab(text: "category")],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [HomeTabView(), CategoryTabView()],
                ),
              ),
            ],
          ),
        ),
      
    );
  }
}
