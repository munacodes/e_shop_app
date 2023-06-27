import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop_app/Admin/adminExports.dart';
import 'package:e_shop_app/Store/storeExports.dart';
import 'package:e_shop_app/Counters/countersExports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop_app/Config/config.dart';
import '../Widgets/widgetsExports.dart';
import '../Models/modelsExports.dart';

double? width;

class StoreHome extends StatefulWidget {
  const StoreHome({Key? key}) : super(key: key);

  @override
  State<StoreHome> createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink, Colors.lightGreenAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          'e-Shop',
          style: TextStyle(
            fontSize: 55.0,
            color: Colors.white,
            fontFamily: 'Signatra',
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Route route = MaterialPageRoute(
                    builder: (context) => CartPage(),
                  );
                  Navigator.pushReplacement(context, route);
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.pink,
                ),
              ),
              Positioned(
                child: Stack(
                  children: [
                    const Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                      top: 4.0,
                      bottom: 5.0,
                      right: 7.0,
                      left: 7.0,
                      child: Consumer<CartItemCounter>(
                        builder: (BuildContext context, counter, _) {
                          return Text(
                            counter.count.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const MyDrawer(),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverToBoxAdapter(
      //       child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      //         stream: FirebaseFirestore.instance
      //             .collection('posts')
      //             .orderBy("id", descending: true)
      //             .snapshots(),
      //         builder: (BuildContext context, dataSnapshot) {
      //           return !dataSnapshot.hasData
      //               ? const Center(
      //                   child: CircularProgressIndicator(),
      //                 )
      //               : ListView.builder(
      //                   itemCount: dataSnapshot.data!.docs.length,
      //                   itemBuilder: (context, index) {
      //                     ItemModel model = ItemModel.fromJson(
      //                         dataSnapshot.data!.docs[index].data());
      //                     return sourceInfo(model, context);
      //                   },
      //                 );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            SliverToBoxAdapter(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('items')
                    .limit(15)
                    .orderBy('publishedDate', descending: true)
                    .snapshots(),
                builder: (context, dataSnapshot) {
                  return !dataSnapshot.hasData
                      ? const SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                          itemCount: dataSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ItemModel model = ItemModel.fromJson(
                                dataSnapshot.data!.docs[index].data());
                            return sourceInfo(model, context);
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color? background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route =
          MaterialPageRoute(builder: (c) => ProductPage(itemModel: model));
      Navigator.pushReplacement(context, route);
    },
    splashColor: Colors.pink,
    child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [
            Image.network(
              model.thumbnailUrl!,
              width: 140.0,
              height: 140.0,
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(model.title!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14.0)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(model.shortInfo!,
                              style: const TextStyle(
                                  color: Colors.black54, fontSize: 12.0)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.pink,
                        ),
                        alignment: Alignment.topLeft,
                        width: 43.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '50%',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                'OFF',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  'Original Price: £ ',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                Text(
                                  (model.price! + model.price!).toString(),
                                  style: const TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: [
                                const Text(
                                  'New Price: ',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                const Text(
                                  '£ ',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 16.0),
                                ),
                                Text(
                                  (model.price!).toString(),
                                  style: const TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Flexible(
                    child: Container(),
                  ),

                  // TODO: Implement the cart item remove features
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String? imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
