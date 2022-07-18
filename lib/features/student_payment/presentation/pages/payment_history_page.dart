import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/blocs/student/student_list_bloc.dart';
import '../../../../core/shared/presentation/pages/empty_page.dart';
import '../../../../core/shared/presentation/pages/loading_page.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/custom_search_bar.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../widgets/student_item.dart';
import 'payment_history_detail_page.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({Key? key}) : super(key: key);

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  final _listBloc = locator<StudentListBloc>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _listBloc..add(const FetchStudents(status: null, name: null, type: null))),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Riwayat Pembayaran',
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimensions.large),
                child: CustomSearchBar(onSubmit: (keyword) {
                  _listBloc.add(FetchStudents(status: null, name: keyword, type: null));
                }),
              ),
              BlocConsumer<StudentListBloc, StudentListState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is StudentListLoading) {
                    return const LoadingPage(
                      isList: true,
                    );
                  } else if (state is StudentListLoaded) {
                    final _data = state.data.takeWhile((value) => value.status == PaymentStatus.draft).toList();

                    if (_data.isEmpty) {
                    } else {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  'Draft Pendaftaran Siswa',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10.0,
                                  ),
                                ),
                                AppHelpers.smallVerticalSpacing(),
                                const Text(
                                  'Berisi form pendaftaran siswa yang sudah terisi sebelumnya.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10.0,
                                    color: AppColors.textGrey,
                                    height: 1.5,
                                  ),
                                ),
                                AppHelpers.mediumVerticalSpacing(),
                              ],
                            ),
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                            shrinkWrap: true,
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              final _student = _data[index];
                              return StudentItem(
                                data: _student,
                                isHistory: true,
                                onTap: () {
                                  // Navigator.pushNamed(context, AppPaths.paymentDetail, arguments: PaymentDetailPageRouteArguments(student: _student));
                                },
                              );
                            },
                            separatorBuilder: (_, __) => AppHelpers.mediumVerticalSpacing(),
                          ),
                        ],
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Riwayat Pembayaran Siswa',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                      ),
                    ),
                    AppHelpers.smallVerticalSpacing(),
                    const Text(
                      'Berisi form pendaftaran siswa yang sudah terisi sebelumnya.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.0,
                        color: AppColors.textGrey,
                        height: 1.5,
                      ),
                    ),
                    AppHelpers.mediumVerticalSpacing(),
                  ],
                ),
              ),
              Expanded(
                child: BlocConsumer<StudentListBloc, StudentListState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is StudentListLoading) {
                      return const LoadingPage(
                        isList: true,
                      );
                    } else if (state is StudentListLoaded) {
                      final _data = state.data.skipWhile((value) => value.status == PaymentStatus.draft).toList();

                      if (_data.isEmpty) {
                        return const EmptyPage(
                          title: 'Tidak ada data siswa.',
                          center: true,
                        );
                      } else {
                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: AppDimensions.large),
                          shrinkWrap: true,
                          itemCount: _data.length,
                          itemBuilder: (context, index) {
                            final _student = _data[index];
                            return StudentItem(
                              data: _student,
                              isHistory: true,
                              onTap: () {
                                Navigator.pushNamed(context, AppPaths.paymentHistoryDetail,
                                    arguments: PaymentHistoryDetailPageRouteArguments(student: _student));
                              },
                            );
                          },
                          separatorBuilder: (_, __) => AppHelpers.mediumVerticalSpacing(),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
