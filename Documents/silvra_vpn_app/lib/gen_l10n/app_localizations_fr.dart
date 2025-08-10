// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Silvra VPN';

  @override
  String get connect => 'Connecté';

  @override
  String get disconnect => 'Déconnecté';

  @override
  String get durationLabel => 'Durée';

  @override
  String get viewServerList => 'Voir la liste des serveurs';

  @override
  String get adBannerPlaceholder =>
      'Espace réservé pour la bannière publicitaire';

  @override
  String get settings => 'Paramètres';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get appLanguage => 'Langue de l’application';

  @override
  String get shareApp => 'Partager l’application';

  @override
  String get rateApp => 'Noter l’application';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get signOutTapped => 'Déconnexion appuyée (pas encore implémentée)';

  @override
  String get helpCenterTitle => 'Assistant Silvra (Bêta)';

  @override
  String get assistantConnect =>
      'Pour se connecter au VPN, ouvrez l’application et appuyez sur CONNECTER.';

  @override
  String get assistantNotConnecting =>
      'Si le VPN ne se connecte pas, vérifiez votre connexion Internet et réessayez.';

  @override
  String get assistantFree =>
      'Silvra VPN propose des plans gratuits et premium.';

  @override
  String get assistantGeneric => 'C’est une question liée au VPN.';

  @override
  String get assistantNonVpn =>
      'Désolé, je ne peux répondre qu’aux questions liées au VPN.';

  @override
  String get connectVPN => 'Se connecter au VPN';

  @override
  String get notConnecting => 'VPN ne se connecte pas';

  @override
  String get isItFree => 'Est-ce gratuit ?';

  @override
  String get otherQuestion => 'Autre question VPN';

  @override
  String get ask => 'Demander';

  @override
  String get needMoreHelp => 'Besoin de plus d’aide ?';

  @override
  String get contactEmail => 'Contactez par e-mail';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsConditions => 'Termes et conditions';

  @override
  String get helpCenter => 'Aide / Contactez-nous';

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
