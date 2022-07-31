import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/constants/constants.dart';
import 'package:flutter_firestore/common/widgets/widgets.dart';
import 'package:flutter_firestore/gen/assets.gen.dart';
import 'package:flutter_firestore/projects_overview/view/projects_overview_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class MenuSheet extends StatelessWidget {
  const MenuSheet({
    super.key,
    required this.projects,
    required this.projectView,
    required this.deviceView,
  });

  final Map<FieldId, Project> projectView;
  final Map<FieldId, Device> deviceView;
  final List<Project> projects;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        32 + MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffffffff),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: projects.length * 64,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];
                return MyElevatedButton(
                  onPressed: () => Navigator.of(context).pop(project.id),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            height: 48,
                            width: 48,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Color(0xff212121),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              project.name[0].toUpperCase(),
                              style: textTheme.titleMedium!
                                  .copyWith(color: const Color(0xffffffff)),
                            ),
                          ),
                        ),
                        Text(
                          project.name,
                          style: textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          MyOutlineButton(
            content: 'Manager projects',
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            onPressed: () => Navigator.of(context)
                .push<void>(
                  ProjectsOverviewPage.route(),
                )
                .then((value) => Navigator.of(context).pop()),
          ),
          Divider(
            height: 24,
            thickness: Space.globalBorderWidth.value,
          ),
          _MenuOptionBox(
            title: 'Setting',
            icon: Assets.icons.settings,
          ),
           _MenuOptionBox(
            title: 'Dark mode',
            icon: Assets.icons.night,
          )
        ],
      ),
    );
  }
}

class _MenuOptionBox extends StatelessWidget {
  const _MenuOptionBox({
    required this.title,
    required this.icon,
  });

  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: SvgPicture.asset(
              icon,
              color: const Color(0xff212121),
            ),
          ),
          Text(
            title,
            style: textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}
