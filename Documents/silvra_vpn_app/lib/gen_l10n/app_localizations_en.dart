// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Silvra VPN';

  @override
  String get connect => 'Connected';

  @override
  String get disconnect => 'Disconnected';

  @override
  String get durationLabel => 'Duration';

  @override
  String get viewServerList => 'View Server List';

  @override
  String get adBannerPlaceholder => 'Ad Banner Placeholder';

  @override
  String get settings => 'Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get appLanguage => 'App Language';

  @override
  String get shareApp => 'Share App';

  @override
  String get rateApp => 'Rate App';

  @override
  String get signOut => 'Sign Out';

  @override
  String get signOutTapped => 'Sign out tapped (not implemented yet)';

  @override
  String get helpCenterTitle => 'Silvra Assistant (Beta)';

  @override
  String get assistantConnect =>
      'To connect to VPN, open the app and tap CONNECT.';

  @override
  String get assistantNotConnecting =>
      'If VPN is not connecting, check your internet and try again.';

  @override
  String get assistantFree => 'Silvra VPN offers both free and premium plans.';

  @override
  String get assistantGeneric => 'This is a VPN related query.';

  @override
  String get assistantNonVpn =>
      'Sorry, I can only answer VPN-related questions.';

  @override
  String get connectVPN => 'Connect to VPN';

  @override
  String get notConnecting => 'VPN not connecting';

  @override
  String get isItFree => 'Is it free?';

  @override
  String get otherQuestion => 'Other VPN question';

  @override
  String get ask => 'Ask';

  @override
  String get needMoreHelp => 'Need more help?';

  @override
  String get contactEmail => 'Contact via Email';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get helpCenter => 'Help / Contact Us';

  @override
  String get subscriptionRequired => 'Subscription Required';

  @override
  String get premiumProtocolUpgradeMessage =>
      'This protocol is available for Premium users only. Please upgrade your plan to access it.';

  @override
  String get upgradeNow => 'Upgrade Now';

  @override
  String get cancel => 'Cancel';

  @override
  String get selectServer => 'Select Server';

  @override
  String get freeTab => 'Free';

  @override
  String get premiumTab => 'Premium';
}
