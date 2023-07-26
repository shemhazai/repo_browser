import 'package:flutter/material.dart';
import 'package:repo_browser/app/assets/app_images.dart';
import 'package:repo_browser/app/common/theming/dimens.dart';
import 'package:repo_browser/app/pages/repository/repository_page.dart';
import 'package:repo_browser/model/git/entity/issue.dart';

/// A tile which displays issue details.
class IssueWidget extends StatelessWidget {
  final Issue issue;
  final EdgeInsets padding;

  const IssueWidget({
    super.key,
    required this.issue,
    this.padding = const EdgeInsets.only(bottom: 12),
  });

  @override
  Widget build(BuildContext context) {
    const Color foregroundColor = Colors.white;
    return Card(
      margin: Insets.tiny,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: RepositoryPage.buildImageTag(issue.id.toString()),
                child: Image.network(
                  issue.user.avatarUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Hero(
                tag: RepositoryPage.buildTitleTag(issue.id.toString()),
                child: Text(
                  issue.title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: foregroundColor),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Image.asset(
                AppImages.icChevronRight24,
                width: 24,
                height: 24,
                color: foregroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
