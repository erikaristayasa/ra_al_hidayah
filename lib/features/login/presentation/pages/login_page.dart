import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../core/shared/presentation/blocs/banner/banner_bloc.dart';
import '../../../../core/shared/presentation/widgets/page_info.dart';
import '../../../../core/shared/presentation/widgets/rounded_container.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../bloc/login_bloc.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late List<Widget> _images;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<BannerBloc>()..add(const Fetch(type: BannerType.login)),
        ),
      ],
      child: LoaderOverlay(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: [
              BlocConsumer<BannerBloc, BannerState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is BannerLoaded) {
                    _images = List<Widget>.from(
                      state.data.map(
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

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large, vertical: AppDimensions.medium),
                      child: AspectRatio(
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
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              AppHelpers.mediumVerticalSpacing(),
              Image.asset(
                AppAssets.logo,
                width: 80.0,
                height: 80.0,
              ),
              const PageInfo(
                title: 'Login',
                description: 'Silahkan Login  jika sudah memiliki akun.',
              ),
              const LoginForm()
            ],
          ),
        ),
      ),
    );
  }
}
