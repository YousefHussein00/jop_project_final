import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jop_project/constants.dart';
import 'package:jop_project/size_config.dart';
import 'package:jop_project/components/custom_drawer.dart';

class Background extends StatefulWidget {
  final Widget child;
  final String title;
  final String? supTitle;
  final bool? showListNotiv;
  final bool? isCompany; // تغيير حسب نوع المستخدم الحالي
  final String? userName;
  final String? userImage;
  final int? availableJobs;
  // double? height;
  final double height;
  // = SizeConfig.screenH! / 4.5;
  const Background({
    super.key,
    required this.child,
    required this.title,
    required this.height,
    this.supTitle,
    this.showListNotiv = false,
    this.isCompany,
    this.userName,
    this.userImage,
    this.availableJobs = 152,
  });

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  void didUpdateWidget(covariant Background oldWidget) {
    // widget.height = SizeConfig.screenH! / 4.5;
    super.didUpdateWidget(oldWidget);
    Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (mounted) setState(() {});
        timer.cancel();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                width: SizeConfig.screenW,
                height: widget.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (widget.supTitle != null)
                        Text(
                          widget.supTitle!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (Navigator.canPop(context))
                Positioned(
                  top: 70,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ),
              if (widget.showListNotiv!)
                Positioned(
                  top: 30,
                  right: 0,
                  left: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (Navigator.canPop(context))
                        IconButton(
                          tooltip: 'رجوع الى الخلف',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      if (!Navigator.canPop(context))
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                      Builder(
                        builder: (context) => IconButton(
                          onPressed: () {
                            // عرض الـ Drawer باستخدام Overlay
                            _showDrawer(
                              context,
                              isCompany: widget.isCompany!,
                              userName: widget.userName ?? 'لا يوحد',
                              userImage: widget.userImage ?? '',
                              availableJobs: widget.availableJobs!,
                            );
                          },
                          icon: const Icon(
                            Icons.list,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 252, 252, 252),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SafeArea(child: widget.child),
            ),
          ),
        ],
      ),
    );
  }

  void _showDrawer(
    BuildContext context, {
    required bool isCompany, // تغيير حسب نوع المستخدم الحالي
    required String userName,
    String? userImage,
    required int availableJobs,
  }) {
    // يجب أن تحصل على هذه المعلومات من مكان مركزي مثل Provider أو GetX

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: IntrinsicWidth(
            child: CustomDrawer(
              isCompany: isCompany,
              name: userName,
              imagePath: userImage ?? '',
              availableJobs: availableJobs,
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
