// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:polymer/polymer.dart';

@CustomTag('about-page-element')
class About extends PolymerElement {
  
  @PublishedProperty(reflect: true) String locale;
  @observable Map labels = toObservable({
    'input_email': ''
  });
  
  About.created() : super.created();

}