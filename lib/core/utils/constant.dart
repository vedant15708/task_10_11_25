import 'package:flutter/material.dart';

class AppConstants {
  static const String logo = 'assets/images/logo.jpg';
  static const String appName = 'Huge Basket';

  static const String walmart = 'assets/images/walmart.png';
  static const String stopShop = 'assets/images/stopshop.png';
  static const String safeway = 'assets/images/safeway.png';
  static const String giantFood = 'assets/images/giantfood.png';
  static const String meijer = 'assets/images/meijer.png';


  static const String nextDeliveryText = 'Next delivery on Wed, 14 Nov 2020';
}


final List<Map<String, dynamic>> profileGridItems = [
  {'icon': Icons.location_on_outlined, 'label': 'Manage Address'},
  {'icon': Icons.chat_bubble_outline, 'label': 'Recent Chat'},
  {'icon': Icons.notifications_none_outlined, 'label': 'Notification'},
  {'icon': Icons.star_border_outlined, 'label': 'Rate the App'},
  {'icon': Icons.share_outlined, 'label': 'Share App'},
  {'icon': Icons.help_outline, 'label': 'Help & FAQ'},
  {'icon': Icons.info_outline, 'label': 'About Us'},
  {'icon': Icons.description_outlined, 'label': 'Terms and conditions'},
  {'icon': Icons.privacy_tip_outlined, 'label': 'Privacy Policy'},
  {'icon': Icons.perm_contact_calendar, 'label': 'Contact Us'},
  {'icon': Icons.logout_outlined, 'label': 'Logout'},
];