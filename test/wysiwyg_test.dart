// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
@TestOn("dartium")
library tiles_markdown_wysiwyg.browser_test;

import 'package:test/test.dart';

import 'package:tiles_markdown_wysiwyg/tiles_markdown_wysiwyg_browser.dart';
import 'package:tiles/tiles_browser.dart';
import 'dart:html';
import 'dart:async';
import 'package:tiles/tiles.dart';

void main() {
  group('(Tiles Markdown WYSIWYG)', () {
    final num countOfScripts = querySelectorAll("script").length;
    Element mountRoot;
    initBrowserMarkdownWYSIWYG();
    List events;
    List components;

    catchEvent(component, event) {
      events.add(event);
      components.add(component);
    }

    setUp(() {
      mountRoot = new DivElement();
      querySelector("body").append(mountRoot);
      events = [];
      components = [];
      mountComponent(
          markdownEditor(children: "", listeners: {"onChange": catchEvent}),
          mountRoot);
    });

    test("should load js", () {
      expect(querySelectorAll("script").length, greaterThan(countOfScripts));
    });
    
    test("should load based on packages url in props", () {
      unmountComponent(mountRoot);
      mountComponent(
          markdownEditor(children: "", props: {
            PACKAGES_URL: "somepackagesurl124"
          }),
          mountRoot);
      expect(querySelectorAll("script[src*='somepackagesurl124']").length, greaterThan(0));
    });

    test("should init tinymce", () {
      new Future.delayed(new Duration(seconds: 1), () => null).then(
          expectAsync((_) {
        expect(mountRoot.children.last.children.first.classes
            .contains("mce-container"), isTrue);
      }));
    });

    test("should not bubble change event from div", () {
      Element element = mountRoot.children.first.children.first;
      element.click();
      element.innerHtml = "edited";
      Event customEvent = new Event("change");

      window.animationFrame.then(expectAsync((_) {
        expect(events, isNot(isEmpty));
        Event event = events.first;
        expect(event.target, isNot(equals(element)));
        expect(event.target is TextAreaElement, isTrue);
      }));

      element.dispatchEvent(customEvent);
    });

    test("should convert html to markdown", () {
      Element element = mountRoot.children.first.children.first;
      element.click();
      element.innerHtml = "<h1>edited</h1>";
      Event customEvent = new Event("change");

      window.animationFrame.then(expectAsync((_) {
        TextAreaElement textarea = events.first.target;

        expect(textarea.value, isNot(contains("h1")));
        expect(textarea.value, contains("# "));
      }));

      element.dispatchEvent(customEvent);
    });

    test("should accept content in markdown in children", () {
      unmountComponent(mountRoot);
      mountComponent(markdownEditor(
              children: "# test\ntestik", listeners: {"onChange": catchEvent}, props: {INLINE: true}),
          mountRoot);

      expect(mountRoot.query("div.wysiwyg").text, contains("test"));
      expect(mountRoot.query("div.wysiwyg").innerHtml, contains("<h1>"));
    });

    test("should have possibility to change inline in props", () {
      unmountComponent(mountRoot);
      mountComponent(markdownEditor(
          children: "# test\ntestik",
          listeners: {"onChange": catchEvent},
          props: {INLINE: true}), mountRoot);

      new Future.delayed(new Duration(seconds: 1), () => null).then(
          expectAsync((_) {
        expect(mountRoot.children.last.children.first.classes
            .contains("mce-content-body"), isTrue);
      }));
    });
    
    
    // TODO tests for contents in inline and not inline mode
  });
}
