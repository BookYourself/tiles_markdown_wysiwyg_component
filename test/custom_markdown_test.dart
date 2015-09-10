library tiles_markdown_wysiwyg.custom_markdown.test;

import 'package:tiles_markdown_wysiwyg/custom_markdown.dart';
import 'package:test/test.dart';


main() {
  String text = "ahoj 1\\. ";

  group("(Custom markdown)", () {
    test("should fix number-backslash-dot", () {
      expect(md(text), isNot(contains("\\")));
    });
    
    test("should work with external links", () {
      text = '''# title

[www.google.com][0]

[0]: http://www.google.com''';
      expect(md(text), contains("a href"));
    });
  });
}