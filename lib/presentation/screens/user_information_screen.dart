import 'package:discipline/data/user_data.dart';
import 'package:discipline/presentation/screens/user_dream_screen.dart';
import 'package:discipline/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(USER_INFORMATION_TITLE)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<UserData>(
      builder: (context, userData, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNameField(userData),
                const SizedBox(height: 16),
                _buildSurnameField(userData),
                const SizedBox(height: 24),
                _buildSubmitButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNameField(UserData userData) {
    return TextFormField(
      initialValue: userData.name,
      onChanged: userData.updateName,
      decoration: const InputDecoration(labelText: USER_INFORMATION_NAME_LABEL),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return TEXT_FORM_FIELD_ERROR;
        }
        return null;
      },
    );
  }

  Widget _buildSurnameField(UserData userData) {
    return TextFormField(
      initialValue: userData.surname,
      onChanged: userData.updateSurname,
      decoration:
          const InputDecoration(labelText: USER_INFORMATION_SURNAME_LABEL),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return TEXT_FORM_FIELD_ERROR;
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UserDreamScreen(),
            ),
          );
        }
      },
      child: const Text(USER_INFORMATION_BUTTON_TITLE),
    );
  }
}
