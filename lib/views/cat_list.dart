import 'package:flutter/material.dart';
import 'package:forbes400_flutter/views/dynamic_net_worth.dart';
import '../wp-api.dart';

class CategoriesNetWorth extends StatefulWidget{
  const CategoriesNetWorth({Key? key}) : super(key: key);

  @override
  _CategoriesNetWorthState createState() => _CategoriesNetWorthState();
}

class _CategoriesNetWorthState extends State<CategoriesNetWorth> {

  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchFromFile(),
          builder: (context, AsyncSnapshot snapshot){
            Widget categoriesSliver;
            Map catWorth;
            if (snapshot.hasData) {
              categoriesSliver = SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      catWorth = snapshot.data[index];
                      return CategoryTile(
                        catName: catWorth['catname'],
                        url: catWorth['uri'],
                      );
                    },
                    childCount: snapshot.data.length,
                  )
              );
            } else {
              categoriesSliver = const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())
              );
            }
            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  pinned: true,
                  expandedHeight: 100.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("Categories"),
                  ),
                ),
                SliverSafeArea(
                    top: false,
                    minimum: const EdgeInsets.only(top: 8),
                    sliver: categoriesSliver
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatefulWidget {

  final String catName, url;

  CategoryTile({
    required this.catName,
    required this.url,
  });

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<CategoryTile> {
  String imgUrl = "";

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DynamicNetWorth(catName: widget.catName, url: widget.url)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(widget.catName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            const SizedBox(height: 24),
            Container(
              height: 1,
              width: (MediaQuery.of(context).size.width/1.5),
              color: Colors.grey,
            ),
          ],),
      ),
    );
  }
}