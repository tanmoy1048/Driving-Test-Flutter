import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:provider/provider.dart';

import '../../common/font_viewmodel.dart';
import '../../common/function/alert_dialog.dart';
import '../../common/widgets/banner_ads.dart';
import '../../common/widgets/swipe_demo.dart';
import '../../service/shared_pref_service.dart';
import '../main/main_viewmodel.dart';
import 'chapter_viewmodel.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage(
      {super.key,
      required this.storyIndex,
      required this.currentChapterIndex,
      required this.title});
  final int storyIndex;
  final int currentChapterIndex;
  final String title;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late int index;
  late AnimationController _controller;
  late Animation<double> _animation;

  bool showFirstTimeUi = false;

  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    index = widget.currentChapterIndex;
    _pageViewController =
        PageController(initialPage: (widget.currentChapterIndex));

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.repeat(reverse: true);

    SharedPrefService().showFirstTimeUiVolume().then((value) {
      if (value) {
        if (mounted) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              showFirstTimeUi = true;
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              showMyDialog(
                  context: context,
                  title: const Text("Font Size"),
                  body:
                      Consumer<FontSizeViewModel>(builder: (context, font, c) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton(
                          disabledElevation: 0,
                          child: const Icon(Icons.remove),
                          onPressed: font.fontSize <= 10
                              ? null
                              : () {
                                  if (font.fontSize > 10) {
                                    font.setFontData(font.fontSize - 2);
                                  }
                                },
                        ),
                        Text(font.fontSize.toString()),
                        FloatingActionButton(
                          disabledElevation: 0,
                          child: const Icon(Icons.add),
                          onPressed: font.fontSize >= 30
                              ? null
                              : () {
                                  if (font.fontSize < 30) {
                                    font.setFontData(font.fontSize + 2);
                                  }
                                },
                        ),
                      ],
                    );
                  }));
            },
            icon: const Icon(Icons.format_size),
          ),
          Consumer<MainViewModel>(builder: (context, viewModel, c) {
            return IconButton(
              onPressed: () {
                if (context
                        .read<ChapterViewModel>()
                        .chapterList[widget.storyIndex]
                        .contents[index]
                        .pageNum ==
                    viewModel.names[widget.storyIndex].openPage) {
                  // todo: remove to bookmark
                  showMyDialog(
                      context: context,
                      title: const Text("Remove Bookmark"),
                      body: Text('Are you want to remove this bookmark?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              viewModel
                                  .bookmarkAction(
                                      bookmarkId: 0,
                                      id: viewModel.names[widget.storyIndex].id,
                                      index: widget.storyIndex)
                                  .then((value) => Navigator.of(context).pop());
                            },
                            child: Text("Remove")),
                      ]);
                } else if (viewModel.names[widget.storyIndex].openPage ==
                        null ||
                    viewModel.names[widget.storyIndex].openPage! <= 0) {
// todo: add to bookmark
                  viewModel.bookmarkAction(
                      bookmarkId: context
                          .read<ChapterViewModel>()
                          .chapterList[widget.storyIndex]
                          .contents[index]
                          .pageNum,
                      id: viewModel.names[widget.storyIndex].id,
                      index: widget.storyIndex);
                } else if (context
                            .read<ChapterViewModel>()
                            .chapterList[widget.storyIndex]
                            .contents[index]
                            .pageNum !=
                        viewModel.names[widget.storyIndex].openPage &&
                    viewModel.names[widget.storyIndex].openPage! >= 0) {
                  // todo: replace to bookmark
                  showMyDialog(
                      context: context,
                      title: const Text("Replace Bookmark"),
                      body: Text('Are you want to replace with this bookmark?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel")),
                        TextButton(
                            onPressed: () {
                              viewModel
                                  .bookmarkAction(
                                      bookmarkId: context
                                          .read<ChapterViewModel>()
                                          .chapterList[widget.storyIndex]
                                          .contents[index]
                                          .pageNum,
                                      id: viewModel.names[widget.storyIndex].id,
                                      index: widget.storyIndex)
                                  .then((value) => Navigator.of(context).pop());
                            },
                            child: Text("Replace")),
                      ]);
                }
              },
              icon: context
                          .read<ChapterViewModel>()
                          .chapterList[widget.storyIndex]
                          .contents[index]
                          .pageNum ==
                      viewModel.names[widget.storyIndex].openPage
                  ? const Icon(
                      Icons.bookmark,
                      color: Colors.red,
                    )
                  : const Icon(Icons.bookmark_add_outlined),
            );
          }),
        ],
      ),
      body: Consumer<ChapterViewModel>(builder: (context, viewModel, child) {
        return FutureBuilder(
            future: viewModel.isInitCompleted,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  child:
                      Consumer<FontSizeViewModel>(builder: (context, font, c) {
                    return Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          " ${viewModel.chapterList[widget.storyIndex].contents[index].pageNum}/${viewModel.chapterList[widget.storyIndex].contents.length}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(),
                        ),
                        BannerAds(),
                        Flexible(
                          child: Stack(
                            children: [
                              PageView.builder(
                                  controller: _pageViewController,
                                  itemCount: viewModel
                                      .chapterList[widget.storyIndex]
                                      .contents
                                      .length,
                                  onPageChanged: (page) {
                                    setState(() {
                                      index = page;
                                    });
                                  },
                                  itemBuilder: (context, page) {
                                    return Container(
                                      margin: EdgeInsets.all(8),
                                      child: Card(
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    viewModel
                                                        .chapterList[
                                                            widget.storyIndex]
                                                        .contents[page]
                                                        .content
                                                        .replaceAll(
                                                            RegExp(r'\\'), ''),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                            fontSize:
                                                                font.fontSize),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              if (showFirstTimeUi)
                                firstTimeSwipeDemo(
                                    context: context,
                                    animation: _animation,
                                    hint:
                                        "Swipe left or right\nto move between Volumes.",
                                    onTap: () {
                                      SharedPrefService()
                                          .setFirstTimeUiVolume(false);
                                      setState(() {
                                        showFirstTimeUi = false;
                                      });
                                    }),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            });
      }),
    );
  }
}
