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
  Element element = querySelector(".wysiwyg#$id");
  JsObject tinymce = context["tinymce"];
  tinymce.callMethod("init", [_options(id, inline, element)]);
}

JsObject _options(String id, bool inline, Element element) =>
    new JsObject.jsify({
  "selector": ".wysiwyg#$id",
  "inline": inline,
  "toolbar":
      "undo redo | formatselect | bold italic | link image | bullist numlist",
  "menubar": false,
  "setup": _initChangeListener(element),
});

JsFunction _initChangeListener(Element element) => new JsFunction.withThis((_, JsObject editor) {
    editor.callMethod("on", [
      "change",
      (JsObject e) {
        if (element is TextAreaElement) {
          element.value = editor.callMethod("getContent");
        }
        element.dispatchEvent(new Event("change"));
      }
    ]);
  });

_convertHtmlToMarkdown(Event event, Component textareaComponent) {
  Element wrapper = event.target;
  String html = _getContent(wrapper);
  String markdown = context.callMethod("md", [html]);

  Element textarea = getElementForComponent(textareaComponent);
  textarea.text = markdown;
  textarea.dispatchEvent(new Event("change"));
}

String _getContent(Element wrapper) {
  String html;
  if (wrapper is DivElement) {
    html = wrapper.innerHtml;
  } else if (wrapper is TextAreaElement) {
    html = wrapper.value;
  }
  return html;
}
