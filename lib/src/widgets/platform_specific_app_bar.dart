import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'footer.dart';

class PlatformSpecificAppBar extends StatelessWidget {
  const PlatformSpecificAppBar({Key? key}) : super(key: key);
  Column _buildFooterWithColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Footer(
          color: Colors.black,
        ),
      ],
    );
  }

  Widget? _platformSpecificBottomAppBar() {
    try {
      if (kIsWeb) {
        return _buildFooterWithColumn();
      } else {
        // throw an Exception when platform is not web
        throw Exception('This is not web');
      }
    } catch (e) {
      if (Platform.isIOS) {
        return _buildFooterWithColumn();
      } else {
        return SizedBox(
          height: 60,
          child: _buildFooterWithColumn(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _platformSpecificBottomAppBar() ?? const SizedBox();
  }
}
