// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library tiles_markdown_wysiwyg.example;

import 'package:tiles_markdown_wysiwyg/tiles_markdown_wysiwyg.dart';
import 'package:tiles/tiles_browser.dart';
import 'dart:html';
import 'package:tiles_markdown_wysiwyg/tiles_markdown_wysiwyg_browser.dart';
import 'package:tiles_markdown_wysiwyg/custom_markdown.dart';
import 'package:tiles/tiles.dart';

main() {
  initTilesBrowserConfiguration();
  initBrowserMarkdownWYSIWYG();

  Element mountRoot = querySelector("#container");
  TextAreaElement result = querySelector("#result");
  DivElement resultCompiled = querySelector("#result-compiled");
  
  mountComponent(markdownEditor(children: "# title", listeners: {
    "onChange": (MarkdownEditor component, Event event) {
      TextAreaElement textarea = getElementForComponent(component.textareaComponent);
      result.value = textarea.value;
      print(md(result.value));
      
      final NodeValidatorBuilder _htmlValidator=new NodeValidatorBuilder.common()
          ..allowElement('a', attributes: ['data-target', 'data-toggle', 'href'])
          ..allowElement('img', attributes: ['src'])
        ..allowElement('button', attributes: ['data-target', 'data-toggle']);

      resultCompiled.setInnerHtml(md(result.value), validator: _htmlValidator);
    }
  }), mountRoot);


  Element mountRootInline = querySelector("#container-inline");
  TextAreaElement resultInline = querySelector("#result-inline");
  
  mountComponent(markdownEditor(children: "# title", listeners: {
    "onChange": (MarkdownEditor component, Event event) {
      TextAreaElement textarea = getElementForComponent(component.textareaComponent);
      resultInline.value = textarea.value;
    }
  }, props: {INLINE: true}), mountRootInline);
}
