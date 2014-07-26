// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

@CustomTag('signin-element')
class Signin extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  @observable Map labels = toObservable({
    'input_email': '',
    'input_password': '',
    'social_login': '',
    'login': ''
  });
  
  Signin.created() : super.created();
  
  ready() {
    super.ready();
  }
}