library tiles_markdown_wysiwyg.custom_markdown;

import 'package:markdown/markdown.dart';

md(String markdown) => markdownToHtml(markdown, inlineSyntaxes: _syntaxes);

get _syntaxes => [_numberBackslashDot];

get _numberBackslashDot => new TextSyntax('(\\\\)(\\.)', sub: '.');