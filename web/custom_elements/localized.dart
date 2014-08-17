// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:convert';
import "package:intl/intl_browser.dart";

@CustomTag('localized-element')
class Localized extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  @PublishedProperty(reflect: true) Map labels;
  
  Localized.created() : super.created();
  
  ready() {
    super.ready();
    _getLocalFromNavigator();
    _loadTranslations();
  }
  
  update() {
    if (!_l10n.containsKey(locale)) return;
    
    var l10n = _l10n[locale];

    labels['input_email'] = l10n['input_email'];
    labels['input_password'] = l10n['input_password'];
    labels['social_login'] = l10n['social_login'];
    labels['login'] = l10n['login'];
    labels['sign-up'] = l10n['sign-up'];
    labels['sign_in'] = l10n['sign_in'];
  }
  
  List _locales = ['en', 'fr'];
  _loadTranslations() {
    _locales.forEach((l10n)=> _loadLocale(l10n));
  }

  Map _l10n = {};
  _loadLocale(_l) {
    HttpRequest.getString('i18n/translation_${_l}.json')
      .then((res) {
        _l10n[_l] = JSON.decode(res);
        update();
      })
      .catchError((Error error) {
        print(error.toString());
      });
  }
  
  _getLocalFromNavigator(){
    findSystemLocale().then((l){
      switch (l) {
        case 'fr':
          locale = "fr";
          break;
        default:
          locale = "en";
      }
    });
  }

}