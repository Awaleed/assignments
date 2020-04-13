import 'package:assignments/features/assignments/data/repositories/assignments_repository_impl.dart';
import 'package:assignments/features/assignments/domain/repositories/assignments_repository.dart';
import 'package:assignments/features/assignments/presentation/bloc/assignment_bloc/assignment_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void injecte() {
  kiwi.Container container = kiwi.Container();

  container.registerSingleton((c) => AssignmentsBloc());
  container.registerInstance<AssignmentsRepository, AssignmentsRepositoryImpl>(
    AssignmentsRepositoryImpl(),
  );
}
