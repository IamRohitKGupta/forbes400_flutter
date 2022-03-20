import 'package:flutter/material.dart';
import 'package:forbes400_flutter/views/rtnw_more_info.dart';
import '../allurl.dart';
import '../wp-api.dart';

class RealTimeNetWorth extends StatefulWidget{
  const RealTimeNetWorth({Key? key}) : super(key: key);

  @override
  _RealTimeNetWorthState createState() => _RealTimeNetWorthState();
}

class _RealTimeNetWorthState extends State<RealTimeNetWorth> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: fetchFromUrl(AllUrl().rtNetWorth),
          builder: (context, AsyncSnapshot snapshot){
            Widget rtNetWorthSliver;
            Map rtNetWorth;
            if (snapshot.hasData) {
              rtNetWorthSliver = SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          rtNetWorth = snapshot.data[index];
                          return NetWorthTile(
                            rank: rtNetWorth['rank'],
                            name: rtNetWorth['personName'],
                            netWorth: rtNetWorth['finalWorth']/1000.00,
                            country: rtNetWorth['countryOfCitizenship'],
                            source: rtNetWorth['source'],
                            squareImage: rtNetWorth['squareImage'] == null ? "assets/images/416x416.png" : " "+rtNetWorth['squareImage'],
                            imageExists: rtNetWorth['imageExists'],
                          );
                    },
                    childCount: snapshot.data.length,
                  )
              );
            } else {
              rtNetWorthSliver = const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())
              );
            }
            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  pinned: true,
                  expandedHeight: 100.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Real Time'),
                  ),
                ),
                SliverSafeArea(
                    top: false,
                    minimum: const EdgeInsets.only(top: 8),
                    sliver: rtNetWorthSliver
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class NetWorthTile extends StatefulWidget {
  final String name, country, source, squareImage;
  final int rank;
  final double netWorth;
  final bool imageExists;

  NetWorthTile({
    required this.rank,
    required this.name,
    required this.netWorth,
    required this.country,
    required this.source,
    required this.squareImage,
    required this.imageExists,
  });

  @override
  _NetWorthTileState createState() => _NetWorthTileState();
}

class _NetWorthTileState extends State<NetWorthTile> {
  String imgUrl = "";

  @override
  Widget build(BuildContext context) {
    if (widget.squareImage.substring(1, 2).contains("/")){
      imgUrl = "https:"+widget.squareImage.substring(1);
    } else {
      imgUrl = widget.squareImage.substring(1);
    }
    if (imgUrl.contains("https://specials-images.forbesimg.com/imageserve/6050f48ca1ab099ed6e290cc/416x416.jpg")) {
      imgUrl = "assets/images/416x416.png";
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => const RtnwMoreInfo()));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Row(children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FadeInImage.assetNetwork(
                    image: imgUrl,
                    placeholder: 'assets/images/416x416.png',
                  ),
                ),
              ),
              const SizedBox(width: 15),
              SizedBox(
                width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width/4)-40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(widget.rank.toString()+". ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width/2),
                          child: Text(widget.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis,)
                      )
                    ],),
                    const SizedBox(height: 6),
                    Row(children: [
                      Text("\$"+widget.netWorth.toStringAsFixed(2), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      const Text(" Billion", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                    ],),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Text("Country: "),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width/2)-15,
                          child: Text(widget.country)
                      )
                    ],),
                    const SizedBox(height: 6),
                    Row(children: [
                      const Text("Source: "),
                      SizedBox(
                          width: (MediaQuery.of(context).size.width/2)-15,
                          child: Text(widget.source, overflow: TextOverflow.ellipsis,)
                      )
                    ],),
                    const SizedBox(height: 6),
                    Container(
                      height: 1,
                      width: (MediaQuery.of(context).size.width/1.5),
                      color: Colors.grey,
                    ),
                  ],),
              ),
            ],),
            const SizedBox(height: 12),
          ],),
      ),
    );
  }
}