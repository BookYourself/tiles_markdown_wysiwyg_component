library loadjs;

import "dart:async";
import "dart:html";
import "dart:js" as js;

Map _loaded = {};

Future loadJS(List<String> src) {
  List<Future> futures = [];

  Function loadFile = (String filePath) {
    if (querySelector('script[src="$filePath"]') != null) {
      if (_loaded.containsKey(filePath)) {
        futures.add(_loaded[filePath]);
      }
      return;
    }
    ScriptElement script = new ScriptElement();
    script.type = "application/javascript";
    script.src = filePath;
    document.head.append(script);
    Future onLoad = script.onLoad.first;

    futures.add(onLoad);
    _loaded[filePath] = onLoad;
  };
  for (String s in src) {
    loadFile(s);
  }
  return Future.wait(futures).then((list) {
    return js.context;
  });
}
