import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../widgets/grade_button.dart';
import '../widgets/student_registration_warning_dialog.dart';

class StudentRegistrationPage extends StatefulWidget {
  const StudentRegistrationPage({Key? key}) : super(key: key);

  @override
  State<StudentRegistrationPage> createState() => _StudentRegistrationPageState();
}

class _StudentRegistrationPageState extends State<StudentRegistrationPage> {
  late List<Widget> _images;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    _images = List<Widget>.from(
      [
        'https://s3.theasianparent.com/cdn-cgi/image/width=1200,fit=crop/tap-assets-prod/wp-content/uploads/sites/24/2020/04/preschool-terbaik-di-bandung-featured-650x339.jpg',
        'https://cdf.orami.co.id/unsafe/cdn-cas.orami.co.id/parenting/images/paud-playgroup-TK.width-800.jpegquality-80.jpg',
        'https://asset-a.grid.id/crop/0x0:0x0/750x500/photo/media/image/original/8028_anak-sekolah.jpg'
      ].map(
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
                  e,
                  fit: BoxFit.cover,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Pendaftaran Siswa',
        trailing: IconButton(
          padding: const EdgeInsets.all(0.0),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Keluar'),
                content: const Text(
                  'Yakin untuk keluar dari Aplikasi?',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final session = await locator.getAsync<SharedPreferencesHelper>();
                      await session.logOut().then(
                            (_) => Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppPaths.login,
                              (route) => false,
                            ),
                          );
                    },
                    child: const Text('Iya'),
                  )
                ],
              ),
            );
          },
          icon: SvgPicture.asset(
            AppAssets.iconLogout,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppDimensions.large),
          children: [
            AspectRatio(
              aspectRatio: 4 / 2,
              child: Stack(
                children: [
                  CarouselSlider(
                    items: _images,
                    carouselController: _controller,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      aspectRatio: 4 / 2,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: AppDimensions.small),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _images.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0,
                                height: 8.0,
                                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: _current == entry.key ? AppColors.primary : AppColors.indicatorGrey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppHelpers.mediumVerticalSpacing(),
            const Text(
              'Daftarkan Anak Anda!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.0,
                color: AppColors.primary,
              ),
            ),
            const Text(
              'Silahkan daftar sesuai dengan angkatan dan kuota yang tersedia.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
              ),
            ),
            AppHelpers.largeVerticalSpacing(),
            const Text(
              'Periode Pendaftaran 16 Januari 2022',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
                color: AppColors.primary,
              ),
            ),
            AppHelpers.largeVerticalSpacing(),
            GradeButton(
              onTap: () {
                showDialog(context: context, builder: (context) => const StudentRegistrationWarningDIalog());
              },
              quota: 10,
              title: 'TK A',
              backgroundColor: AppColors.primary,
            ),
            AppHelpers.mediumVerticalSpacing(),
            GradeButton(
              onTap: () {
                showDialog(context: context, builder: (context) => const StudentRegistrationWarningDIalog());
              },
              quota: 10,
              title: 'TK B',
              backgroundColor: const Color(0xFFF39A1A),
            ),
            AppHelpers.mediumVerticalSpacing(),
            GradeButton(
              onTap: () {
                showDialog(context: context, builder: (context) => const StudentRegistrationWarningDIalog());
              },
              quota: 10,
              title: 'Playgroup',
              backgroundColor: const Color(0xFF908CD6),
            ),
          ],
        ),
      ),
    );
  }
}
