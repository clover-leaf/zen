// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_exam/commom/commom.dart';
// import 'package:flutter_exam/exam_overview/exam_overview.dart';

// class FilterDialog extends StatelessWidget {
//   const FilterDialog({super.key, required this.filter});
//   final ExamOverviewFilter filter;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => FilterDialogBloc(
//         level: filter.levelFilter,
//         password: filter.passwordFilter,
//       ),
//       child: const FilterDialogView(),
//     );
//   }
// }

// class FilterDialogView extends StatelessWidget {
//   const FilterDialogView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final levelFilter =
//         context.select((FilterDialogBloc bloc) => bloc.state.levelFilter);
//     final passwordFilter =
//         context.select((FilterDialogBloc bloc) => bloc.state.passwordFilter);
//     return Dialog(
//       elevation: 0,
//       backgroundColor: const Color(0xFFFFFFFF),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(Constant.globalBorderRadius.value),
//         ),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(Constant.filterDialogPadding.value),
//         height: Constant.filterDialogHeight.value,
//         width: Constant.filterDialogWidth.value,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Filters',
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Color(0xFF242424),
//               ),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Applied Filters',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF242424),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: [
//                 FilterTag(
//                   tag: levelFilter.getName(),
//                   isActive: true,
//                 ),
//                 FilterTag(
//                   tag: passwordFilter.getName(),
//                   isActive: true,
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Button(
//               label: 'Search',
//               onTapped: () => Navigator.of(context).pop(
//                 ExamOverviewFilter(
//                   levelFilter: levelFilter,
//                   passwordFilter: passwordFilter,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Button(
//               label: 'Reset Filters',
//               isPrimary: false,
//               onTapped: () => context
//                   .read<FilterDialogBloc>()
//                   .add(const FilterDialogReseted()),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'JLPT level',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF242424),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: ExamOverviewLevelFilter.values
//                   .map(
//                     (level) => InteractiveFilterTag(
//                       tag: level.getName(),
//                       value: level,
//                       groupValue: levelFilter,
//                       onTapped: () => context
//                           .read<FilterDialogBloc>()
//                           .add(FilterDialogLevelChanged(level)),
//                     ),
//                   )
//                   .toList(),
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             const Text(
//               'Access status',
//               style: TextStyle(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w500,
//                 color: Color(0xFF242424),
//               ),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: ExamOverviewPasswordFilter.values
//                   .map(
//                     (type) => InteractiveFilterTag(
//                       tag: type.getName(),
//                       value: type,
//                       groupValue: passwordFilter,
//                       onTapped: () => context
//                           .read<FilterDialogBloc>()
//                           .add(FilterDialogPasswordChanged(type)),
//                     ),
//                   )
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
