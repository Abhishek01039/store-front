import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';

class StoreDetailScreenWeb extends StatefulWidget {
  const StoreDetailScreenWeb({@PathParam('storeName') this.storeName});

  final String? storeName;

  @override
  _StoreDetailScreenWebState createState() => _StoreDetailScreenWebState();
}

class _StoreDetailScreenWebState extends State<StoreDetailScreenWeb> {
  final Image theImage = Image.network(
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
    height: 50,
    width: 65,
    fit: BoxFit.fill,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (mounted) {
      precacheImage(theImage.image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      child: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            Container(
              color: Styleguide.white,
              height: 50,
              child: Row(
                children: [
                  // Store LOGO
                  theImage,
                  const Text('Boulder Bakers'),
                  const Spacer(),
                  const Text('Join Mailing List'),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(Icons.shopping_cart),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
