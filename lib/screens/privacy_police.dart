import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String privacyPolicyHTML = '''
      <h1>Privacy Policy</h1>

      <h2>Introduction</h2>
      <p>[Your app name] respects and protects the privacy of its users. This Privacy Policy explains how [your app name] collects, uses, and discloses personal information.</p>

      <h2>Information Collection and Use</h2>
      <ul>
          <li><strong>Personal Information:</strong> [Your app name] may collect personal information from users, such as name, email address, and location. This information is used solely for the purpose of providing and improving the service.</li>
          <li><strong>Usage Data:</strong> [Your app name] may collect non-personal information about how users interact with the app, such as device information, app usage data, and technical information. This information is used to analyze trends, administer the app, track users' movements, and gather demographic information for aggregate use.</li>
      </ul>

      <h2>Security</h2>
      <p> MYHB takes reasonable precautions to protect users' personal information from unauthorized access, use, or disclosure. However, no method of transmission over the internet or electronic storage is 100% secure, and [your app name] cannot guarantee absolute security.</p>

      <h2>Changes to This Privacy Policy</h2>
      <p> MYHB may update this Privacy Policy from time to time. Users will be notified of any changes by posting the new Privacy Policy on this page.</p>

      <hr>

      <h1>Terms of Service</h1>

      <h2>Introduction</h2>
      <p>By accessing or using [your app name], you agree to be bound by these Terms of Service. If you disagree with any part of the terms, then you may not access the app.</p>

      <h2>Use License</h2>
      <ul>
          <li>Permission is granted to download a copy of [your app name] for personal, non-commercial use only.</li>
          <li>This license does not allow you to modify or copy the materials in [your app name].</li>
          <li>You may not use [your app name] for any illegal or unauthorized purpose.</li>
      </ul>

      <h2>Disclaimer</h2>
      <ul>
          <li> MYHB is provided "as is" without any warranties, express or implied.</li>
          <li> MYHB makes no representations or warranties in relation to the accuracy or completeness of the information provided.</li>
      </ul>

      <h2>Limitations</h2>
      <p>In no event shall [your app name] or its suppliers be liable for any damages arising out of the use or inability to use [your app name].</p>

      <h2>Governing Law</h2>
      <p>These Terms of Service shall be governed by and construed in accordance with the laws of [your country], without regard to its conflict of law provisions.</p>
    ''';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy & Terms of Service'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Html(data: privacyPolicyHTML),
        ),
      ),
    );
  }
}
