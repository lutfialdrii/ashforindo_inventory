import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/app_color.dart';
import '../../config/session.dart';
import '../controller/c_dashboard.dart';
import 'employee/employee_page.dart';
import 'login_page.dart';
import 'product/product_page.dart';

import '../controller/c_user.dart';
import 'history/history_page.dart';
import 'inout/inout_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final cUser = Get.put(CUser());
  final cDashboard = Get.put(CDashboard());

  logout() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Logout',
      'You sure to logout?',
    );
    if (yes!) {
      Session.clearUser();
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      endDrawer: DrawerApp(),
      // appBar: AppBar(
      //   title: const Text('Dashboard'),
      //   actions: [
      //     IconButton(
      //       onPressed: () => logout(),
      //       icon: const Icon(Icons.logout),
      //     ),
      //   ],
      // ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Image.asset(
                //   'asset/profile.png',
                //   width: 100,
                //   height: 100,
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi,',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          cUser.data.name ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Builder(builder: (ctx) {
                  return Material(
                    borderRadius: BorderRadius.circular(4),
                    elevation: 2,
                    color: AppColor.primary,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.menu,
                          color: AppColor.text,
                        ),
                      ),
                      onTap: () {
                        Scaffold.of(ctx).openEndDrawer();
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          profileCard(textTheme),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DView.textTitle('Menu'),
          ),
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 110,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            children: [
              menuProduct(textTheme),
              menuHistory(textTheme),
              menuIn(textTheme),
              menuOut(textTheme),
              Obx(() {
                if (cUser.data.level == 'Supervisor') {
                  return menuEmployee(textTheme);
                } else {
                  return const SizedBox();
                }
              }),
            ],
          )
        ],
      ),
    );
  }

  Drawer DrawerApp() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            margin: const EdgeInsets.only(bottom: 0),
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Image.asset(
                    //   'asset/profile.png',
                    //   width: 100,
                    //   height: 100,
                    // ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            return Text(
                              cUser.data.name.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            );
                          }),
                          Obx(() {
                            return Text(
                              cUser.data.level.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
                DView.spaceHeight(8),
                Material(
                  color: AppColor.primary,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () => logout(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => const ProductPage())
                  ?.then((value) => cDashboard.setProduct());
            },
            leading: const Icon(
              Icons.construction,
              color: AppColor.primary,
            ),
            horizontalTitleGap: 0,
            title: const Text('Product'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => HistoryPage());
            },
            leading: const Icon(
              Icons.history,
              color: AppColor.primary,
            ),
            horizontalTitleGap: 0,
            title: const Text('History'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => InOutPage(type: 'IN'));
            },
            leading: const Icon(
              Icons.south_west,
              color: AppColor.primary,
            ),
            horizontalTitleGap: 0,
            title: const Text('IN'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              Get.to(() => InOutPage(type: 'OUT'));
            },
            leading: const Icon(
              Icons.north_east,
              color: AppColor.primary,
            ),
            horizontalTitleGap: 0,
            title: const Text('OUT'),
            trailing: const Icon(Icons.navigate_next),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Obx(() {
            if (cUser.data.level == 'Supervisor') {
              return ListTile(
                onTap: () {
                  Get.to(() => EmployeePage());
                },
                leading: const Icon(
                  Icons.person_add,
                  color: AppColor.primary,
                ),
                horizontalTitleGap: 0,
                title: const Text('Employee'),
                trailing: const Icon(Icons.navigate_next),
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget menuProduct(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductPage())
            ?.then((value) => cDashboard.setProduct());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.product.toString(),
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuHistory(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HistoryPage())
            ?.then((value) => cDashboard.setHistory());
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.history.toString(),
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Act',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuIn(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const InOutPage(type: 'IN'))?.then((value) {
          cDashboard.setIn();
          cDashboard.setHistory();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'IN',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.ins.toString(),
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuOut(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const InOutPage(type: 'OUT'))?.then((value) {
          cDashboard.setOut();
          cDashboard.setHistory();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OUT',
              style: textTheme.titleLarge,
            ),
            Row(
              children: [
                Obx(() {
                  return Text(
                    cDashboard.outs.toString(),
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                    ),
                  );
                }),
                DView.spaceWidth(8),
                const Text(
                  'Item',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget menuEmployee(TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const EmployeePage())?.then((value) {
          cDashboard.setEmployee();
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.input,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Employee',
              style: textTheme.titleLarge,
            ),
            Obx(() {
              return Text(
                cDashboard.employee.toString(),
                style: textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Container profileCard(TextTheme textTheme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Text(
              cUser.data.name ?? '',
              style: textTheme.titleMedium,
            );
          }),
          DView.spaceHeight(4),
          Obx(() {
            return Text(
              cUser.data.email ?? '',
              style: textTheme.bodyMedium,
            );
          }),
          DView.spaceHeight(8),
          Obx(() {
            return Text(
              '(${cUser.data.level})',
              style: textTheme.caption,
            );
          }),
        ],
      ),
    );
  }
}
