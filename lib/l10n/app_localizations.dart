import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('ja'),
    Locale('ko')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MotoGenius'**
  String get appTitle;

  /// No description provided for @navProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get navProducts;

  /// No description provided for @navCart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get navCart;

  /// No description provided for @navInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get navInventory;

  /// No description provided for @productInStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get productInStock;

  /// No description provided for @productRunningLow.
  ///
  /// In en, this message translates to:
  /// **'Running Low'**
  String get productRunningLow;

  /// No description provided for @productOutOfStock.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get productOutOfStock;

  /// No description provided for @inventoryUpdateStock.
  ///
  /// In en, this message translates to:
  /// **'Update Stock'**
  String get inventoryUpdateStock;

  /// No description provided for @inventoryScanBarcode.
  ///
  /// In en, this message translates to:
  /// **'Scan Barcode'**
  String get inventoryScanBarcode;

  /// No description provided for @inventoryLowStockAlert.
  ///
  /// In en, this message translates to:
  /// **'Running low on {product}'**
  String inventoryLowStockAlert(String product);

  /// No description provided for @commonSearch.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get commonSearch;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get commonConfirm;

  /// No description provided for @commonUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get commonUndo;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to MotoGenius'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your gear. Grow your business.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Smart Inventory'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Track stock levels, get low-stock alerts, and scan barcodes — all in real time.'**
  String get onboardingSlide1Subtitle;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'Easy Orders'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Process orders and manage deliveries in seconds.'**
  String get onboardingSlide2Subtitle;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In en, this message translates to:
  /// **'Grow Together'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Connect with brand partners and expand your network.'**
  String get onboardingSlide3Subtitle;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @authLogin.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLogin;

  /// No description provided for @authRegister.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegister;

  /// No description provided for @authEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPassword;

  /// No description provided for @authFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get authFullName;

  /// No description provided for @authLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get authLoginButton;

  /// No description provided for @authRegisterButton.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get authRegisterButton;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authAlreadyHaveAccount;

  /// No description provided for @authDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authDontHaveAccount;

  /// No description provided for @authVerifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get authVerifyOtp;

  /// No description provided for @authOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to {contact}'**
  String authOtpSentTo(String contact);

  /// No description provided for @authResendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get authResendOtp;

  /// No description provided for @authVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authVerify;

  /// No description provided for @profileSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Up Your Profile'**
  String get profileSetupTitle;

  /// No description provided for @profileSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about yourself'**
  String get profileSetupSubtitle;

  /// No description provided for @profileRoleOwner.
  ///
  /// In en, this message translates to:
  /// **'Store Owner'**
  String get profileRoleOwner;

  /// No description provided for @profileRoleOwnerDesc.
  ///
  /// In en, this message translates to:
  /// **'I run a motorcycle gear shop'**
  String get profileRoleOwnerDesc;

  /// No description provided for @profileRolePartner.
  ///
  /// In en, this message translates to:
  /// **'Partner / Distributor'**
  String get profileRolePartner;

  /// No description provided for @profileRolePartnerDesc.
  ///
  /// In en, this message translates to:
  /// **'I supply products to stores'**
  String get profileRolePartnerDesc;

  /// No description provided for @profilePhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get profilePhone;

  /// No description provided for @profileSetupContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get profileSetupContinue;

  /// No description provided for @companySelectTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Your Company'**
  String get companySelectTitle;

  /// No description provided for @companySelectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find your company to get started'**
  String get companySelectSubtitle;

  /// No description provided for @companySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search company name...'**
  String get companySearchHint;

  /// No description provided for @companyNotFound.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find your company?'**
  String get companyNotFound;

  /// No description provided for @companyAddManually.
  ///
  /// In en, this message translates to:
  /// **'Add Manually'**
  String get companyAddManually;

  /// No description provided for @companySkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get companySkip;

  /// No description provided for @manualSubmitTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Your Company'**
  String get manualSubmitTitle;

  /// No description provided for @manualSubmitSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll review and add it within 24 hours'**
  String get manualSubmitSubtitle;

  /// No description provided for @manualSubmitName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get manualSubmitName;

  /// No description provided for @manualSubmitCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get manualSubmitCategory;

  /// No description provided for @manualSubmitRegistration.
  ///
  /// In en, this message translates to:
  /// **'GST / Registration Number'**
  String get manualSubmitRegistration;

  /// No description provided for @manualSubmitWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website (optional)'**
  String get manualSubmitWebsite;

  /// No description provided for @manualSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit for Review'**
  String get manualSubmitButton;

  /// No description provided for @manualSubmitSuccess.
  ///
  /// In en, this message translates to:
  /// **'Submitted! We\'ll review within 24 hours.'**
  String get manualSubmitSuccess;

  /// No description provided for @permissionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable Permissions'**
  String get permissionsTitle;

  /// No description provided for @permissionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'For the best experience'**
  String get permissionsSubtitle;

  /// No description provided for @permissionCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get permissionCamera;

  /// No description provided for @permissionCameraDesc.
  ///
  /// In en, this message translates to:
  /// **'For barcode scanning'**
  String get permissionCameraDesc;

  /// No description provided for @permissionNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permissionNotifications;

  /// No description provided for @permissionNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'For low-stock alerts'**
  String get permissionNotificationsDesc;

  /// No description provided for @permissionAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get permissionAllow;

  /// No description provided for @permissionSkipForNow.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get permissionSkipForNow;

  /// No description provided for @permissionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue to Dashboard'**
  String get permissionContinue;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es', 'fr', 'hi', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'hi': return AppLocalizationsHi();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
