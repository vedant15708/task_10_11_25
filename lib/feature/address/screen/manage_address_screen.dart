import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/utils/colors.dart';
import '../../../core/config/approute.dart';
import '../data/models/address_model.dart';
import 'edit_address_screen.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({Key? key}) : super(key: key);

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  late Box<AddressModel> addressBox;

  @override
  void initState() {
    super.initState();
    addressBox = Hive.box<AddressModel>('addressBox');

    // FOR TESTING: Add dummy data if box is empty
    if (addressBox.isEmpty) {
      addDummyData();
    }
  }

  void addDummyData() {
    addressBox.addAll([
      AddressModel(
        fullAddress: "799 Lost Creek Road",
        city: "Seattle",
        state: "Fort Washington",
        zipCode: "19034",
        country: "Us",
        isDefault: true,
      ),
      AddressModel(
        fullAddress: "799 Lost Creek Road",
        city: "Seattle",
        state: "Fort Washington",
        zipCode: "19034",
        country: "Us",
        isDefault: false,
      ),
    ]);
  }

  void _setDefault(int index) {
    // Set all to false
    for (var i = 0; i < addressBox.length; i++) {
      final address = addressBox.getAt(i);
      if (address != null && address.isDefault) {
        address.isDefault = false;
        addressBox.putAt(i, address);
      }
    }
    // Set selected to true
    final selectedAddress = addressBox.getAt(index);
    if (selectedAddress != null) {
      selectedAddress.isDefault = true;
      addressBox.putAt(index, selectedAddress);
    }
  }

  void _deleteAddress(int index) {
    addressBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Manage Address',
          style: TextStyle(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      // --- BODY LAYOUT UPDATED ---
      // Use SingleChildScrollView to keep "Add New" button
      // directly below the list
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Use ValueListenableBuilder to automatically update
            // the UI when data changes in the Hive box
            ValueListenableBuilder(
              valueListenable: addressBox.listenable(),
              builder: (context, Box<AddressModel> box, _) {
                if (box.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 64.h),
                      child: Text(
                        "No addresses found.",
                        style:
                        TextStyle(fontSize: 16.sp, color: AppColors.grey),
                      ),
                    ),
                  );
                }
                // Use a Column instead of ListView.builder
                // to avoid nested scrolling issues
                return Column(
                  children: List.generate(box.length, (index) {
                    final address = box.getAt(index);
                    if (address == null) return SizedBox.shrink();
                    return _buildAddressCard(address, index);
                  }),
                );
              },
            ),

            SizedBox(height: 16.h), // Spacing before the button

            // "Add New" button
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addAddress);
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: AppColors.primaryGreen,
                size: 24.sp,
              ),
              label: Text(
                "Add New",
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build each address card
  Widget _buildAddressCard(AddressModel address, int index) {
    return Card(
      elevation: 2,
      color: AppColors.white,
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0), // No bottom padding
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Radio button
                GestureDetector(
                  onTap: () => _setDefault(index),
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h, right: 12.w),
                    child: Icon(
                      address.isDefault
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                      color: address.isDefault
                          ? AppColors.primaryGreen
                          : AppColors.grey,
                      size: 22.sp,
                    ),
                  ),
                ),
                // Address text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.addressLine1,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        address.addressLine2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(height: 1.h, color: AppColors.grey.withOpacity(0.2)),
            // --- BUTTONS ROW UPDATED ---
            // Use IntrinsicHeight to make the VerticalDivider extend full height
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _buildTextButton(
                      icon: Icons.delete_outline,
                      label: "Delete",
                      color: Colors.red.shade600,
                      onPressed: () {
                        _deleteAddress(index);
                      },
                    ),
                  ),
                  VerticalDivider(
                    width: 1.w,
                    thickness: 1,
                    color: AppColors.grey.withOpacity(0.2),
                  ),
                  Expanded(
                    child: _buildTextButton(
                      icon: Icons.edit_outlined,
                      label: "Change",
                      color: AppColors.black,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAddressScreen(
                                addressIndex: index, // Pass the index
                              ),
                            ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18.sp),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}