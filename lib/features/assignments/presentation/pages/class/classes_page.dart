import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../../../../core/routes/router.gr.dart';
import '../../../domain/entities/class_entity.dart';
import '../../bloc/assignment_bloc/assignment_bloc.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({Key key}) : super(key: key);
  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  AssignmentsBloc _assignmentsBloc;

  @override
  void initState() {
    super.initState();
    _assignmentsBloc = kiwi.Container().resolve<AssignmentsBloc>();
    _assignmentsBloc..add(AssignmentsEvent.getData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
      ),
      body: BlocBuilder<AssignmentsBloc, AssignmentsState>(
        builder: (context, state) {
          return state.when(
            loading: () => Center(child: CircularProgressIndicator()),
            loaded: (classList) => _buildClassesList(classList),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _onAddClass(),
      ),
    );
  }

  Widget _buildClassesList(List<ClassEntity> classList) {
    if (classList.isEmpty) {
      return Center(
        child: Text('Add New Class'),
      );
    }

    return ListView.separated(
      itemCount: classList.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        final classEntity = classList[index];

        return ListTile(
          onTap: () => _onShowClassDetails(classEntity),
          title: Text(classEntity.name),
          leading: CircleAvatar(
            backgroundColor: classEntity.color,
          ),
        );
      },
    );
  }

  _onAddClass() async {
    final newClass = await Router.navigator.pushNamed(Routes.classDialog);
    if (newClass != null) {
      _assignmentsBloc.add(AssignmentsEvent.addClass(newClass));
    }
  }

  _onDeleteClass(ClassEntity deletedClass) async {
    _assignmentsBloc.add(AssignmentsEvent.deleteClass(deletedClass));
  }

  _onEditClass(ClassEntity entity) async {
    final updatedClass = await Router.navigator.pushNamed(
      Routes.classDialog,
      arguments: ClassDialogArguments(
        classEntity: entity,
      ),
    );
    _assignmentsBloc.add(AssignmentsEvent.updateClass(updatedClass));
    _onShowClassDetails(updatedClass);
  }

  _onShowClassDetails(ClassEntity classEntity) async {
    Router.navigator.pushNamed(
      Routes.classDetails,
      arguments: ClassDetailsArguments(
        entity: classEntity,
        onDelete: _onDeleteClass,
        onEdit: _onEditClass,
      ),
    );
  }
}
