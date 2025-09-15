import '../../../core/resources/base_usecase.dart';
import '../../../core/resources/data_state.dart';
import '../../entities/auth/user_entity.dart';
import '../../repositories/auth_repository.dart';

/// Login use case parameters
class LoginParams {
  const LoginParams({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  final String email;
  final String password;
  final bool rememberMe;
}

/// Use case for user login
class LoginUseCase extends UseCase<LoginResponseEntity, LoginParams> {
  LoginUseCase(this._authRepository);

  final AuthRepository _authRepository;

  @override
  Future<DataState<LoginResponseEntity>> call({LoginParams? params}) async {
    if (params == null) {
      return const DataFailed(
        error: 'Login parameters are required',
        errorCode: 'INVALID_PARAMS',
      );
    }

    // Validate email
    if (params.email.isEmpty) {
      return const DataFailed(
        error: 'Email is required',
        errorCode: 'EMAIL_REQUIRED',
      );
    }

    // Validate email format
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegex.hasMatch(params.email)) {
      return const DataFailed(
        error: 'Invalid email format',
        errorCode: 'INVALID_EMAIL',
      );
    }

    // Validate password
    if (params.password.isEmpty) {
      return const DataFailed(
        error: 'Password is required',
        errorCode: 'PASSWORD_REQUIRED',
      );
    }

    if (params.password.length < 6) {
      return const DataFailed(
        error: 'Password must be at least 6 characters',
        errorCode: 'PASSWORD_TOO_SHORT',
      );
    }

    try {
      // Perform login
      final result = await _authRepository.login(
        email: params.email.trim().toLowerCase(),
        password: params.password,
      );

      // Handle remember me
      if (result.isSuccess && params.rememberMe) {
        await _authRepository.saveCredentials(
          email: params.email.trim().toLowerCase(),
          password: params.password,
        );
      }

      return result;
    } catch (e) {
      return DataFailed(
        error: 'An unexpected error occurred during login',
        errorCode: 'LOGIN_ERROR',
        errorDetails: {'exception': e.toString()},
      );
    }
  }
}