import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/edit_project/edit_project.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:iot_api/iot_api.dart';
import 'package:user_repository/user_repository.dart';

class EditProjectPage extends StatelessWidget {
  const EditProjectPage({super.key});

  static Route route({
    required Map<FieldId, Project> projectView,
    required Project? initProject,
  }) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
        create: (_) => EditProjectBloc(
          repository: context.read<UserRepository>(),
          projectView: projectView,
          initProject: initProject,
        )..add(const EditProjectInitialized()),
        child: const EditProjectPage(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0, 1);
        const end = Offset.zero;
        const curve = Curves.ease;
        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProjectBloc, EditProjectState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.pop(context);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              MySnackBar.showSnackBar(
                context: context,
                content: 'Saving not success',
                snackBarType: SnackBarType.error,
              ),
            );
          context.read<EditProjectBloc>().add(
                const EditProjectStatusChanged(EditProjectStatus.initialized),
              );
        }
      },
      child: const EditProjectView(),
    );
  }
}

class EditProjectView extends StatelessWidget {
  const EditProjectView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditProjectBloc>().state;
    final status = state.status;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: MyBottomAppbar(
        prefixIcon: Assets.icons.leftButton,
        prefixOnTapped: () async {
          if (state.isEdited) {
            final navigator = Navigator.of(context);
            final value = await showDialog<bool>(
                  context: context,
                  builder: (context) => const MyConfirmDialog(),
                ) ??
                false;
            if (value) navigator.pop();
          } else {
            Navigator.pop(context);
          }
        },
        postfixIcon: Assets.icons.faq,
        postfixOnTapped: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: MyFloatingButton(
        icon: Assets.icons.save,
        onPressed: () {
          if (!status.isSaving) {
            if (state.isFilled()) {
              context.read<EditProjectBloc>().add(const EditProjectSubmitted());
            } else {
              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(
                  MySnackBar.showSnackBar(
                    context: context,
                    content: state.initProject == null
                        ? 'Some fields are empty'
                        : 'No field has edited',
                    snackBarType: SnackBarType.error,
                  ),
                );
            }
          }
        },
      ),
      body: BlocBuilder<EditProjectBloc, EditProjectState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (status.isInitializing) {
            return const MyCircularProgress(size: 24);
          }
          return WillPopScope(
            onWillPop: () async {
              if (state.isEdited) {
                final value = await showDialog<bool>(
                      context: context,
                      builder: (context) => const MyConfirmDialog(),
                    ) ??
                    false;
                return value;
              }
              return true;
            },
            child: CupertinoScrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Space.contentPaddingTop.value +
                        MediaQuery.of(context).viewPadding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _Headline(),
                      SizedBox(height: Space.contentItemGap.value),
                      const NameField(),
                      SizedBox(height: Space.contentItemGap.value),
                      const KeyField(),
                      SizedBox(height: Space.contentItemGap.value),
                      const DescriptionField(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EditProjectBloc>().state;
    final initProject = state.initProject;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Space.contentPaddingHorizontal.value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            initProject == null ? 'Add project' : 'Edit project',
            style: textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
