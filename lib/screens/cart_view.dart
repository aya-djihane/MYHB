import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/screens/waiting_screen.dart';
import 'package:myhb_app/widgets/cartcard.dart';
import 'package:myhb_app/widgets/custom_button.dart';

class CartScreen extends StatelessWidget {
  final ItemController itemController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: GetBuilder<ItemController>(
        builder: (controller) {
          controller.fetchOrderItems();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 70.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:Obx(() =>  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child:controller.selectedItemscart.isNotEmpty? Column(
                        children: controller.selectedItemscart.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CartCard(cartItem: item),
                          );
                        }).toList(),
                      ):const Center(child: Padding(
                        padding: EdgeInsets.only(top: 200.0),
                        child: Text(" No order Element"),
                      ),),
                    ),)
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 40.0,bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Obx(() => Text(
                  "${itemController.totalorder} DZ",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),)
              ],
            ),
            const SizedBox(height: 16),
            CustomButton(
              width: MediaQuery.of(context).size.width,
              withOpacity: false,
              value: 'Check out',
              color: AppColors.golden,
              onTap: (){itemController.totalorder==0.0?null:Get.bottomSheet(PaymentScreen());},


            ),
          ],
        ),
      ),
    );
  }
}
class PaymentScreen extends StatelessWidget {
  final Function(String cardNumber, String expiryDate, String cvv)? onCreditCardSubmit;

   PaymentScreen({Key? key, this.onCreditCardSubmit}) : super(key: key);
  final ItemController itemController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130.h,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Select Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,color: AppColors.golden,
                ),
              ),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.credit_card),
          //   title: Text('Credit Card'),
          //   onTap: () {
          //     _showCreditCardForm(context);
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.monetization_on,color: AppColors.golden,),
            title: const Text('Cash on Delivery'),
            onTap: () {
              itemController.selectedItemscart.forEach((element) {itemController.addToCheckoutCollection(element );});
              itemController.selectedItemscart.forEach((element) {itemController.deletitem(element.item.id! );});
              Get.to(WaitingScreen());
            },
          ),
          // Add more payment methods here...
        ],
      ),
    );
  }

  void _showCreditCardForm(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: CreditCardForm(
            onSubmit: (cardNumber, expiryDate, cvv) {
              Navigator.pop(context); // Close the bottom sheet
              if (onCreditCardSubmit != null) {
                onCreditCardSubmit!(cardNumber, expiryDate, cvv);
              }
            },
          ),
        );
      },
    );
  }
}

class CreditCardForm extends StatefulWidget {
  final Function(String cardNumber, String expiryDate, String cvv) onSubmit;

  const CreditCardForm({required this.onSubmit});

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  late TextEditingController _cardNumberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
  }
  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Card Number'),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(labelText: 'Expiry Date (MM/YY)'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'CVV'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            final cardNumber = _cardNumberController.text;
            final expiryDate = _expiryDateController.text;
            final cvv = _cvvController.text;
            widget.onSubmit(cardNumber, expiryDate, cvv);
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
