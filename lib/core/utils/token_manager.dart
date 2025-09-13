import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Token manager for handling JWT tokens securely
class TokenManager {
  TokenManager({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _userIdKey = 'user_id';

  final FlutterSecureStorage _storage;

  /// Save tokens securely
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    int? expiresIn,
  }) async {
    await Future.wait(<Future<void>>[
      _storage.write(key: _accessTokenKey, value: accessToken),
      _storage.write(key: _refreshTokenKey, value: refreshToken),
      if (expiresIn != null)
        _storage.write(
          key: _tokenExpiryKey,
          value: DateTime.now()
              .add(Duration(seconds: expiresIn))
              .millisecondsSinceEpoch
              .toString(),
        ),
    ]);
  }

  /// Get access token
  Future<String?> getAccessToken() async =>
      await _storage.read(key: _accessTokenKey);

  /// Get refresh token
  Future<String?> getRefreshToken() async =>
      await _storage.read(key: _refreshTokenKey);

  /// Check if token is expired
  Future<bool> isTokenExpired() async {
    final String? expiryString = await _storage.read(key: _tokenExpiryKey);
    if (expiryString == null) return true;

    try {
      final int expiry = int.parse(expiryString);
      return DateTime.now().millisecondsSinceEpoch > expiry;
    } catch (_) {
      return true;
    }
  }

  /// Clear all tokens
  Future<void> clearTokens() async => await _storage.deleteAll();

  /// Save user ID
  Future<void> saveUserId(String userId) async =>
      await _storage.write(key: _userIdKey, value: userId);

  /// Get user ID
  Future<String?> getUserId() async => await _storage.read(key: _userIdKey);

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final String? token = await getAccessToken();
    if (token == null) return false;

    final bool expired = await isTokenExpired();
    return !expired;
  }

  /// Update access token only
  Future<void> updateAccessToken(String accessToken, {int? expiresIn}) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (expiresIn != null) {
      await _storage.write(
        key: _tokenExpiryKey,
        value: DateTime.now()
            .add(Duration(seconds: expiresIn))
            .millisecondsSinceEpoch
            .toString(),
      );
    }
  }
}
