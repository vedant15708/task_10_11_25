import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../../../../core/utils/colors.dart';
import '../data/models/address_model.dart';
import '../widgets/address_text_field.dart';
import 'package:flutter/services.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late Box<AddressModel> addressBox;

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
    _addressController.dispose();
    _unitController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipcodeController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  void _onSaveAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      final newAddress = AddressModel(
        fullAddress: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipcodeController.text,
        country: "Us",
        unitNumber: _unitController.text,
        deliveryInstruction: _instructionController.text,
        isDefault: addressBox.isEmpty,
      );
      addressBox.add(newAddress);
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value) => (value == null || value.isEmpty)
                      ? "City is required"
                      : null,
                ),
                AddressTextField(
                  controller: _stateController,
                  hintText: "State",
                  validator: (value) => (value == null || value.isEmpty)
                      ? "State is required"
                      : null,
                ),
                AddressTextField(
                  controller: _zipcodeController,
                  hintText: "Zipcode",
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9-]')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Zipcode is required";
                    }
                    final zipCodePattern = RegExp(r'^\d{5}(?:-\d{4})?$');
                    if (!zipCodePattern.hasMatch(value)) {
                      return "Enter a valid US zipcode (e.g., 12345 or 12345-6789)";
                    }
                    return null;
                  },
                ),
                AddressTextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  controller: _instructionController,
                  hintText: "Delivery Instruction",
                ),
                SizedBox(height: 24.h),
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