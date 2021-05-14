import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// A no-frills scaffold.
class BasicScaffold extends StatelessWidget {
  const BasicScaffold({
    required this.child,
    this.drawer,
    this.backgroundColor,
    this.allowBackNavigation = true,
    this.scaffoldKey,
  });

  final Widget child;
  final Widget? drawer;
  final Color? backgroundColor;
  final bool allowBackNavigation;
  final Key? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? Theme.of(context).backgroundColor,
      body: child,
      drawer: drawer,
    );
  }
}

/// A scaffold with an app bar.
class BasicScaffoldWithAppBar extends StatelessWidget {
  const BasicScaffoldWithAppBar({
    required this.child,
    this.bottom,
    this.drawer,
    this.leading,
    this.titleString,
    this.titleLeadingPadding = 0.0,
    this.trailing,
    this.backgroundColor,
    this.appBarBackgroundColor,
    this.appBarForegroundColor,
    this.appBarBrightness,
    this.appBarElevation = 4.0,
    this.scaffoldKey,
  });

  final Widget child;
  final Widget? bottom;
  final Widget? drawer;
  final Widget? leading;
  final Widget? titleString;
  final double? titleLeadingPadding;
  final Widget? trailing;
  final Color? backgroundColor;
  final Color? appBarBackgroundColor;
  final Color? appBarForegroundColor;
  final double? appBarElevation;
  final Brightness? appBarBrightness;
  final Key? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light,
    );
    final ThemeData theme = Theme.of(context);
    return buildScaffold(theme, context);
  }

  SafeArea buildScaffold(ThemeData theme, BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: backgroundColor ?? theme.backgroundColor,
        key: scaffoldKey,
        appBar: AppBar(
          backwardsCompatibility: false,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.orange),
          brightness: appBarBrightness ?? theme.appBarTheme.brightness,
          backgroundColor: appBarBackgroundColor ?? theme.appBarTheme.color,
          elevation: appBarElevation,
          title: (titleString == null) ? const SizedBox() : titleString,
          titleSpacing: -8.0,
          centerTitle: true,
          // leading: BackButton(
          //   key: const Key('back_button'),
          //   color: appBarForegroundColor ?? theme.colorScheme.onBackground,
          //   onPressed: () => Navigator.pop(context),
          // ),
          actions: [trailing!],
        ),
        body: child,
        drawer: drawer,
        bottomNavigationBar: bottom,
      ),
    );
  }
}
