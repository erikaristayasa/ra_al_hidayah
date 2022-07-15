part of 'statics.dart';

extension ThemeOfContext on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;
}

extension DateFormatting on DateTime? {
  String toText({String? format}) {
    if (this == null) {
      return '';
    }
    return DateFormat(format ?? "yyyy-MM-dd").format(this!);
  }
}

extension IntTransformation on int {
  AccountType get getAccountType {
    if (this == 1) {
      return AccountType.student;
    } else {
      return AccountType.lecturer;
    }
  }
}

extension StringTransformation on String {
  DateTime? toDate({String? format}) {
    try {
      final date = DateFormat(format ?? "yyyy-MM-dd").parse(this);
      return date;
    } catch (e) {
      return null;
    }
  }

  String toCapitalized() => length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');

  AccountType get getAccountType {
    if (this == 'MAHASISWA') {
      return AccountType.student;
    } else if (this == 'ORANG_TUA') {
      return AccountType.parent;
    } else {
      return AccountType.lecturer;
    }
  }

  TeachingMaterialStatus get getTeachingMaterialStatus {
    if (this == 'AKTIF') {
      return TeachingMaterialStatus.active;
    } else {
      return TeachingMaterialStatus.inactive;
    }
  }
}

extension AccountTypeTransformation on AccountType {
  String get text {
    if (this == AccountType.student) {
      return 'MAHASISWA';
    } else if (this == AccountType.parent) {
      return 'ORANG_TUA';
    } else {
      return 'DOSEN';
    }
  }
}

extension TeachingMaterialStatusTransformation on TeachingMaterialStatus {
  String get text {
    if (this == TeachingMaterialStatus.active) {
      return 'Aktif';
    } else {
      return 'Tidak aktif';
    }
  }

  Color get color {
    if (this == TeachingMaterialStatus.active) {
      return AppColors.success;
    } else {
      return AppColors.error;
    }
  }
}

extension DynamicHeader on Dio {
  Dio withToken({String? token}) {
    if (token != null) {
      return this..options.headers.addAll({'Authorization': 'Bearer ' + token});
    }
    return this..options.headers.addAll({'token': true});
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
