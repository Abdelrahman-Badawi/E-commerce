import 'package:e_commerce/utilities/routes.dart';
import 'package:e_commerce/views/widgets/main_botton.dart';
import 'package:flutter/material.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  const AddNewCardBottomSheet({super.key});

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  late final GlobalKey<FormState> _formKey;
  final TextEditingController _nameOnCardController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expierDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    // _nameOnCardController.dispose();
    // _cardNumberController.dispose();
    // _expierDateController.dispose();
    // _cvvController.dispose();
    // super.dispose();
  }

  @override
  void dispose() {
    _nameOnCardController.dispose();
    _cardNumberController.dispose();
    _expierDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.8,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Text(
              'Add New Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _nameOnCardController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your name'
                    : null,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _cardNumberController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter Card number'
                    : null,
                onChanged: (value) {
                  String newValue = value.replaceAll('-', '');
                  if (newValue.length % 4 == 0 && newValue.length < 16) {
                    _cardNumberController.text += '-';
                  }
                  if (value.length >= 20) {
                    _cardNumberController.text = value.substring(0, 19);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Card Numbere',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _expierDateController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your Date'
                    : null,
                onChanged: (value) {
                  if (value.length == 2 && !value.contains('/')) {
                    _expierDateController.text = value + '/';
                    _expierDateController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: _expierDateController.text.length),
                    );
                  }
                  if (value.length == 6 && !value.contains('/')) {
                    _expierDateController.text = value.substring(0, 5);
                    _expierDateController.selection =
                        TextSelection.fromPosition(
                      TextPosition(offset: _expierDateController.text.length),
                    );
                  }
                },
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Expire Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _cvvController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter your cvv'
                    : null,
                onChanged: (value) {
                  if (value.length >= 3) {
                    _cvvController.text = value.substring(0, 3);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MainBotton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  text: 'Add Card'),
            ),
            const SizedBox(
              height: 32.0,
            )
          ],
        ),
      ),
    );
  }
}
