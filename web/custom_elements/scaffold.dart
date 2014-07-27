// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'dart:convert';
import 'dart:async';
import "package:intl/intl_browser.dart";
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_dialog.dart';

/*http://blog.sethladd.com/2012/03/using-futures-in-dart-for-better-async.html*/
/*https://api.dartlang.org/apidocs/channels/stable/dartdoc-viewer/intl*/
/*https://api.dartlang.org/apidocs/channels/dev/dartdoc-viewer/intl*/
/*https://github.com/dart-lang/paper-elements*/

@CustomTag('scaffold-toolbar-element')
class Scaffold extends PolymerElement{

  String _locale;

  void click_menu_item(String label, String main_page) {
    _setPageTitle(label);
    _setMainPage(main_page);
  }
  
  void click_sub_menu_item(String dialog){
    _dialogDisplay(dialog);
  }

  Scaffold.created() : super.created();
    
  @override
  void attached() {
    super.attached();
    
    /*Detect the browser language to set _locale variable*/
    findSystemLocale().then((l){
      switch (l) {
        case 'fr':
          _locale = l;
          _loadExternalJsonMenuDescriptor();
          break;
        default:
         _locale = "en";
         _loadExternalJsonMenuDescriptor();
      }
    });
  }
  
  _loadExternalJsonMenuDescriptor(){
    /*Create menulist object and initialise all entry in the polymer menu*/
    var _menu_list;
    MenuList.create('i18n/menu_items_${_locale}.json').then((ml) {
      _menu_list = ml;
      
      /*menu_list*/
      addElementToMenu(list_value){
        var newElement = new Element.tag('core-item');
        newElement
          ..setAttribute("icon", list_value["icon"])
          ..setAttribute("label", list_value["label"])
          ..onClick.listen((e) => click_menu_item(list_value["label"], list_value["main_page"]));
        shadowRoot.querySelector('#core_menu_item').children.add(newElement);
      };
      _menu_list.my_json["menu_list"].forEach(addElementToMenu);
      
      /*sub menu list*/
      addElementToSubMenu(list_value){
        var newElement = new Element.tag('paper-item');
        newElement
          ..setAttribute("icon", list_value["icon"])
          ..setAttribute("label", list_value["label"])
          ..onClick.listen((e) => click_sub_menu_item(list_value["dialog"]));
        shadowRoot.querySelector('#paper_menu_button').children.add(newElement);
      };
      _menu_list.my_json["sub_menu_list"].forEach(addElementToSubMenu);
    });
  }
  
  _setPageTitle(label){
    shadowRoot.querySelector('#page_name').text = label;
  }
  
  _setMainPage(main_page){
    var newElement = new Element.tag(main_page);
    shadowRoot.querySelector('#main_page').children.add(newElement);
  }
  
  _dialogDisplay(dialog){
    var my_dialog = shadowRoot.querySelector('#my_dialog') as PaperDialog;
    _getDialogPage(_locale);
    my_dialog.toggle();
  }
  
  _getDialogPage(l){
    var my_div = shadowRoot.querySelector('#dialog_main_page');
    HttpRequest.getString("i18n/scaffold_dialog_$l.html").then((result) {
      my_div.setInnerHtml(result, 
                          validator: new NodeValidatorBuilder()
                            ..allowHtml5()
                            ..allowElement('a', attributes: ['href'])
                            ..allowElement('img', attributes: ['style'])
                         );
    });
  }
}

/*MenuList object is use to menu definition in a external json file*/
class MenuList {
  String path;
  Map my_json;

  static Future<MenuList> create(String path) {
    return new MenuList()._load(path);
  }

  Future<MenuList> _load(String path) {
    Completer completer = new Completer();
    
    this.path = path;
    
    var httpRequest = new HttpRequest();
    httpRequest
      ..open('GET', path)
      ..onLoadEnd.listen((e) {
        requestComplete(httpRequest);
        completer.complete(this);
      })
      ..send('');
    return completer.future;
  }

  requestComplete(HttpRequest request) {
    if (request.status == 200) {
       this.my_json  = JSON.decode(request.responseText);
    }else{
      this.my_json  = null;
    }
  }
}