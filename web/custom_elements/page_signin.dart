// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'dart:html';

@CustomTag('signin-element')
class Signin extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  @observable Map labels = toObservable({});
  
  Signin.created() : super.created();
  
  void signup(Event e, var details, Node target) {
    String url = "https://127.0.0.1:8080/signup";
    HttpRequest request = new HttpRequest() 
      ..open("POST", url, async: true)
      ..setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
      ..responseType = "arraybuffer";

    String datas = "username=olituks&email=olituks%40gmail.com&password=test&name=Olivier&lastname=Hubert";    
    request.send(datas);
  }
  
  void signin(Event e, var details, Node target) {
    String email = $["email_input"].value;
    String password = $["password_input"].value;
    String url = "https://127.0.0.1:8080/signin";
    
    HttpRequest request = new HttpRequest() 
      ..open("POST", url, async: true)
      ..setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
      ..responseType = "arraybuffer";

    String datas = "email=$email&password=$password";
    request.send(datas);
  }
}






