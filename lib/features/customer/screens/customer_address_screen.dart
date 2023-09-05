import 'package:jiko_express/constants/utils.dart';
import 'package:jiko_express/features/customer/services/customer_services_screen.dart';
import 'package:provider/provider.dart';
import 'package:jiko_express/common/widgets/custom_textfield.dart';
import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:flutter/material.dart';

class CustomerAddressScreen extends StatefulWidget {
  static const String routeName = '/customer_address';
  final String totalAmount;
  const CustomerAddressScreen({super.key, required this.totalAmount});

  @override
  State<CustomerAddressScreen> createState() => _CustomerAddressScreenState();
}

class _CustomerAddressScreenState extends State<CustomerAddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  final CustomerServices customerServices = CustomerServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }

    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      customerServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    customerServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jiko Express',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Customer',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            address,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatBuildingController,
                        hintText: 'Flat, House no, Building',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: areaController,
                        hintText: 'Area, Street',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'Pincode',
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: 'Order',
                    onTap: () => payPressed(address),
                    color: Colors.yellow[600],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
