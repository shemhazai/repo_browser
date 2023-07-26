import 'package:flutter/material.dart';
import 'package:repo_browser/app/assets/app_images.dart';
import 'package:repo_browser/app/common/theming/dimens.dart';
import 'package:repo_browser/app/pages/repository/repository_page.dart';
import 'package:repo_browser/model/git/entity/repository.dart';

/// A tile with repository details.
class RepositoryWidget extends StatelessWidget {
  final Repository repository;
  final VoidCallback? onPressed;

  const RepositoryWidget({
    super.key,
    required this.repository,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const Color foregroundColor = Colors.white;
    return GestureDetector(
      onTap: onPressed,
      child: Card(
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
                  tag: RepositoryPage.buildImageTag(repository.id.toString()),
                  child: Image.network(
                    repository.owner.avatarUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                right: 20,
                child: Hero(
                  tag: RepositoryPage.buildTitleTag(repository.id.toString()),
                  child: Text(
                    repository.owner.login + '/' + repository.name,
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
      ),
    );
  }
}
