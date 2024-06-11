import 'package:discipline/data/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDreamScreen extends StatefulWidget {
  const UserDreamScreen({super.key});

  @override
  UserDreamScreenState createState() => UserDreamScreenState();
}

class UserDreamScreenState extends State<UserDreamScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _goalsController;
  late TextEditingController _mistakeController;
  late FocusNode _goalsFocusNode;

  @override
  void initState() {
    super.initState();
    _goalsController = TextEditingController();
    _mistakeController = TextEditingController();
    _goalsFocusNode = FocusNode();

    final userData = Provider.of<UserData>(context, listen: false);
    _goalsController.text = userData.goals;
    _mistakeController.text = userData.mistake;
  }

  @override
  void dispose() {
    _goalsController.dispose();
    _mistakeController.dispose();
    _goalsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Hedeflerim'),
      ),
      body: Consumer<UserData>(builder: (context, userData, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: FocusScope(
              onFocusChange: (hasFocus) {
                if (!hasFocus) {
                  FocusScope.of(context).unfocus();
                }
              },
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Ben Kim Olmak İstiyorum?',
                      style: TextStyle(color: Colors.pink, fontSize: 33),
                    ),
                    const SizedBox(height: 100),
                    _buildGoalsField(userData),
                    _buildMistakeField(userData),
                    _buildSubmitButton(userData),
                    _buildResponse(userData)
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildGoalsField(UserData userData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        focusNode: _goalsFocusNode,
        controller: _goalsController,
        onChanged: userData.updateGoals,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen hedeflerinizi girin';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Hedeflerim',
        ),
      ),
    );
  }

  Widget _buildMistakeField(UserData userData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _mistakeController,
        onChanged: userData.updateMistake,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Kendinizde gördüğünüz eksiklikler';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Eksikliklerim',
        ),
      ),
    );
  }

  Widget _buildSubmitButton(UserData userData) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            userData.updateApiService();
            userData.fetchResponse();
          }
        },
        child: const Text("Kontrol et"),
      ),
    );
  }

  Widget _buildResponse(UserData userData) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        userData.response,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
