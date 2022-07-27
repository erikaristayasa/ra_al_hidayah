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

  String get monthName {
    switch (this) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
      default:
        return 'Desember';
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

  BannerType get bannerType {
    if (this == 'HOMEPAGE') {
      return BannerType.homepage;
    } else {
      return BannerType.login;
    }
  }

  Gender get gender {
    if (this == 'Laki-Laki') {
      return Gender.male;
    } else {
      return Gender.female;
    }
  }

  GradeType get gradeType {
    if (this == 'TK_A') {
      return GradeType.tkA;
    } else if (this == 'TK_B') {
      return GradeType.tkB;
    } else {
      return GradeType.playgroup;
    }
  }

  PaymentStatus get paymentStatus {
    if (this == 'DIPROSES') {
      return PaymentStatus.process;
    } else if (this == 'DRAFT') {
      return PaymentStatus.draft;
    } else if (this == 'DITERIMA') {
      return PaymentStatus.accept;
    } else {
      return PaymentStatus.reject;
    }
  }
}

extension PaymentTypeTransformation on PaymentType {
  String get text {
    switch (this) {
      case PaymentType.activity:
        return 'KEGIATAN';
      case PaymentType.stationary:
        return 'ALAT_TULIS_DAN_BUKU_PAKET';
      case PaymentType.uniform:
        return 'SERAGAM_5_STEL';
      case PaymentType.hood:
        return 'KERUDUNG';
      case PaymentType.spp:
        return 'SPP';
      case PaymentType.buildingMoney:
        return 'UANG_BANGUNAN';
    }
  }

  String get title {
    switch (this) {
      case PaymentType.activity:
        return 'Pembayaran Kegiatan';
      case PaymentType.stationary:
        return 'Pembayaran Alat Tulis & Buku Paket';
      case PaymentType.uniform:
        return 'Pembayaran Seragam 5 Stel';
      case PaymentType.hood:
        return 'Pembayaran Kerudung';
      case PaymentType.spp:
        return 'Pembayaran SPP/Bulan';
      case PaymentType.buildingMoney:
        return 'Pembayaran Uang Bangunan';
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

extension BannerTypeTransformation on BannerType {
  String get text {
    if (this == BannerType.homepage) {
      return 'HOMEPAGE';
    } else {
      return 'LOGIN';
    }
  }
}

extension GradeTypeTransformation on GradeType {
  String get text {
    switch (this) {
      case GradeType.playgroup:
        return 'Playgroup';
      case GradeType.tkA:
        return 'TK A';
      case GradeType.tkB:
        return 'TK B';
    }
  }

  String get postValue {
    switch (this) {
      case GradeType.playgroup:
        return 'PLAYGROUP';
      case GradeType.tkA:
        return 'TK_A';
      case GradeType.tkB:
        return 'TK_B';
    }
  }
}

extension PaymentStatusTransformation on PaymentStatus {
  String get postValue {
    switch (this) {
      case PaymentStatus.process:
        return 'DIPROSES';
      case PaymentStatus.accept:
        return 'DITERIMA';
      case PaymentStatus.reject:
        return 'DITOLAK';
      case PaymentStatus.draft:
        return 'DRAFT';
    }
  }
}

extension GenderTransformation on Gender? {
  String get text {
    switch (this) {
      case Gender.male:
        return 'Laki-Laki';
      case Gender.female:
        return 'Perempuan';
      default:
        return '';
    }
  }
}

extension DynamicHeader on Dio {
  Dio withToken({String? token}) {
    if (token != null) {
      AppHelpers.logMe('set token: $token');
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
