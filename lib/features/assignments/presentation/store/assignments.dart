import 'package:assignments/features/assignments/domain/entities/class_entity.dart';
import 'package:assignments/features/assignments/domain/repositories/assignments_repository.dart';
import 'package:assignments/features/assignments/domain/usecases/assignment_usecase.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:mobx/mobx.dart';

part 'assignments.g.dart';

// enum VisibilityFilter { all, pending, completed }

class ClassList extends _ClassList with _$ClassList {}

abstract class _ClassList with Store {
  AssignmentUseCases useCases = AssignmentUseCases(
    kiwi.Container().resolve<AssignmentsRepository>(),
  );

  @observable
  ObservableList<ClassEntity> classes = ObservableList<ClassEntity>();

  // @observable
  // VisibilityFilter filter = VisibilityFilter.all;

  // @observable
  // String currentDescription = '';

  // @computed
  // ObservableList<Todo> get pendingTodos =>
  //     ObservableList.of(todos.where((todo) => todo.done != true));

  // @computed
  // ObservableList<Todo> get completedTodos =>
  //     ObservableList.of(todos.where((todo) => todo.done == true));

  // @computed
  // bool get hasCompletedTodos => completedTodos.isNotEmpty;

  // @computed
  // bool get hasPendingTodos => pendingTodos.isNotEmpty;

  // @computed
  // String get itemsDescription {
  //   if (todos.isEmpty) {
  //     return "There are no Todos here. Why don't you add one?.";
  //   }

  //   final suffix = pendingTodos.length == 1 ? 'todo' : 'todos';
  //   return '${pendingTodos.length} pending $suffix, ${completedTodos.length} completed';
  // }

  // @computed
  // ObservableList<Todo> get visibleTodos {
  //   switch (filter) {
  //     case VisibilityFilter.pending:
  //       return pendingTodos;
  //     case VisibilityFilter.completed:
  //       return completedTodos;
  //     default:
  //       return todos;
  //   }
  // }

  // @computed
  // bool get canRemoveAllCompleted =>
  //     hasCompletedTodos && filter != VisibilityFilter.pending;

  // @computed
  // bool get canMarkAllCompleted =>
  //     hasPendingTodos && filter != VisibilityFilter.completed;

  @action
  void addClass(ClassEntity entity) {
    classes.add(entity);
  }

  // @action
  // void removeTodo(Todo todo) {
  //   todos.removeWhere((x) => x == todo);
  // }

  // @action
  // void removeCompleted() {
  //   todos.removeWhere((todo) => todo.done);
  // }

  // @action
  // void markAllAsCompleted() {
  //   for (final todo in todos) {
  //     todo.done = true;
  //   }
  // }
}
