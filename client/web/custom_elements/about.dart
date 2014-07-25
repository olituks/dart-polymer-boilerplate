// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import "package:intl/intl_browser.dart";
import 'dart:html';

@CustomTag('about-page-element')
class Signin extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  
  @observable Map labels = toObservable({
    'input_email': ''
  });
  
  Signin.created() : super.created();
  
  ready() {
    super.ready();
    _getLocalFromNavigator();
  }
  
  _getLocalFromNavigator(){
    findSystemLocale().then((l){
      switch (l) {
        case 'fr':
          locale = l;
          _getMainPage(l);
          break;
        default:
          locale = "en";
          _getMainPage(l);
      }
    });
  }
  
  _getMainPage(l){
    var my_div = shadowRoot.querySelector('#main_page');
    HttpRequest.getString("custom_elements/about_$l.html").then((result) {
      my_div.setInnerHtml(result, 
                          validator: new NodeValidatorBuilder()
                            ..allowHtml5()
                            ..allowElement('a', attributes: ['href'])
                            ..allowElement('img', attributes: ['style'])
                         );
    });
  }
}