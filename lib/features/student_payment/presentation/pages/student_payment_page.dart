import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/shared/presentation/blocs/student/student_list_bloc.dart';
import '../../../../core/shared/presentation/cubits/navbar_cubit.dart';
import '../../../../core/shared/presentation/pages/empty_page.dart';
import '../../../../core/shared/presentation/pages/loading_page.dart';
import '../../../../core/shared/presentation/widgets/custom_app_bar.dart';
import '../../../../core/shared/presentation/widgets/custom_search_bar.dart';
import '../../../../core/statics/statics.dart';
import '../../../../core/utilities/utilities.dart';
import '../widgets/empty_students_bottom_sheet.dart';
import '../widgets/student_item.dart';
import 'payment_detail_page.dart';

class StudentPaymentPage extends StatefulWidget {
  final NavbarCubit navbarCubit;
  const StudentPaymentPage({Key? key, required this.navbarCubit}) : super(key: key);

  @override
  State<StudentPaymentPage> createState() => _StudentPaymentPageState();
}

class _StudentPaymentPageState extends State<StudentPaymentPage> {
  final _listBloc = locator<StudentListBloc>();
  bool _firstLoad = true;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _listBloc..add(const FetchStudents(status: null, name: null, type: null))),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: 'Pembayaran Siswa',
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimensions.large),
                child: CustomSearchBar(onSubmit: (keyword) {
                  _firstLoad = false;
                  _listBloc.add(FetchStudents(status: null, name: keyword, type: null));
                }),
              ),
              Expanded(
                child: BlocConsumer<StudentListBloc, StudentListState>(
                  listener: (context, state) {
                    if (state is StudentListLoaded) {
                      final _data = state.data;
                      _data.removeWhere((element) => element.status == PaymentStatus.draft);
                      if (_data.isEmpty && _firstLoad) {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => EmptyStudentsBottomSheet(
                            title: '',
                            message: 'Silahkan daftarkan siswa terlebih dahulu pada halaman pendaftaran.',
                            onConfirm: () {
                              Navigator.pop(context);
                              widget.navbarCubit.change(0);
                            },
                          ),
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is StudentListLoading) {
                      return const LoadingPage(
                        isList: true,
                      );
                    } else if (state is StudentListLoaded) {
                      final _data = state.data;
                      _data.removeWhere((element) => element.status == PaymentStatus.draft);
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
                              onTap: () {
                                if (_student.status != PaymentStatus.accept) {
                                  Navigator.pushNamed(context, AppPaths.paymentDetail, arguments: PaymentDetailPageRouteArguments(student: _student));
                                }
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
