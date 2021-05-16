import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/bloc/login/login_bloc.dart';
import 'package:storefront/src/web/widgets/tralling_icon_web.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';
import 'package:storefront/src/widgets/snackbar_widget.dart';

import '../auth_screen_web.dart';

class StoreScreenWeb extends StatelessWidget {
  Column _content(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 50,
            ),
            _buildTrallingIcon(),
          ],
        ),
        const Text('storefront'),
        Expanded(
          child: _storesStream(),
        ),
      ],
    );
  }

  Widget _buildTrallingIcon() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            // navigate to root page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => AuthScreenWeb(),
              ),
              ModalRoute.withName('/'),
            );
            showSnackbar(
              context: context,
              text: 'Logout successful!',
            );
          } else if (state is LogoutError) {
            showSnackbar(
              context: context,
              text: state.errorMessage.contains(':')
                  ? (state.errorMessage.split(':')[1]).toString().trim()
                  : state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              context.read<LoginBloc>().add(LogoutRequested());
            },
            child: TrallingIconWeb(),
          );
        },
      ),
    );
  }

  // Stream builder for store
  StreamBuilder _storesStream() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('stores')
          .where('customerId',
              isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic>? title =
                snapshot.data?.docs[index].data() as Map<String, dynamic>?;
            return ListTile(
              title: Text(title!['storeTitle'] as String? ?? ''),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      child: _content(context),
    );
  }
}
