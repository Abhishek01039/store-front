import 'package:flutter/material.dart';
import 'package:storefront/src/config/color_config.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Logo extends StatelessWidget {
  const Logo({Key? key, this.isProjectNameShown = true}) : super(key: key);

  final bool isProjectNameShown;

  Image _buildLogo({double height = 170}) {
    return Image.asset(
      'assets/logo/local-energy-logy.png',
      height: height,
      width: double.infinity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          if (kIsWeb)
            if (MediaQuery.of(context).size.height < 500)
              _buildLogo(height: MediaQuery.of(context).size.height / 5)
            else
              _buildLogo()
          else
            _buildLogo(),
          if (isProjectNameShown)
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                'Local Energy',
                style: TextStyle(
                  fontSize: 40,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w300,
                  color: Styleguide.colorAccentsOrange_1,
                ),
              ),
            )
        ],
      ),
    );
  }
}
