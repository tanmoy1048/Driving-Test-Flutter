import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../common/widgets/banner_ads.dart';
import '../chapters/details.dart';
import 'home_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battles of Mohammad (pbuh)"),
      ),
      body: Container(
        child: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return FutureBuilder(
              future: viewModel.isInitCompleted,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // BannerAds(),
                      Flexible(
                        child: Scrollbar(
                          thumbVisibility: false,
                          child: ListView.builder(
                              itemCount: viewModel.questions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text("1"),
                                );
                              }),
                          //GridView.extent(
                          //   mainAxisSpacing: 10,
                          //   crossAxisSpacing: 10,
                          //   maxCrossAxisExtent: 200,
                          //   childAspectRatio: 0.8,
                          //   padding: const EdgeInsets.symmetric(
                          //       horizontal: 10, vertical: 10),
                          //   children: viewModel.questions
                          //       .map(
                          //         (e) => Ink(
                          //           child: InkWell(
                          //             onTap: () {
                          //               // Navigator.of(context).push(
                          //               //   MaterialPageRoute(
                          //               //     builder: (_) => DetailsPage(
                          //               //       storyIndex: e.id - 1,
                          //               //       currentChapterIndex:
                          //               //           e.openPage == null ||
                          //               //                   e.openPage == 0
                          //               //               ? 0
                          //               //               : e.openPage! - 1,
                          //               //       title: e.name,
                          //               //     ),
                          //               //   ),
                          //               // );
                          //             },
                          //             child: Container(
                          //               padding: const EdgeInsets.symmetric(
                          //                 horizontal: 24,
                          //               ),
                          //               child: Column(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.center,
                          //                 children: [
                          //                   LayoutBuilder(
                          //                       builder: (context, constrains) {
                          //                     return Stack(
                          //                       children: [
                          //                         Image.asset(
                          //                           "assets/images/${e}.png",
                          //                         ),
                          //                         if (e != null &&
                          //                             e! > 0)
                          //                           Positioned(
                          //                             left: -2,
                          //                             top: -2,
                          //                             width:
                          //                                 constrains.maxWidth /
                          //                                     2,
                          //                             child: Image.asset(
                          //                               "assets/images/bookmark.png",
                          //                             ),
                          //                           )
                          //                       ],
                          //                     );
                          //                   }),
                          //                 ],
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //       .toList(),
                          // ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
