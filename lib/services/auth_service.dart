class AuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate a network delay
    return true; // Accept any credentials
  }
}

