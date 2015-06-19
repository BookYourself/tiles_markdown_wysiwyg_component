// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library tiles_markdown_wysiwyg.base;

import 'package:tiles/tiles.dart';
import '../tiles_markdown_wysiwyg.dart';
import 'dart:math';
import 'package:markdown/markdown.dart';

class MarkdownEditor extends Component {
  Map get props => super.props; 
  final String id;
  Component textareaComponent;
  MarkdownEditor(Map props, children)
      : id = _randomId(),
        super(props, children);

  render() => div(
      children: [
    div(
        props: {"dangerouslySetInnerHTML": _markdown(),"class": "wysiwyg", "id": id},
        listeners: {"onChange": _wysiwygChange}),
    textarea(
        props: {
      "style": "display: none",
      "ref": (Component comp) => textareaComponent = comp
    })
  ]);

  _wysiwygChange(_, event) {
    convertHtmlToMarkdown(event, textareaComponent);
    return false;
  }

  @override
  didMount() {
    load([
      "packages/tiles_markdown_wysiwyg/js/tinymce/js/tinymce/tinymce.min.js",
      "packages/tiles_markdown_wysiwyg/js/md.min.js"
    ]).then((_) {
      initWYSIWIG(id);
    });
  }
  
  _markdown() {
    if(children != null) {
      return markdownToHtml(children.first.props);
    }
    return null;
  }
}

ComponentDescriptionFactory markdownEditor =
    registerComponent(({props, children}) => new MarkdownEditor(props, children));

_randomId() => "MarkdownEditor_${_random.nextInt(_randomRoof)}";

Random _random = new Random();
const num _randomRoof = 10000;
