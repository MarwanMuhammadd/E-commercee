import 'package:counter/utlis/app_color.dart';
import 'package:counter/view_models/add_new_card_cubit/add_new_card_cubit.dart';
import 'package:counter/views/pages/widget/label_with_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _addNewCardController = TextEditingController();
  final TextEditingController _cardHolderNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Center(child: Text("Add New Cart"))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      LabelWithTextfield(
                        controller: _addNewCardController,
                        label: "Card Number",
                        prefixIcon: Icons.credit_card,
                        hintText: "Enter Card number ",
                      ),
                      LabelWithTextfield(
                        controller: _cardHolderNameController,
                        label: "Card Holder Name",
                        prefixIcon: Icons.person,
                        hintText: "Enter Card Holder Name ",
                      ),
                      LabelWithTextfield(
                        controller: _expiryDateController,
                        label: "Expiry Date",
                        prefixIcon: Icons.date_range,
                        hintText: "Enter Expiry Date ",
                      ),
                      LabelWithTextfield(
                        controller: _cvvController,
                        label: "CCV",
                        prefixIcon: Icons.password,
                        hintText: "Enter CVV ",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: BlocConsumer<AddNewCardCubit, AddNewCardState>(
                bloc: BlocProvider.of<AddNewCardCubit>(context),
                listenWhen:
                    (previous, current) =>
                        current is AddNewCardLoaded ||
                        current is AddNewCardfailure,
                listener: (context, state) {
                  if (state is AddNewCardLoaded) {
                    Navigator.pop(context);
                  } else if (state is AddNewCardfailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.massage)));
                  }
                },
                buildWhen:
                    (previous, current) =>
                        current is ConfirmPaymentLoading ||
                        current is AddNewCardLoaded ||
                        current is AddNewCardfailure,
                builder: (context, state) {
                  if (state is ConfirmPaymentLoading) {
                    return ElevatedButton(
                      onPressed: null,
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AddNewCardCubit>(context).addNewCardPayemnt(
                          _addNewCardController.text,
                          _cardHolderNameController.text,
                          _expiryDateController.text,
                          _cvvController.text,
                        );
                      }
                    },
                    child: Text("Add Card"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
