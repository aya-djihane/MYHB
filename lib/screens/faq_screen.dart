import 'package:flutter/material.dart';
import 'package:myhb_app/appColors.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: faqData.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              title: Text(
                faqData[index]['question']!,
                style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.yellow),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    faqData[index]['answer']!,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final List<Map<String, String>> faqData = [
  {
    'question': 'How do I choose the right furniture for my space?',
    'answer': 'Consider the size of your room, your existing decor style, and the functionality you need. Measure your space and take note of any limitations.'
  },
  {
    'question': 'What materials are used in your furniture?',
    'answer': 'We use a variety of materials including wood, metal, glass, and fabric. Each product listing specifies the materials used.'
  },
  {
    'question': 'How do I assemble my furniture?',
    'answer': 'Most of our furniture comes with assembly instructions included in the package. You can also find assembly guides on our website.'
  },
  {
    'question': 'What is your return policy?',
    'answer': 'We offer a 30-day return policy for unused items in their original packaging. Please refer to our return policy page for more details.'
  },
  {
    'question': 'How do I care for my furniture?',
    'answer': 'Regular dusting and cleaning with a mild cleaner are usually sufficient for maintenance. Specific care instructions are provided with each product.'
  },
  {
    'question': 'Do you offer customization options?',
    'answer': 'Some of our furniture items can be customized. Please contact our customer support team for more information.'
  },
  {
    'question': 'How can I track my order?',
    'answer': 'Once your order is shipped, you will receive a tracking number via email. You can use this tracking number to monitor the delivery status.'
  },
  {
    'question': 'What payment methods do you accept?',
    'answer': 'We accept major credit cards, PayPal, and some other electronic payment methods. You can see all available payment options during checkout.'
  },
  {
    'question': 'Do you offer assembly services?',
    'answer': 'We currently do not offer assembly services, but many of our products are designed for easy self-assembly. Assembly instructions are included.'
  },
  {
    'question': 'Can I cancel or modify my order?',
    'answer': 'You can cancel or modify your order within 24 hours of placing it. After that, it may not be possible due to processing and shipping.'
  },
  {
    'question': 'Do you offer warranty on your products?',
    'answer': 'Yes, we offer a warranty on our furniture products against manufacturing defects. Please refer to the warranty terms for each product.'
  },
  {
  'question': 'How do I contact customer support?',
  'answer': 'You can reach our customer support team via email at support@example.com or by phone at +123456789. We\'re available to assist you during business hours.'
  },

];
