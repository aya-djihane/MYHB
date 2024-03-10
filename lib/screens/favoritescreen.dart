import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myhb_app/models/item.dart';
import 'package:myhb_app/widgets/favoritecard.dart';
import '../appColors.dart';
import '../widgets/custom_button.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return  Column(
      children: [
        AppBar(
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
            child: Text(
              "Favorites ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontFamily: "Merriweather",
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                              children: [
                                FavoriteCard(cardinfo: Item(image:"https://images.unsplash.com/photo-1581428982868-e410dd047a90?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",price: "3000",name: "first table" ),),
                                FavoriteCard(cardinfo: Item(image:"https://static8.depositphotos.com/1022715/834/i/450/depositphotos_8346493-stock-photo-wooden-chair-over-white-with.jpg",price: "5000",name: "chair" ),),
                                FavoriteCard(cardinfo: Item(image:"https://cdn.britannica.com/88/212888-050-6795342C/study-lamp-electrical-cord.jpg",price: "12000",name: "lamp" ),),
                                FavoriteCard(cardinfo: Item(image:"https://www.shutterstock.com/image-photo/sofa-260nw-277827251.jpg",price: "6000",name: "sofa" ),),
                                FavoriteCard(cardinfo: Item(image:"https://t4.ftcdn.net/jpg/04/97/02/61/360_F_497026116_0faq77nXSZMr0QdYTCv55y5EqgT9vRMT.jpg",price: "15000",name: "Bed" ),),
                                FavoriteCard(cardinfo: Item(image:"https://t4.ftcdn.net/jpg/04/97/02/61/360_F_497026116_0faq77nXSZMr0QdYTCv55y5EqgT9vRMT.jpg",price: "15000",name: "Bed" ),),
                                FavoriteCard(cardinfo: Item(image:"https://t4.ftcdn.net/jpg/04/97/02/61/360_F_497026116_0faq77nXSZMr0QdYTCv55y5EqgT9vRMT.jpg",price: "15000",name: "Bed" ),),

                              ]
                          ),
                        )
                    )
                ),
                Positioned(bottom:20,child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal: 40.w),
                  child: Center(child: CustomButton(width: media.width.w/1.45, color:Colors.black,value: 'Add to my cart',)),
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
