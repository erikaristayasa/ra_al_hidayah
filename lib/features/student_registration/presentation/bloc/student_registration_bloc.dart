import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/usecases/do_student_registration.dart';

part 'student_registration_event.dart';
part 'student_registration_state.dart';

class StudentRegistrationBloc extends Bloc<StudentRegistrationEvent, StudentRegistrationState> {
  final DoStudentRegistration doStudentRegistration;
  StudentRegistrationBloc({required this.doStudentRegistration}) : super(StudentRegistrationInitial()) {
    on<Submit>((event, emit) async {
      emit(StudentRegistrationLoading());

      // await Future.delayed(const Duration(seconds: 2));
      // emit(StudentRegistrationSuccess());
      // return;

      final result = await doStudentRegistration(
        registrationPeriodId: event.registrationPeriodId,
        studentId: event.studentId,
        type: event.type,
        name: event.name,
        gender: event.gender,
        birthPlace: event.birthPlace,
        birthDate: event.birthDate,
        nik: event.nik,
        religion: event.religion,
        childNumber: event.childNumber,
        fatherName: event.fatherName,
        motherName: event.motherName,
        parentJob: event.parentJob,
        address: event.address,
        phone: event.phone,
        birthDocumentFile: event.birthDocumentFile,
        registrationFormFile: event.registrationFormFile,
        availabilityFile: event.availabilityFile,
        profOfPaymentFile: event.profOfPaymentFile,
      );
      result.fold(
        (failure) => emit(StudentRegistrationFailure(failure: failure)),
        (_) => emit(StudentRegistrationSuccess()),
      );
    });
  }
}
