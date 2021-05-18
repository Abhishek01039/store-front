import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:storefront/src/extension/replace_underscore_with_space_extension.dart';
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

  Expanded _buildStoreDetail(TextTheme _textTheme) {
    return Expanded(
      child: Container(
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
                  Text(widget.store.ourStory ?? ''),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
                  height: 50,
                  width: 65,
                  fit: BoxFit.fill,
                ),
                _buildWidthBox(width: 16),
                Text(
                  ReplaceUnderscoreWithSpace(widget.storeName ?? '').text,
                  style: _textTheme.headline3,
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
      backgroundColor: Colors.transparent,
      child: Column(
        children: [
          SizedBox(
            height: 250,
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
        ],
      ),
    );
  }
}
