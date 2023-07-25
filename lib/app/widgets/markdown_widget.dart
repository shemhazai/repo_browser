import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

typedef OnTapRepository = void Function(String repositoryId);

/// Renders the markdown text.
class RepositoryMarkdown extends StatelessWidget {
  final String body;
  final OnTapRepository? onTapRepository;

  const RepositoryMarkdown({
    super.key,
    required this.body,
    this.onTapRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: body,
      onTapLink: (String text, String? href, String title) {
        final String? repositoryId = _parseRepositoryId(href);
        if (repositoryId != null) {
          onTapRepository?.call(repositoryId);
        }
      },
      styleSheet: MarkdownStyleSheet(
        p: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  String? _parseRepositoryId(String? href) {
    if (href == null) return null;

    final int index = href.indexOf(RegExp(':'));
    if (index < 0) return null;
    return href.substring(index + 1);
  }
}
