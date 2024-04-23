import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/widgets/ItemCard.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DashboardController dashboardController = Get.put(DashboardController());
  @override
  void initState() {
    dashboardController.  fetchItems();
    dashboardController.fetchFavoriteItems();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildTypeSelector(),
          Expanded(
            child: buildItemsGridView(),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(Ionicons.cart_outline, size: 30, color: Colors.grey),
        ),
      ],
      leading: const Icon(Icons.search, size: 30, color: Colors.grey),
      title: const SizedBox(
        width: 200,
        child: Column(
          children: [
            Text(
              "Make home ",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGrey,
                fontFamily: "Merriweather",
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "BEAUTIFUL",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "Gelasio",
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget buildTypeSelector() {
    return SizedBox(
      height: 80.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              for (Type type in Type.values)
                buildTypeButton(type),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeButton(Type type) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            dashboardController.choosenType.value = type;
            dashboardController.  fetchItems();
          });
        },
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: ShapeDecoration(
                color: type == dashboardController.choosenType.value
                    ? Colors.black
                    : AppColors.greylight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Center(
                child: Icon(
                  type == Type.Chair
                      ? Icons.chair
                      : type == Type.Table
                      ? Icons.table_bar_outlined
                      : type == Type.Sofa
                      ? Icons.chair_outlined
                      : type == Type.Bed
                      ? Icons.bed_outlined
                      : type == Type.Lamb
                      ? Iconsax.lamp_1_copy
                      : Icons.star,
                  color: type == dashboardController.choosenType.value
                      ? Colors.white
                      : AppColors.darkGrey,
                ),
              ),
            ),
            Text(
              type.toString().split('.').last,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGrey,
                fontFamily: "Merriweather",
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemsGridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: StreamBuilder<List<Item>>(
        stream: dashboardController.filteredItemsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(width:40,height:40,child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Text('No data available.'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ItemCard(cardinfo: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
