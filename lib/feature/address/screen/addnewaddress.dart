import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../../../../core/utils/colors.dart';
import '../data/models/address_model.dart';
import '../widgets/address_text_field.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late Box<AddressModel> addressBox;

  // Controllers for each text field
  final _addressController = TextEditingController();
  final _unitController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipcodeController = TextEditingController();
  final _instructionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressBox = Hive.box<AddressModel>('addressBox');
  }

  @override
  void dispose() {
    // Clean up controllers
    _addressController.dispose();
    _unitController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipcodeController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  void _onSaveAddress() {
    // 1. Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      // 2. Create the new AddressModel
      final newAddress = AddressModel(
        fullAddress: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipcodeController.text,
        country: "Us", // Hardcoding this as it's not in the form
        unitNumber: _unitController.text,
        deliveryInstruction: _instructionController.text,
        // If this is the first address, make it the default
        isDefault: addressBox.isEmpty,
      );

      // 3. Add to Hive
      addressBox.add(newAddress);

      // 4. Go back to the previous screen
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add New Address',
          style: TextStyle(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AddressTextField(
                  controller: _addressController,
                  hintText: "Address",
                  suffixIcon: Icons.location_on_outlined,
                  validator: (value) => (value == null || value.isEmpty)
                      ? "Address is required"
                      : null,
                ),
                AddressTextField(
                  controller: _unitController,
                  hintText: "Enter Unit Number",
                ),
                AddressTextField(
                  controller: _cityController,
                  hintText: "City",
                  // --- FIX ---
                  validator: (value) => (value == null || value.isEmpty)
                      ? "City is required"
                      : null,
                ),
                AddressTextField(
                  controller: _stateController,
                  hintText: "State",
                  // --- FIX ---
                  validator: (value) => (value == null || value.isEmpty)
                      ? "State is required"
                      : null,
                ),
                AddressTextField(
                  controller: _zipcodeController,
                  hintText: "Zipcode",
                  keyboardType: TextInputType.number,
                  // --- FIX ---
                  validator: (value) => (value == null || value.isEmpty)
                      ? "Zipcode is required"
                      : null,
                ),
                AddressTextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  controller: _instructionController,
                  hintText: "Delivery Instruction",
                ),
                SizedBox(height: 24.h),
                // "Add" Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onSaveAddress,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}