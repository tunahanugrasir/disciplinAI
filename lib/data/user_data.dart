import 'package:discipline/data/service/api_service.dart';
import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  String name = '';
  String surname = '';
  String age = '24';
  String goals = '';
  String mistake = '';
  bool _isLoading = false;
  String _response = '';
  ApiService? apiService;

  UserData({this.apiService});

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateSurname(String newSurname) {
    surname = newSurname;
    notifyListeners();
  }

  void updateAge(String newAge) {
    age = newAge;
    notifyListeners();
  }

  void updateGoals(String newGoals) {
    goals = newGoals;
    notifyListeners();
  }

  void updateMistake(String newMistake) {
    mistake = newMistake;
    notifyListeners();
  }

  void updateApiService() {
    apiService = ApiService(name, surname, age, goals, mistake);
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'age': age,
      'goals': goals,
      'mistake': mistake,
    };
  }

  bool get isLoading => _isLoading;
  String get response => _response;

  Future<void> fetchResponse() async {
    if (apiService == null) {
      _response = 'API service is not initialized';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();
    try {
      final result = await apiService!.getChatCompletion();
      _response = result;
    } catch (e) {
      _response = 'Failed to load response $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void controlTheInformation() async {
    print('Ad: $name');
    print('Soyad: $surname');
    print('Yaş: $age');
    print('Hedefler: $goals');
    print('Eksiklikler: $mistake');
  }
}
