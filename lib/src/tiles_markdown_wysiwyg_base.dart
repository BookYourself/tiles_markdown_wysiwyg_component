// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library tiles_markdown_wysiwyg.base;

import 'package:tiles/tiles.dart';
import '../tiles_markdown_wysiwyg.dart';
import 'dart:math';
import 'package:markdown/markdown.dart';
import 'package:tiles_markdown_wysiwyg/custom_markdown.dart';

class MarkdownEditor extends Component {
  Map get props => super.props;
  final String id;
  Component textareaComponent;
  MarkdownEditor(Map props, children)
      : id = _randomId(),
        super(props, children);

  render() => div(children: _children);

  List<ComponentDescription> get _children {
    var generator = div;
    if (!_inline) {
      generator = textarea;
    }
    return [
      generator(
          props: {
        "dangerouslySetInnerHTML": _markdown(),
        "class": "wysiwyg",
        "id": id
      },
          listeners: {"onChange": _wysiwygChange}),
      textarea(
          props: {
        "style": "display: none",
        "ref": (Component comp) => textareaComponent = comp
      })
    ];
  }

  _wysiwygChange(_, event) {
    convertHtmlToMarkdown(event, textareaComponent);
    return false;
  }

  @override
  didMount() {
    load([
      "${_packagesUrl}packages/tiles_markdown_wysiwyg/js/tinymce/js/tinymce/tinymce.min.js",
      "${_packagesUrl}packages/tiles_markdown_wysiwyg/js/md.min.js"
    ]).then((_) {
      initWYSIWIG(id, events, _inline);
    });
  }

  _markdown() {
    if (children != null) {
      return md(children.first.props);
    }
    return null;
  }

  bool get _inline {
    if (props is Map && props[INLINE] == true) {
      return true;
    }
    return false;
  }

  List get events {
    if (props is Map && props.containsKey(EVENTS)) {
      return props[EVENTS];
    }
    return ["change"];
  }

  String get _packagesUrl {
    if (props is Map && props.containsKey(PACKAGES_URL)) {
      return props[PACKAGES_URL];
    }
    return "";
  }

}

ComponentDescriptionFactory markdownEditor = registerComponent(
    ({props, children}) => new MarkdownEditor(props, children));

_randomId() => "MarkdownEditor_${_random.nextInt(_randomRoof)}";

Random _random = new Random();
const num _randomRoof = 10000;

const String INLINE = "inline";
const String PACKAGES_URL = "packages_url";
const String EVENTS = "events";
