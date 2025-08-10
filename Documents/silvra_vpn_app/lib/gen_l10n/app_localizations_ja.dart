// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'シルヴラVPN';

  @override
  String get connect => '接続済み';

  @override
  String get disconnect => '切断済み';

  @override
  String get durationLabel => '期間';

  @override
  String get viewServerList => 'サーバーリストを見る';

  @override
  String get adBannerPlaceholder => '広告バナープレースホルダー';

  @override
  String get settings => '設定';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get appLanguage => 'アプリの言語';

  @override
  String get shareApp => 'アプリを共有する';

  @override
  String get rateApp => 'アプリを評価する';

  @override
  String get signOut => 'サインアウト';

  @override
  String get signOutTapped => 'サインアウトがタップされました（まだ実装されていません）';

  @override
  String get helpCenterTitle => 'シルヴラアシスタント（ベータ）';

  @override
  String get assistantConnect => 'VPNに接続するには、アプリを開き、CONNECTをタップしてください。';

  @override
  String get assistantNotConnecting => 'VPNが接続できない場合は、インターネットを確認して再試行してください。';

  @override
  String get assistantFree => 'Silvra VPNは無料とプレミアムの両プランを提供しています。';

  @override
  String get assistantGeneric => 'これはVPNに関する質問です。';

  @override
  String get assistantNonVpn => '申し訳ありませんが、VPNに関する質問のみお答えできます。';

  @override
  String get connectVPN => 'VPNに接続する';

  @override
  String get notConnecting => 'VPNが接続できません';

  @override
  String get isItFree => '無料ですか？';

  @override
  String get otherQuestion => 'その他のVPNの質問';

  @override
  String get ask => '質問する';

  @override
  String get needMoreHelp => 'さらにサポートが必要ですか？';

  @override
  String get contactEmail => 'メールで連絡する';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsConditions => '利用規約';

  @override
  String get helpCenter => 'ヘルプ / お問い合わせ';

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
