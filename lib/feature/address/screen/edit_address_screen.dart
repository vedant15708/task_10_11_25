import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import '../../../../core/utils/colors.dart';
import '../data/models/address_model.dart';
import '../widgets/address_text_field.dart';

class EditAddressScreen extends StatefulWidget {
  final int addressIndex;

  const EditAddressScreen({
    Key? key,
    required this.addressIndex,
  }) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late Box<AddressModel> addressBox;
  AddressModel? _addressToEdit;

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
    _loadAddressData();
  }

  void _loadAddressData() {
    _addressToEdit = addressBox.getAt(widget.addressIndex);

    if (_addressToEdit != null) {
      _addressController.text = _addressToEdit!.fullAddress;
      _cityController.text = _addressToEdit!.city;
      _stateController.text = _addressToEdit!.state;
      _zipcodeController.text = _addressToEdit!.zipCode;
      _unitController.text = _addressToEdit!.unitNumber ?? '';
      _instructionController.text = _addressToEdit!.deliveryInstruction ?? '';
    }
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

  void _onUpdateAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_addressToEdit != null) {
        _addressToEdit!.fullAddress = _addressController.text;
        _addressToEdit!.city = _cityController.text;
        _addressToEdit!.state = _stateController.text;
        _addressToEdit!.zipCode = _zipcodeController.text;
        _addressToEdit!.unitNumber = _unitController.text;
        _addressToEdit!.deliveryInstruction = _instructionController.text;
        _addressToEdit!.save();
        Navigator.pop(context);
      }
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
          'Edit Address',
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
                  validator: (value) =>
                  (value == null || value.isEmpty)
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
                  validator: (value) =>
                  (value == null || value.isEmpty)
                      ? "City is required"
                      : null,
                ),
                AddressTextField(
                  controller: _stateController,
                  hintText: "State",
                  validator: (value) =>
                  (value == null || value.isEmpty)
                      ? "State is required"
                      : null,
                ),
                AddressTextField(
                  controller: _zipcodeController,
                  hintText: "Zipcode",
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  (value == null || value.isEmpty)
                      ? "Zipcode is required"
                      : null,
                ),
                AddressTextField(
                  controller: _instructionController,
                  hintText: "Delivery Instruction",
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                ),
                SizedBox(height: 24.h),
                // "Update" Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onUpdateAddress, // <-- Calls update function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      "Update", // <-- Text changed
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