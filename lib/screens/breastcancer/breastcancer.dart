import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../models/articlemodel.dart';
import '../../providers/breastcancerprovider.dart';
import '../../utils/exception_hander.dart';
import '../../widget/emptywidget.dart';
import '../../widget/errorwidget.dart';

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
                svgAsset: 'assets/images/doctor.svg',
                message: 'No Article Found!',
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<BreastCancerProvider>().refresh(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      var articlesdata = articles[index];
                      return responsiveArticleTile(
                        article: articlesdata,
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget responsiveArticleTile({required ArticleModel article}) {
    return Card(
      child: ExpansionTile(
        trailing: const SizedBox(),
        textColor: Colors.white,
        collapsedTextColor: Colors.white,
        title: Text(
          article.articleTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final textWidth = constraints.maxWidth * 0.7;
              final imageWidth = constraints.maxWidth * 0.3;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        article.articleDescription,
                        softWrap: true,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    article.articleImage != null
                        ? SizedBox(
                            width: imageWidth,
                            child: ClipRRect(
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
                                        children: const [
                                          Icon(Icons.error_outline),
                                          Text('Unable to Load Image'),
                                        ],
                                      ),
                                    );
                                  }

                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
