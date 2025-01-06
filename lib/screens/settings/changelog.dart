import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import '../../providers/changelogprovider.dart';

class ChangelogScreen extends StatelessWidget {
  const ChangelogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.changelog),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ChangelogProvider>().refresh(),
        child: context.watch<ChangelogProvider>().isFetching
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Markdown(
                data: context.watch<ChangelogProvider>().changelogContent!,
                styleSheet: MarkdownStyleSheet(
                  h1: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  h2: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    // color: Colors.green,
                  ),
                  h3: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  listBullet: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  a: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  p: TextStyle(
                    fontSize: 16,
                    // color: Colors.amber,
                  ),
                ),
              ),
      ),
    );
  }
}
