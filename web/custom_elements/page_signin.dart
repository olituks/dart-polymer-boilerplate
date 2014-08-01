// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

@CustomTag('signin-element')
class Signin extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  @observable Map labels = toObservable({});
  
  Signin.created() : super.created();
  
  ready() {
    super.ready();
    _saveData();
  }
  
  void _saveData() {
    HttpRequest request = new HttpRequest(); // create a new XHR
    
    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE &&
          (request.status == 200 || request.status == 0)) {
        // data saved OK.
        print(request.responseText); // output the response from the server
      }
    });
  
    // POST the data to the server
    var url = "http://127.0.0.1:8080/programming-languages";
    request.open("POST", url, async: false);
  
    String jsonData = '{"language":"dart"}'; // etc...
    request.send(jsonData); // perform the async POST
  }
}