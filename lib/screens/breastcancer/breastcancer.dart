import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../const/consts.dart';
import '../../models/articlemodel.dart';
import '../../providers/breastcancerprovider.dart';
import '../../providers/languageprovider.dart';
import '../../utils/exception_hander.dart';
import '../../widget/emptywidget.dart';
import '../../widget/errorwidget.dart';
import '../../widget/shimmerwidget.dart';

class BreastCancerPage extends StatelessWidget {
  const BreastCancerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: FutureBuilder<List<ArticleModel>>(
        future: context.watch<BreastCancerProvider>().articlesList(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<ArticleModel> articles = snapshot.data!;

            if (articles.isEmpty) {
              return EmptyWidget(
                onRefresh: () => context.read<BreastCancerProvider>().refresh(),
                viewPadding: viewPadding,
                size: size,
                svgAsset: 'assets/images/empty.svg',
                message: AppLocalizations.of(context)!.noarticlefound,
              );
            }

            return RefreshIndicator(
              color: Theme.of(context).primaryColor,
              onRefresh: () => context.read<BreastCancerProvider>().refresh(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      var articlesdata = articles[index];
                      return responsiveArticleTile(
                        article: articlesdata,
                        locale: context.watch<LanguageProvider>().languageCode,
                      );
                    },
                  ),
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            var error = snapshot.error as ErrorModel;

            return CustomErrorWidget(
              onRefresh: () => context.read<BreastCancerProvider>().refresh(),
              svgAsset: error.url,
              message: error.message,
              size: size,
              viewPadding: viewPadding,
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ShimmerWidget(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Consts.DefaultBorderRadius),
                        ),
                        child: Stack(
                          children: [
                            ExpansionTile(
                              title: Text('Item $index'),
                            ),
                          ],
                        ),
                      ),
                    )),
          );
        },
      ),
    );
  }

  Widget responsiveArticleTile(
      {required ArticleModel article, required String locale}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      ),
      child: ExpansionTile(
        trailing: const SizedBox(),
        textColor: Colors.white,
        collapsedTextColor: Colors.white,
        title: Text(
          article.articleTitle[locale]!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // final textWidth = constraints.maxWidth * 0.7;
              // final imageWidth = constraints.maxWidth * 0.3;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          // Text(
                          //   article.articleDescription,
                          //   softWrap: true,
                          //   style: const TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 18,
                          //   ),
                          // ),
                          boldMarkedLine(article.articleDescription[locale]),
                          const SizedBox(height: 16),
                          article.articleImage != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Consts.DefaultBorderRadius),
                                  child: FutureBuilder(
                                    future: context
                                        .watch<BreastCancerProvider>()
                                        .getArticleImage(article.articleImage!),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Uint8List?> snapshot) {
                                      if (snapshot.connectionState ==
                                              ConnectionState.done &&
                                          snapshot.hasData) {
                                        return Image.memory(
                                          snapshot.data!,
                                          fit: BoxFit.fill,
                                        );
                                      }

                                      if (snapshot.hasError) {
                                        return SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.error_outline),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .unabletoloadImage,
                                              ),
                                            ],
                                          ),
                                        );
                                      }

                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget boldMarkedLine(String text) {
    List<String> parts = text.split('**');
    List<TextSpan> spans = [];

    for (int i = 0; i < parts.length; i++) {
      if (i % 2 == 0) {
        spans.add(TextSpan(text: parts[i]));
      } else {
        spans.add(TextSpan(
            text: parts[i],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              // fontSize: 18,
            )));
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      style: const TextStyle(
        color: Colors.white,
        // fontSize: 18,
      ),
    );
  }
}
