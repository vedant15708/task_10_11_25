import 'package:flutter/material.dart';
import '../../feature/address/screen/addnewaddress.dart';
import '../../feature/address/screen/manage_address_screen.dart';
import '../../feature/profile/ProfileScreen.dart';





class AppRoutes {
  static const String profile = '/';
  static const String manageAddress = '/manage-address';
  static const String addAddress = '/add-address';

  static Map<String, WidgetBuilder> routes = {
    profile: (context) => const ProfileScreen(),
    manageAddress: (context) => const ManageAddressScreen(),
    addAddress: (context) => const AddNewAddressScreen(),

  };
}