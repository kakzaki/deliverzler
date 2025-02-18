import 'package:deliverzler/core/presentation/widgets/empty_appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:deliverzler/core/presentation/widgets/platform_widgets/platform_base_widget.dart';

class PlatformScaffold extends PlatformBaseWidget<Scaffold, Widget> {
  const PlatformScaffold({
    super.key,
    this.widgetKey,
    this.platformAppBar,
    this.hasEmptyAppbar = true,
    required this.body,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.materialData,
  });

  final Key? widgetKey;
  final dynamic platformAppBar;
  final bool hasEmptyAppbar;
  final Widget body;
  final Color? backgroundColor;
  final bool resizeToAvoidBottomInset;
  final MaterialScaffoldData? materialData;

  @override
  Scaffold createMaterialWidget(BuildContext context) {
    return Scaffold(
      key: widgetKey,
      appBar: platformAppBar ?? hasEmptyAppbar
          ? EmptyAppBar(
              statusBarColor: materialData?.statusBarColor,
            )
          : null,
      body: body,
      floatingActionButton: materialData?.floatingActionButton,
      drawer: materialData?.drawer,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: materialData?.extendBodyBehindAppBar ?? false,
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    return CupertinoPageScaffold(
      key: widgetKey,
      navigationBar: platformAppBar ?? hasEmptyAppbar
          ? const EmptyAppBar(
              //It's not allowed to set statusBarColor for iOS without an appbar.
              statusBarColor: Colors.transparent,
            )
          : null,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      child: body,
    );
  }
}

class MaterialScaffoldData {
  const MaterialScaffoldData({
    this.floatingActionButton,
    this.drawer,
    this.extendBodyBehindAppBar,
    this.statusBarColor,
  });

  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool? extendBodyBehindAppBar;
  final Color? statusBarColor;
}
