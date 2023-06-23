import 'package:e_shop_app/Widgets/widgetsExports.dart';
import 'package:e_shop_app/Models/modelsExports.dart';
import 'package:flutter/material.dart';
import 'package:e_shop_app/Store/storeExports.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;
  const ProductPage({super.key, required this.itemModel});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 1;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(),
      drawer: const MyDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Image.network(widget.itemModel.thumbnailUrl!),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: const SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.itemModel.title!,
                            style: boldTextStyle,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            widget.itemModel.longDescription!,
                            style: boldTextStyle,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            '£ ${widget.itemModel.price!}',
                            style: boldTextStyle,
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: InkWell(
                        onTap: () => print('Clicked'),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pink, Colors.lightGreenAccent],
                              begin: FractionalOffset(0.0, 0.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width - 40.0,
                          height: 50.0,
                          child: const Center(
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
