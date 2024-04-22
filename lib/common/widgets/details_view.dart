// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../Feature/common/fontsize_viewmodel.dart';

// class DetailsView extends StatelessWidget {
//   const DetailsView({super.key, required this.heading, required this.body});

//   final String heading;
//   final String body;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//         child: Padding(
//       padding: const EdgeInsets.all(8),
//       child: Consumer<FontSizeViewModel>(builder: (context, font, c) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               heading,
//               style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                   decoration: TextDecoration.underline,
//                   fontSize: font.fontSize + 2),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               body,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyLarge
//                   ?.copyWith(fontSize: font.fontSize),
//               textAlign: TextAlign.justify,
//             ),
//           ],
//         );
//       }),
//     ));
//   }
// }
