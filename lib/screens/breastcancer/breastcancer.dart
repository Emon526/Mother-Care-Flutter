import 'package:flutter/material.dart';

import '../../models/articlemodel.dart';

class BreastCancerPage extends StatelessWidget {
  const BreastCancerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => responsiveArticleTile(
          article: ArticleModel(
            articleId: 1,
            articleTitle: 'What Is Breast Cancer?',
            articleDescription:
                'Breast cancer is a disease in which cells in the breast grow out of control. There are different kinds of breast cancer. The kind of breast cancer depends on which cells in the breast turn into cancer.Breast cancer can begin in different parts of the breast. A breast is made up of three main parts: lobules, ducts, and connective tissue. The lobules are the glands that produce milk. The ducts are tubes that carry milk to the nipple. The connective tissue (which consists of fibrous and fatty tissue) surrounds and holds everything together. Most breast cancers begin in the ducts or lobules.Breast cancer can spread outside the breast through blood vessels and lymph vessels. When breast cancer spreads to other parts of the body, it is said to have metastasized.',
            articleImage: 'assets/images/breast_cancer_image.jpg',
          ),
        ),
      ),
    );
  }

  Widget responsiveArticleTile({required ArticleModel article}) {
    return Card(
      child: ExpansionTile(
        trailing: const SizedBox(),
        textColor: Colors.white,
        collapsedTextColor: Colors.white,
        title: Text(article.articleTitle),
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
                    SizedBox(
                      width: imageWidth,
                      child: Image.asset(
                        article.articleImage,
                        fit: BoxFit.cover,
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
}
