/// Utility class for greeting messages
class GreetingUtils {
  GreetingUtils._();

  /// Returns appropriate greeting based on current time
  static String getGreeting() {
    final int hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  /// Returns greeting with custom user name
  static String getPersonalizedGreeting(String? userName) {
    final String greeting = getGreeting();
    
    if (userName != null && userName.isNotEmpty) {
      return '$greeting, $userName';
    }
    
    return greeting;
  }
}