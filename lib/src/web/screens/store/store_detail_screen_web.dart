import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/extension/replace_underscore_with_space_extension.dart';
import 'package:storefront/src/models/product.dart';
import 'package:storefront/src/models/store.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';

class StoreDetailScreenWeb extends StatefulWidget {
  const StoreDetailScreenWeb(
      {@PathParam('storeName') this.storeName, required this.store});

  final String? storeName;
  final Store store;

  @override
  _StoreDetailScreenWebState createState() => _StoreDetailScreenWebState();
}

class _StoreDetailScreenWebState extends State<StoreDetailScreenWeb> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  @override
  void initState() {
    super.initState();
    snapshot = FirebaseFirestore.instance
        .collection('products')
        .where('customerId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .asBroadcastStream();
  }

  SizedBox _buildSizedBox({double height = 20}) {
    return SizedBox(
      height: height,
    );
  }

  SizedBox _buildWidthBox({double width = 20}) {
    return SizedBox(
      width: width,
    );
  }

  Container _buildStoreDetail(TextTheme _textTheme) {
    return Container(
      color: Styleguide.pageColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 120, right: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSizedBox(),
            Text(
              'Our Story',
              style: _textTheme.headline2?.copyWith(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildSizedBox(height: 8),
            Wrap(
              children: [
                Text(
                  widget.store.ourStory ?? '',
                  style: _textTheme.headline3?.copyWith(
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ],
            ),
            _buildSizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  StreamBuilder _buildProductDetail(TextTheme _textTheme) {
    const double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 4;

    return StreamBuilder<QuerySnapshot>(
        stream: snapshot,
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading'));
          }

          final List<Product>? product = snapshot.data?.docs
              .map<Product>(
                  (e) => Product.fromJson(e.data()! as Map<String, dynamic>))
              .toList();

          // Sort the product list depends on product title
          product?.sort((Product a, Product b) => a.title.compareTo(b.title));
          return Container(
            color: Styleguide.pageColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Our Products',
                    style: _textTheme.headline2?.copyWith(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  _buildSizedBox(height: 36),
                  GridView.builder(
                      // padding: const EdgeInsets.only(bottom: 12),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: product?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: _crossAxisSpacing,
                        mainAxisSpacing: _mainAxisSpacing,
                        childAspectRatio: _aspectRatio,
                      ),
                      itemBuilder: (context, index) {
                        final TextTheme _textTheme =
                            Theme.of(context).textTheme;
                        return Card(
                          color: Styleguide.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 4,
                              top: 4,
                              bottom: 4,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        product![index].title,
                                        style: _textTheme.headline4?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          product[index].desc ?? '',
                                          style: _textTheme.bodyText1!.copyWith(
                                            fontWeight: FontWeight.w300,
                                          ),
                                          maxLines: 3,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Styleguide
                                                          .pageColor!),
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.remove,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Styleguide
                                                          .pageColor!),
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: const Center(
                                                  child: Text('1'),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Styleguide
                                                          .pageColor!),
                                                ),
                                                height: 30,
                                                width: 30,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 16,
                                                  ),
                                                ),
                                              ),
                                              _buildWidthBox(width: 4),
                                              Text(
                                                '\$${product[index].price}',
                                                style: _textTheme.headline5,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/icons/local.png',
                                                height: 40,
                                                width: 40,
                                              ),
                                              Image.asset(
                                                'assets/icons/usda-organic.jpg',
                                                height: 40,
                                                width: 40,
                                              ),
                                              _buildWidthBox(width: 4),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/logo/local-energy-logy.png'),
                                    image: NetworkImage(
                                      product[index].image![0] as String,
                                    ),
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        });
  }

  Container _buildStoreTitleAndLogo(TextTheme _textTheme) {
    return Container(
      color: Styleguide.white,
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(left: 120, right: 120),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Store LOGO
                FadeInImage(
                  placeholder:
                      const AssetImage('assets/logo/local-energy-logy.png'),
                  image: NetworkImage(
                    widget.store.logo as String,
                  ),
                  height: 40,
                  width: 65,
                  fit: BoxFit.fill,
                ),
                _buildWidthBox(width: 16),
                Text(
                  ReplaceUnderscoreWithSpace(widget.storeName ?? '').text,
                  style: _textTheme.headline2,
                ),
              ],
            ),
            Row(
              children: [
                const Text('Join Mailing List'),
                _buildWidthBox(),
                const Icon(Icons.shopping_cart),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme _textTheme = Theme.of(context).textTheme;
    return BasicScaffold(
      backgroundColor: Styleguide.pageColor,
      child: ListView(
        children: [
          SizedBox(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: FadeInImage(
              placeholder:
                  const AssetImage('assets/logo/local-energy-logy.png'),
              image: NetworkImage(
                widget.store.headerImage as String,
              ),
              fit: BoxFit.fill,
            ),
          ),
          _buildStoreTitleAndLogo(_textTheme),
          _buildStoreDetail(_textTheme),
          _buildProductDetail(_textTheme),
        ],
      ),
    );
  }
}
