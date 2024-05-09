import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myhb_app/appColors.dart';
import 'package:myhb_app/controller/checkoutcontroller.dart';
import 'package:myhb_app/controller/dashboard_controller.dart';
import 'package:myhb_app/controller/item_controller.dart';
import 'package:myhb_app/screens/waiting_screen.dart';
import 'package:myhb_app/widgets/cartcard.dart';
import 'package:myhb_app/widgets/checkoutCard.dart';
import 'package:myhb_app/widgets/custom_button.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutController checkoutController=Get.put(CheckoutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My checkout Items",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: GetBuilder<CheckoutController>(
        builder: (controller) {
          controller.fetchCheckoutList();
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: controller.checkoutList.map((item) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: checkoutCard(cartItem: item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
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
      color: Colors.white,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Credit Card'),
            onTap: () {
              _showCreditCardForm(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
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
