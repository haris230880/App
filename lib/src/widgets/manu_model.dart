import 'package:mini/src/configs/app_route.dart';
import 'package:flutter/material.dart';
import 'package:mini/src/configs/app_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) onTap;

  const Menu({
    this.title,
    this.icon,
    this.iconColor = Colors.grey,
    this.onTap,
  });
}

class MenuViewModel {
  MenuViewModel();

  List<Menu> get items => <Menu>[
        Menu(
          iconColor: Colors.blue,
          title: 'Profile',
          icon: Icons.person,
          onTap: (
            context,
          ) {
            Navigator.pushNamed(context, AppRoute.infoRoute);
            //todo
          },
        ),
        Menu(
          iconColor: Colors.blue,
          title: 'ประเภทห้องเช่า',
          icon: Icons.merge_type_rounded,
          onTap: (
            context,
          ) {
            Navigator.pushNamed(context, AppRoute.roomtypeRoute);
            //todo
          },
        ),
        Menu(
          iconColor: Colors.blue,
          title: 'เปรียบเทียบราคาห้องเช่า',
          icon: Icons.account_tree_rounded,
          onTap: (
            context,
          ) {
            Navigator.pushNamed(context, AppRoute.roomSearchRoute);
            //todo
          },
        ),
        Menu(
          iconColor: Colors.blue,
          title: 'เพิ่มห้องเช่า',
          icon: Icons.add,
          onTap: (
            context,
          ) {
            Navigator.pushNamed(context, AppRoute.roomRoute);
            //todo
          },
        ),
        Menu(
          iconColor: Colors.blue,
          title: 'ออกจากระบบ',
          icon: Icons.login_outlined,
          onTap: (
            context,
          ) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove(AppSetting.userNameSetting);
            prefs.remove(AppSetting.passwordSetting);
            Navigator.pushNamed(context, AppRoute.loginRoute);
            //todo
          },
        ),


      ];

}
