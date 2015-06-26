// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library tiles_markdown_wysiwyg.wysiwyg;

import '../tiles_markdown_wysiwyg.dart';
import 'dart:js';
import 'dart:html';
import 'package:tiles/tiles.dart';
import 'package:tiles/tiles_browser.dart';

initWysiwigInit() {
  initWYSIWIG = _initWYSIWIG;
  convertHtmlToMarkdown = _convertHtmlToMarkdown;
}

_initWYSIWIG(String id, [bool inline = false]) {
  JsObject tinymce = context["tinymce"];
  tinymce.callMethod("init", [
    new JsObject.jsify({
      "selector": "div.wysiwyg#$id",
      "inline": inline,
      "toolbar": "undo redo | formatselect | bold italic | link image | bullist numlist",
      "menubar": false,
      "plugins": [],
      "setup": new JsFunction.withThis((_, JsObject editor) {
        editor.callMethod("on", ["change", (JsObject e){
          Element element = editor.callMethod("getElement");
          element.dispatchEvent(new Event("change"));
        }]);
      }),
    })
  ]);
}

_convertHtmlToMarkdown(Event event, Component textareaComponent) {
  Element wrapper = event.target; 
  String html = wrapper.innerHtml;
  String markdown = context.callMethod("md", [html]);
  
  Element textarea = getElementForComponent(textareaComponent);
  textarea.text = markdown;
  textarea.dispatchEvent(new Event("change"));
}