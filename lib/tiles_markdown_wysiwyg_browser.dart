// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// TODO: Put public facing types in this file.

library tiles_markdown_wysiwyg.wysiwyg;
export 'tiles_markdown_wysiwyg.dart';
import 'src/tiles_markdown_wysiwyg_browser_load.dart' as load;
import 'src/tiles_markdown_wysiwyg_browser_wysiwyg.dart' as wysiwyg;

initBrowserMarkdownWYSIWYG() {
  load.initLoad();
  wysiwyg.initWysiwigInit();
}