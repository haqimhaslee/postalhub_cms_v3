import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:postalhub_admin_cms/pages/check_in_parcel/check_in_parcel.dart';
import 'package:postalhub_admin_cms/pages/check_out_parcel/check_out_parcel.dart';
import 'package:postalhub_admin_cms/pages/home/home.dart';
import 'package:postalhub_admin_cms/pages/out_for_delivery/out_for_delivery.dart';
import 'package:postalhub_admin_cms/pages/parcel_inventory/parcel_inventory.dart';
import 'package:postalhub_admin_cms/pages/profile_settings/profile_settings.dart';
import 'package:postalhub_admin_cms/pages/search_inventory/search_inventory.dart';

class NavigatorServices extends StatefulWidget {
  const NavigatorServices({super.key});
  @override
  State<NavigatorServices> createState() => _NavigatorServicesState();
}

class _NavigatorServicesState extends State<NavigatorServices> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var _selectedIndex = 0;
  final List<Widget> _windgetOption = <Widget>[
    const Home(),
    const ParcelInventory(),
    const SearchInventory(),
    const CheckInParcel(),
    const CheckOutParcel(),
    const OutForDelivery(),
    const MyProfile(),
  ];
  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Row(children: [
            Image.asset(
              'assets/images/postalhub_logo.jpg',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const Text('  Postal Hub CMS'),
          ]),
          leading: width > 680
              ? IconButton(
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  onPressed: null,
                )
              : null,
        ),
        drawer: NavigationDrawer(
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).colorScheme.surface,
          onDestinationSelected: (i) => setState(() => _selectedIndex = i),
          selectedIndex: _selectedIndex,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
              child: Text(
                'Menu',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const NavigationDrawerDestination(
              label: Text("Home"),
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
            ),
            const NavigationDrawerDestination(
              label: Text("Parcel Inventory"),
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2_rounded),
            ),
            const NavigationDrawerDestination(
              label: Text("Search Parcel"),
              icon: Icon(Icons.search_outlined),
              selectedIcon: Icon(Icons.search_rounded),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
              child: Divider(),
            ),
            const NavigationDrawerDestination(
              label: Text("Parcel Key-In"),
              icon: Icon(Icons.barcode_reader),
              selectedIcon: Icon(Icons.barcode_reader),
            ),
            const NavigationDrawerDestination(
              label: Text("Parcel Key-Out"),
              icon: Icon(Icons.barcode_reader),
              selectedIcon: Icon(Icons.barcode_reader),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
              child: Divider(),
            ),
            const NavigationDrawerDestination(
              label: Text("Delivery"),
              icon: Icon(Icons.delivery_dining_outlined),
              selectedIcon: Icon(Icons.delivery_dining),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
              child: Divider(),
            ),
            const NavigationDrawerDestination(
              label: Text("Profile & Setting"),
              icon: Icon(Icons.manage_accounts_outlined),
              selectedIcon: Icon(Icons.manage_accounts_rounded),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
              child: Divider(),
            ),
          ],
        ),
        body: Row(
          mainAxisAlignment:
              width > 680 ? MainAxisAlignment.start : MainAxisAlignment.center,
          children: [
            width > 680
                ? SizedBox(
                    width: 200,
                    child: NavigationDrawer(
                      surfaceTintColor: Theme.of(context).colorScheme.surface,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shadowColor: Theme.of(context).colorScheme.surface,
                      onDestinationSelected: (i) =>
                          setState(() => _selectedIndex = i),
                      selectedIndex: _selectedIndex,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(28, 0, 16, 10),
                          child: Text(
                            ' ',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Home"),
                          icon: Icon(Icons.home_outlined),
                          selectedIcon: Icon(Icons.home_rounded),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Parcel Inventory"),
                          icon: Icon(Icons.inventory_2_outlined),
                          selectedIcon: Icon(Icons.inventory_2_rounded),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Search Parcel"),
                          icon: Icon(Icons.search_outlined),
                          selectedIcon: Icon(Icons.search_rounded),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                          child: Divider(),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Parcel Key-In"),
                          icon: Icon(Icons.barcode_reader),
                          selectedIcon: Icon(Icons.barcode_reader),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Parcel Key-Out"),
                          icon: Icon(Icons.barcode_reader),
                          selectedIcon: Icon(Icons.barcode_reader),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                          child: Divider(),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Delivery"),
                          icon: Icon(Icons.delivery_dining_outlined),
                          selectedIcon: Icon(Icons.delivery_dining),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                          child: Divider(),
                        ),
                        const NavigationDrawerDestination(
                          label: Text("Profile & Setting"),
                          icon: Icon(Icons.manage_accounts_outlined),
                          selectedIcon: Icon(Icons.manage_accounts_rounded),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
                          child: Divider(),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                      border:
                          Border.all(color: const Color.fromARGB(0, 0, 0, 0)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
                  child: SizedBox(
                    height: width > 680 ? height - 100 : height - 20,
                    width: width > 680 ? width - 225 : width - 10,
                    child: PageTransitionSwitcher(
                      transitionBuilder:
                          (child, animation, secondaryAnimation) =>
                              SharedAxisTransition(
                        fillColor: const Color.fromARGB(0, 0, 0, 0),
                        transitionType: SharedAxisTransitionType.vertical,
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        child: child,
                      ),
                      child: _windgetOption.elementAt(_selectedIndex),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
