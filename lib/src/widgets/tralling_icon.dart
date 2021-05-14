import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrallingIcon extends StatelessWidget {
  const TrallingIcon({Key? key, this.width = 50}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width == 50 ? 4.0 : 0.0),
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.0),
          child: FadeInImage(
            placeholder: const AssetImage(
              'assets/picture/jane-jones-circle-cropped.png',
            ),
            image: NetworkImage(
              FirebaseAuth.instance.currentUser?.photoURL ?? '',
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
