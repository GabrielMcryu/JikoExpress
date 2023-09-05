import 'package:jiko_express/common/widgets/custom_button.dart';
import 'package:jiko_express/constants/global_variables.dart';
import 'package:jiko_express/features/customer/screens/customer_address_screen.dart';
import 'package:jiko_express/features/customer/widgets/cart_product.dart';
import 'package:jiko_express/features/customer/widgets/cart_subtotal.dart';
import 'package:jiko_express/features/customer/widgets/address_box.dart';
import 'package:jiko_express/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
        context,
        CustomerAddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['meal']['price'] as int)
        .toList();

    return Scaffold(
        body: SingleChildScrollView(

          child: Column(
            children: [
              const AddressBox(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Proceed to Order (${user.cart.length} items)',
                  onTap: () => navigateToAddress(sum),
                  color: Colors.yellow[600],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(height: 5),
              ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
    );
  }
}
