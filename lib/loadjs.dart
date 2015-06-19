library loadjs;

import "dart:async";
import "dart:html";
import "dart:js" as js;

Future loadJS(List<String> src){
  List<Future> futures = [];

  Function loadFile = (String filePath){
    if (querySelector('script[src="$filePath"]') != null) {
      return;
    }
    ScriptElement script = new ScriptElement();
    script.type = "application/javascript";
    script.src = filePath;
    document.head.append(script);
    futures.add(script.onLoad.first);
  };
  for(String s in src){
    loadFile(s);
  }
  return Future.wait(futures).then((list){
    return js.context;
  });
}