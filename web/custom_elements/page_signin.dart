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
  
  void signup(Event e, var details, Node target) {
    String url = "http://0.0.0.0:8080/signup";
    HttpRequest request = new HttpRequest() 
      ..open("POST", url, async: true)
      ..setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
      ..responseType = "";
      
    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE && (request.status == 200 || request.status == 0)) {
        _onSuccess(request.responseText);
      }else{
        _handleTheError(request.responseText);
      }
    });
    
    String jsonData = JSON.encode({"username":"olituks('z(àççç", "email": "olituks@gmail.com", "password": "test", "lastname": "Hubert", "name": "olituks('z(àççç"});
    String datas = "datas=$jsonData";
    request.send(datas);
  }

  void signin(Event e, var details, Node target) {
    String email = $["email_input"].value;
    String password = $["password_input"].value;
    String url = "http://0.0.0.0:8080/signin";
    
    HttpRequest request = new HttpRequest() 
      ..open("POST", url, async: true)
      ..setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
      ..responseType = "";
      
    // add an event handler that is called when the request finishes
    request.onReadyStateChange.listen((_) {
      if (request.readyState == HttpRequest.DONE && (request.status == 200 || request.status == 0)) {
        _onSuccess(request.responseText);
      }else{
        _handleTheError(request.responseText);
      }
    });

    String jsonData = JSON.encode({"email":"$email", "password": "$password"});
    String datas = "datas=$jsonData";
    request.send(datas);
  }
  
  void _onSuccess(msg){
    print("success : $msg");
  }
  
  void _handleTheError(msg){
    print("error : $msg");
  }
}






