import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storefront/src/bloc/login/login_bloc.dart';
import 'package:storefront/src/extension/replace_space_with_underscore_extension.dart';
import 'package:storefront/src/models/store.dart';
import 'package:storefront/src/web/router/web_router.gr.dart';
import 'package:storefront/src/web/widgets/tralling_icon_web.dart';
import 'package:storefront/src/widgets/scaffold_widgets.dart';
import 'package:storefront/src/widgets/snackbar_widget.dart';

class StoreScreenWeb extends StatefulWidget {
  @override
  _StoreScreenWebState createState() => _StoreScreenWebState();
}

class _StoreScreenWebState extends State<StoreScreenWeb> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> snapshot;

  @override
  void initState() {
    super.initState();
    snapshot = FirebaseFirestore.instance
        .collection('stores')
        .where('customerId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .asBroadcastStream();
  }

  Column _content(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 50,
            ),
            _buildTrallingIcon(context),
          ],
        ),
        Text('storefront', style: Theme.of(context).textTheme.headline1),
        Expanded(
          child: _storesStream(context),
        ),
      ],
    );
  }

  Widget _buildTrallingIcon(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            // navigate to root page
            context.router.pushAndPopUntil(
              const AuthRouteWeb(),
              predicate: ModalRoute.withName('/'),
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

  StreamBuilder _storesStream(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: snapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot?> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        final List<Store>? store = snapshot.data?.docs
            .map<Store>(
                (e) => Store.fromJson(e.data()! as Map<String, dynamic>))
            .toList();
        return ListView.builder(
          itemCount: store?.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                context.pushRoute(
                  StoreDetailScreenWeb(
                    storeName:
                        ReplaceSpaceWithUnderscore(store![index].storeTitle)
                            .text,
                    store: store[index],
                  ),
                );
              },
              title: Text(store![index].storeTitle),
              subtitle: Text(
                store[index].ourStory ?? '',
                overflow: TextOverflow.ellipsis,
              ),
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
