# tiles_markdown_wysiwyg

The simple tiles component with wysiwyg TinyMCE automaticaly converting rich text to markdown into it's own textarea

## Usage

A simple usage example:

    initBrowserMarkdownWYSIWYG(); // to load browser part of the library
  
    Element mountRoot = querySelector("#container");
    TextAreaElement result = querySelector("#result");
    
    mountComponent(markdownEditor(children: "# title", listeners: {
      "onChange": (MarkdownEditor component, Event event) {
        TextAreaElement textarea = getElementForComponent(component.textareaComponent);
        result.value = textarea.value;
      }
    }), mountRoot);
     querySelector("#container");
    TextAreaElement result = querySelector("#result");
    
    mountComponent(markdownEditor(children: "# title", listeners: {
      "onChange": (MarkdownEditor component, Event event) {
        TextAreaElement textarea = getElementForComponent(component.textareaComponent);
        result.value = textarea.value;
      }
    }), mountRoot);

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/jakuub/tiles_markdown_wysiwyg_component/issues
