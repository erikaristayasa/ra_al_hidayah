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

  static Future<String> getUserNameFromSession() async {
    final sharedPrefHelper = locator<SharedPreferencesHelper>();
    return sharedPrefHelper.userName;
  }

  static Future<String> getUserAddressFromSession() async {
    final sharedPrefHelper = locator<SharedPreferencesHelper>();
    return sharedPrefHelper.userAddress;
  }

  static Future<void> savingSession(Login data) async {
    final session = await locator.getAsync<SharedPreferencesHelper>();
    await session.setUserSession(data);
  }

  static Future<void> updateSession(User user) async {
    final session = await locator.getAsync<SharedPreferencesHelper>();
    await session.updateUserSession(user);
  }

  static String getRandomString(int length) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static List<Widget> getImageBanner(List<en.Banner> banners) {
    return List<Widget>.from(
      banners.map(
        (e) => Stack(
          children: [
            RoundedContainer(
              radius: 5.0,
              width: double.maxFinite,
              height: double.maxFinite,
              padding: const EdgeInsets.all(0.0),
              color: Colors.transparent,
              clipBerhaviour: Clip.antiAlias,
              child: InkWell(
                onTap: () {},
                child: Image.network(
                  e.photo,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: Colors.grey[200]!,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.clamp,
                ),
              ),
              child: const SizedBox.expand(),
              // color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
