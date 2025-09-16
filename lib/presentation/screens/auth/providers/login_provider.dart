import 'package:flutter/material.dart';

import '../../../../core/database/database.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../domain/entities/auth/user_entity.dart';
import '../../../../domain/usecases/auth/login_usecase.dart';

/// Provider for managing login state
class LoginProvider extends ChangeNotifier {
  LoginProvider({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase;

  final LoginUseCase _loginUseCase;

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // State variables
  DataState<LoginResponseEntity>? _loginState;
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  // Getters
  DataState<LoginResponseEntity>? get loginState => _loginState;
  bool get rememberMe => _rememberMe;
  bool get isPasswordVisible => _isPasswordVisible;
  String? get emailError => _emailError;
  String? get passwordError => _passwordError;
  bool get isLoading => _isLoading;
  bool get canSubmit => 
      emailController.text.isNotEmpty && 
      passwordController.text.isNotEmpty && 
      !_isLoading;

  /// Toggle remember me checkbox
  void toggleRememberMe() {
    _rememberMe = !_rememberMe;
    notifyListeners();
  }

  /// Toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  /// Set email error
  void setEmailError(String? error) {
    _emailError = error;
    notifyListeners();
  }

  /// Set password error
  void setPasswordError(String? error) {
    _passwordError = error;
    notifyListeners();
  }

  /// Clear all errors
  void clearErrors() {
    _emailError = null;
    _passwordError = null;
    notifyListeners();
  }

  /// Validate email
  bool validateEmail() {
    final String email = emailController.text.trim();
    
    if (email.isEmpty) {
      setEmailError('Email is required');
      return false;
    }
    
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    
    if (!emailRegex.hasMatch(email)) {
      setEmailError('Please enter a valid email');
      return false;
    }
    
    setEmailError(null);
    return true;
  }

  /// Validate password
  bool validatePassword() {
    final String password = passwordController.text;
    
    if (password.isEmpty) {
      setPasswordError('Password is required');
      return false;
    }
    
    if (password.length < 6) {
      setPasswordError('Password must be at least 6 characters');
      return false;
    }
    
    setPasswordError(null);
    return true;
  }

  /// Validate form
  bool validateForm() {
    final bool isEmailValid = validateEmail();
    final bool isPasswordValid = validatePassword();
    return isEmailValid && isPasswordValid;
  }

  /// Perform login
  Future<void> login() async {
    // Clear previous state
    clearErrors();
    _loginState = null;
    
    // Validate form
    if (!validateForm()) {
      return;
    }
    
    // Set loading state
    _isLoading = true;
    _loginState = const DataLoading<LoginResponseEntity>();
    notifyListeners();
    
    try {
      // Try local database first (for testing)
      final bool localLoginSuccess = await _tryLocalLogin();
      
      if (localLoginSuccess) {
        _isLoading = false;
        _loginState = DataSuccess<LoginResponseEntity>(
          LoginResponseEntity(
            user: UserEntity(
              userId: '1',
              email: emailController.text.trim().toLowerCase(),
              name: 'Test User',
            ),
            token: const AuthTokenEntity(
              accessToken: 'local_test_token',
              refreshToken: 'local_refresh_token',
              expiresIn: 3600,
            ),
          ),
        );
        notifyListeners();
        return;
      }
      
      // If local login fails, try API login
      final LoginParams params = LoginParams(
        email: emailController.text.trim().toLowerCase(),
        password: passwordController.text,
        rememberMe: _rememberMe,
      );
      
      final DataState<LoginResponseEntity> result = await _loginUseCase.call(params: params);
      
      // Update state
      _loginState = result;
      _isLoading = false;
      
      // Handle errors
      if (result.isFailed && result is DataFailed<LoginResponseEntity>) {
        _handleLoginError(result);
      }
      
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _loginState = DataFailed<LoginResponseEntity>(
        error: 'An unexpected error occurred',
        errorCode: 'UNEXPECTED_ERROR',
        errorDetails: <String, dynamic>{'exception': e.toString()},
      );
      notifyListeners();
    }
  }

  /// Try to login with local database
  Future<bool> _tryLocalLogin() async {
    try {
      final AppDatabase database = AppDatabase();
      
      final List<LocalUser> users = await (database.select(database.users)
          ..where(($UsersTable u) => u.email.equals(emailController.text.trim().toLowerCase()))).get();
      
      if (users.isNotEmpty) {
        final LocalUser user = users.first;
        // Simple password check (in real app, use proper hashing)
        if (user.password == passwordController.text) {
          return true;
        }
      }
      
      return false;
    } catch (e) {
      debugPrint('Local login error: $e');
      return false;
    }
  }

  /// Handle login errors
  void _handleLoginError(DataFailed<LoginResponseEntity> error) {
    switch (error.errorCode) {
      case 'INVALID_EMAIL':
      case 'EMAIL_REQUIRED':
        setEmailError(error.error);
        break;
      case 'INVALID_PASSWORD':
      case 'PASSWORD_REQUIRED':
      case 'PASSWORD_TOO_SHORT':
        setPasswordError(error.error);
        break;
      case 'INVALID_CREDENTIALS':
        setEmailError('Invalid email or password');
        setPasswordError('Invalid email or password');
        break;
      case 'ACCOUNT_DISABLED':
      case 'ACCOUNT_LOCKED':
        setEmailError(error.error);
        break;
      default:
        // Show general error
        if (error.error.toLowerCase().contains('email')) {
          setEmailError(error.error);
        } else if (error.error.toLowerCase().contains('password')) {
          setPasswordError(error.error);
        }
        break;
    }
  }


  /// Login with saved credentials
  Future<void> loginWithSavedCredentials(String email, String password) async {
    emailController.text = email;
    passwordController.text = password;
    _rememberMe = true;
    await login();
  }

  /// Forgot password
  Future<void> forgotPassword() async {
    // TODO: Navigate to forgot password screen
    debugPrint('Navigate to forgot password');
  }

  /// Clear login state
  void clearLoginState() {
    _loginState = null;
    notifyListeners();
  }

  /// Reset form
  void resetForm() {
    emailController.clear();
    passwordController.clear();
    _rememberMe = false;
    _isPasswordVisible = false;
    clearErrors();
    clearLoginState();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}