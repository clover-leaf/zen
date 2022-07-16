import 'package:flutter/material.dart';
import 'package:flutter_firestore/common/common.dart';
import 'package:flutter_firestore/project/view/project_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_api/iot_api.dart';

class ProjectBox extends StatelessWidget {
  const ProjectBox({
    super.key,
    required this.boxSize,
    required this.project,
  });

  final double boxSize;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.push<void>(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => ProjectPage(project: project),
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 250),
        ),
      ),
      child: Container(
        height: boxSize,
        width: boxSize,
        color: Theme.of(context).backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                SvgIcon.gasStation.getPath(),
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              project.projectName,
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              project.city,
              style: Theme.of(context).textTheme.headline2,
            )
          ],
        ),
      ),
    );
  }
}
