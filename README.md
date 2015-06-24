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
    
## Look and feal

The following screenshot shows all used functionality and typografy used. If there is enough space on page above the edited element, the toolbar is showed above the edited text, otherwise it is showned below. This is the below case to show full options of text formats without disturbing content.
![The look and feel of the WYSIWYG](/../screenshots/screenshots/wysiwyg.png?raw=true "WYSIWYG screenshot")

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/jakuub/tiles_markdown_wysiwyg_component/issues
