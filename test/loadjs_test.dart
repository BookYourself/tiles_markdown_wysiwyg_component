// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@TestOn("dartium")
library tiles_markdown_wysiwyg.browser_test;

import 'package:test/test.dart';

import 'dart:html';
import 'dart:async';
import 'package:tiles_markdown_wysiwyg/loadjs.dart';

void main() {
  group('(Load JS)', () {
    final num countOfScripts = querySelectorAll("script").length;

    test("we should not have script loaded", () {
      expect(querySelectorAll('script[src*="tinymce.min"]').length, equals(0));
    });
    test("should load js", () {
      loadJS(["packages/tiles_markdown_wysiwyg/js/tinymce/js/tinymce/tinymce.min.js"]);
      expect(querySelectorAll('script[src*="tinymce.min"]').length, equals(1));
    });
    
    test("should not load script twice", () {
      loadJS(["packages/tiles_markdown_wysiwyg/js/tinymce/js/tinymce/tinymce.min.js"]);
      loadJS(["packages/tiles_markdown_wysiwyg/js/tinymce/js/tinymce/tinymce.min.js"]);
      loadJS(["packages/tiles_markdown_wysiwyg/js/tinymce/js/tinymce/tinymce.min.js"]);

      expect(querySelectorAll('script[src*="tinymce.min"]').length, equals(1));
    });

  });
}
