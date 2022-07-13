part of 'utilities.dart';

class AppHelpers {
  static logMe(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }

  static Widget smallVerticalSpacing() => const SizedBox(height: AppDimensions.small);
  static Widget mediumVerticalSpacing() => const SizedBox(height: AppDimensions.medium);
  static Widget largeVerticalSpacing() => const SizedBox(height: AppDimensions.large);

  static Widget smallHorizontalSpacing() => const SizedBox(width: AppDimensions.small);
  static Widget mediumHorizontalSpacing() => const SizedBox(width: AppDimensions.medium);
  static Widget largeHorizontalSpacing() => const SizedBox(width: AppDimensions.large);

  static String getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ConnectionFailure:
        return 'Tidak ada koneksi. Silahkan coba kembali.';
      case ServerFailure:
        if (failure.message != null) {
          return failure.message!;
        }
        return 'Server Error.';
      default:
        return 'Unexpected Error.';
    }
  }

  static Future<AccountType> getAccountTypeFromSession() async {
    final sharedPrefHelper = locator<SharedPreferencesHelper>();
    final userAccountType = sharedPrefHelper.userAccountType;
    return userAccountType.getAccountType;
  }

  static Future<String> getUserPhotoFromSession() async {
    final sharedPrefHelper = locator<SharedPreferencesHelper>();
    return sharedPrefHelper.userPhoto;
  }

  // static Future<void> savingSession(Login data) async {
  //   final session = await locator.getAsync<SharedPreferencesHelper>();
  //   await session.setUserSession(data);
  // }

  static Future<void> updateSession(User user) async {
    final session = await locator.getAsync<SharedPreferencesHelper>();
    await session.updateUserSession(user);
  }

  static String getRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }
}
