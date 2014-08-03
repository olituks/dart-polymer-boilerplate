// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';

@CustomTag('signin-element')
class Signin extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  @observable Map labels = toObservable({});
  
  Signin.created() : super.created();
  
  ready() {
    super.ready();
    _saveData2();
  }
  
  void _saveData() {
    HttpRequest request = new HttpRequest(); // create a new XHR
  
    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
          (request.status == 200 || request.status == 0)) {
        // data saved OK.
        print(request.responseText);
      }
    });
  
    // POST the data to the server
    var url = "http://127.0.0.1:8080/savedata";
    request.open("POST", url, async: false);
    request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
  
    /*String jsonData = JSON.encode({"language":"dart2"});*/
    String jsonData = "language=dart2";
    request.send(jsonData);
  }
  
  void _saveData2() {
    String url = "http://127.0.0.1:8080/savedata";
    HttpRequest request = new HttpRequest() 
      ..open("POST", url, async: true)
      ..setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
      ..responseType = "arraybuffer";

    
    String jsonData = JSON.encode({"test":"valuetest1"});
    String datas = "datas=$jsonData";
    request.send(datas);
  }
}