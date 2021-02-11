import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:locator/l10n/messages_all.dart';

class Locs {
  static Future<Locs> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return Locs();
    });
  }

  static Locs of(BuildContext context) {
    return Localizations.of<Locs>(context, Locs);
  }

  String get appName {
    return Intl.message('Locator', name: 'appName', desc: 'name of the app');
  }

  String get editButton {
    return Intl.message('Edit',
        name: 'editButton', desc: 'Edit backdrop, the Edit button');
  }

  String get directionsButton {
    return Intl.message('Directions',
        name: 'directionsButton', desc: 'Edit backdrop, the directions button');
  }

  String get updateButton {
    return Intl.message('Update',
        name: 'updateButton', desc: 'Options backdrop, the update button');
  }

  String get registerButton {
    return Intl.message('Register',
        name: 'registerButton', desc: 'Options backdrop, the register button');
  }

  String get feedbackButton {
    return Intl.message('Feedback',
        name: 'feedbackButton', desc: 'Options backdrop, the feedback button');
  }

  String get cantFindButton {
    return Intl.message('Can\'t find something?',
        name: 'cantFindButton', desc: 'Options backdrop, the cantFind button');
  }

  String get aboutButton {
    return Intl.message('About',
        name: 'aboutButton', desc: 'Options backdrop, the about button');
  }

  String get donateButton {
    return Intl.message('Donate',
        name: 'donateButton', desc: 'Options backdrop, the donate button');
  }

  String get tryGoogle {
    return Intl.message('Try Google maps',
        name: 'tryGoogle', desc: 'Options backdrop, the cantFind button, hint');
  }

  String get removeAds {
    return Intl.message('Remove Ads',
        name: 'removeAds', desc: 'Options backdrop, the donate button, hint');
  }

  String get logout {
    return Intl.message('Log out',
        name: 'logout', desc: 'Options backdrop, the logout button');
  }

  String get addSomethingDifferent {
    return Intl.message('Add something different',
        name: 'addSomethingDifferent',
        desc: 'Filter bottom bar, text editing hint');
  }

  String get addNewDrop {
    return Intl.message(
      'Add a new drop',
      name: 'addNewDrop',
      desc: 'Create new drop card, title',
    );
  }

  String get moreDetails {
    return Intl.message(
      'MORE DETAILS',
      name: 'moreDetails',
      desc: 'Add more details',
    );
  }
}

class LocsDelegate extends LocalizationsDelegate<Locs> {
  const LocsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<Locs> load(Locale locale) {
    return Locs.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Locs> old) {
    return false;
  }
}
