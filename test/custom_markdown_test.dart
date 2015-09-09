library tiles_markdown_wysiwyg.custom_markdown.test;

import 'package:tiles_markdown_wysiwyg/custom_markdown.dart';
import 'package:test/test.dart';


main() {
  String text = "ahoj 1\\. ";

  print(md(text));
  group("(Custom markdown)", () {
    test("should fix number-backslash-dot", () {
      expect(md(text), isNot(contains("\\")));
    });
  });
}