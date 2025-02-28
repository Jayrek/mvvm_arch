import 'package:flutter/material.dart';

import 'drawer_item_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.deepOrange),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        'JD',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  fontSize: 50,
                                  color: Colors.deepOrange,
                                ),
                      )),
                  const SizedBox(height: 20),
                  Text(
                    'John Doe',
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Column(
              children: [
                DrawerItemWidget(
                  iconData: Icons.inventory_sharp,
                  label: 'Products',
                  onTap: () {},
                ),
                const Divider(
                  color: Colors.black87,
                  thickness: 0.2,
                ),
                DrawerItemWidget(
                  iconData: Icons.shopping_cart,
                  label: 'Cart',
                  onTap: () {},
                ),
                const Divider(
                  color: Colors.black87,
                  thickness: 0.2,
                ),
                DrawerItemWidget(
                  label: 'About',
                  iconData: null,
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDrawerItemWidget({
    required IconData iconData,
    required String label,
    required Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(label),
      onTap: onTap,
    );
  }
}
