import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_shadow/flutter_inset_shadow.dart';
import 'package:jop_project/constants.dart';
import 'package:popup_menu/popup_menu.dart';

class CustomPopupMenu extends StatefulWidget {
  final List<String> menuItems;
  final void Function(MenuItemProvider) onClickMenu;

  const CustomPopupMenu(
      {super.key, required this.menuItems, required this.onClickMenu});

  @override
  State<CustomPopupMenu> createState() => _CustomPopupMenuState();
}

class _CustomPopupMenuState extends State<CustomPopupMenu> {
  late PopupMenu menu;
  String? selectedMenu;
  GlobalKey btnKey2 = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  // void onClickMenu(MenuItemProvider item) {
  //   setState(() {
  //     selectedMenu = item.menuTitle;
  //   });
  // }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void onShow() {
    print('Menu is show');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: btnKey2,
      onTap: listMenu,
      child: const PrimaryContainer(
        radius: 10,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Icon(
            Icons.list,
            color: Colors.white,
            size: defaultPadding * 2,
          ),
        ),
      ),
    );
  }

  void listMenu() {
    List<MenuItem> menuItems = widget.menuItems.map((item) {
      return MenuItem.forList(
          title: item,
          textStyle: const TextStyle(color: Colors.white, fontSize: 16));
    }).toList();

    PopupMenu menu = PopupMenu(
      context: context,
      config: const MenuConfig(
        type: MenuType.list,
        itemWidth: 330,
        itemHeight: 45,
        maxColumn: 1,
        backgroundColor: Color.fromARGB(255, 0, 72, 131),
      ),
      items: menuItems,
      onClickMenu: widget.onClickMenu,
      onShow: onShow,
      onDismiss: onDismiss,
    );

    menu.show(widgetKey: btnKey2);
  }
}

class PrimaryContainer extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const PrimaryContainer({
    super.key,
    this.radius,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 72, 131),
        borderRadius: BorderRadius.circular(radius ?? 30),
        boxShadow: [
          BoxShadow(
            color: color ?? const Color(0XFF1E1E1E),
          ),
          const BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 4,
            spreadRadius: 0,
            color: Colors.black,
            inset: true,
          ),
        ],
      ),
      child: child,
    );
  }
}
