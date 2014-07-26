// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import "package:intl/intl_browser.dart";
import 'dart:html';

@CustomTag('html-snippet-element')
class Snippet extends PolymerElement {
  
  @published var src;
  
  Snippet.created() : super.created();
  
  ready() {
    super.ready();
    _getLocalFromNavigator();
  }
  
  String _locale;
  _getLocalFromNavigator(){
    findSystemLocale().then((l){
      switch (l) {
        case 'fr':
          _locale = l;
          _getHtmlSniped(l);
          break;
        default:
          _locale = "en";
          _getHtmlSniped(l);
      }
    });
  }
  
  _getHtmlSniped(l){
    var my_div = shadowRoot.querySelector('#snippet');
    var src_local = src.replaceFirst(new RegExp('locale'), _locale);
    HttpRequest.getString(src_local).then((result) {
      my_div.setInnerHtml(result, 
                          validator: new NodeValidatorBuilder()
                            ..allowHtml5()
                            ..allowElement('a', attributes: ['href'])
                            ..allowElement('img', attributes: ['style'])
                         );
    });
  }
}