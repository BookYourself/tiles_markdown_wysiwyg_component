// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tiles_markdown_wysiwyg.example;

import 'package:tiles_markdown_wysiwyg/tiles_markdown_wysiwyg.dart';
import 'package:tiles/tiles_browser.dart';
import 'dart:html';
import 'package:tiles_markdown_wysiwyg/tiles_markdown_wysiwyg_browser.dart';
import 'package:tiles/tiles.dart';

main() {
  initTilesBrowserConfiguration();
  initBrowserMarkdownWYSIWYG();

  Element mountRoot = querySelector("#container");
  TextAreaElement result = querySelector("#result");
  
  mountComponent(markdownEditor(children: "# title", listeners: {
    "onChange": (MarkdownEditor component, Event event) {
      TextAreaElement textarea = getElementForComponent(component.textareaComponent);
      result.value = textarea.value;
    }
  }), mountRoot);
}
