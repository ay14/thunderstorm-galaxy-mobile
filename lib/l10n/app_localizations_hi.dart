// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'MotoGenius';

  @override
  String get navProducts => 'उत्पाद';

  @override
  String get navCart => 'कार्ट';

  @override
  String get navInventory => 'इन्वेंटरी';

  @override
  String get productInStock => 'स्टॉक में है';

  @override
  String get productRunningLow => 'कम हो रहा है';

  @override
  String get productOutOfStock => 'स्टॉक खत्म';

  @override
  String get inventoryUpdateStock => 'स्टॉक अपडेट करें';

  @override
  String get inventoryScanBarcode => 'बारकोड स्कैन करें';

  @override
  String inventoryLowStockAlert(String product) {
    return '$product का स्टॉक कम है';
  }

  @override
  String get commonSearch => 'उत्पाद खोजें...';

  @override
  String get commonSave => 'सेव करें';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonConfirm => 'क्या आप सुनिश्चित हैं?';

  @override
  String get commonUndo => 'वापस लें';

  @override
  String get onboardingWelcomeTitle => 'Welcome to MotoGenius';

  @override
  String get onboardingWelcomeSubtitle => 'Manage your gear. Grow your business.';

  @override
  String get onboardingSlide1Title => 'Smart Inventory';

  @override
  String get onboardingSlide1Subtitle => 'Track stock levels, get low-stock alerts, and scan barcodes — all in real time.';

  @override
  String get onboardingSlide2Title => 'Easy Orders';

  @override
  String get onboardingSlide2Subtitle => 'Process orders and manage deliveries in seconds.';

  @override
  String get onboardingSlide3Title => 'Grow Together';

  @override
  String get onboardingSlide3Subtitle => 'Connect with brand partners and expand your network.';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get authLogin => 'Login';

  @override
  String get authRegister => 'Register';

  @override
  String get authEmail => 'Email';

  @override
  String get authPassword => 'Password';

  @override
  String get authFullName => 'Full Name';

  @override
  String get authLoginButton => 'Login';

  @override
  String get authRegisterButton => 'Create Account';

  @override
  String get authAlreadyHaveAccount => 'Already have an account?';

  @override
  String get authDontHaveAccount => 'Don\'t have an account?';

  @override
  String get authVerifyOtp => 'Verify OTP';

  @override
  String authOtpSentTo(String contact) {
    return 'OTP sent to $contact';
  }

  @override
  String get authResendOtp => 'Resend OTP';

  @override
  String get authVerify => 'Verify';

  @override
  String get profileSetupTitle => 'Set Up Your Profile';

  @override
  String get profileSetupSubtitle => 'Tell us about yourself';

  @override
  String get profileRoleOwner => 'Store Owner';

  @override
  String get profileRoleOwnerDesc => 'I run a motorcycle gear shop';

  @override
  String get profileRolePartner => 'Partner / Distributor';

  @override
  String get profileRolePartnerDesc => 'I supply products to stores';

  @override
  String get profilePhone => 'Phone Number';

  @override
  String get profileSetupContinue => 'Continue';

  @override
  String get companySelectTitle => 'Select Your Company';

  @override
  String get companySelectSubtitle => 'Find your company to get started';

  @override
  String get companySearchHint => 'Search company name...';

  @override
  String get companyNotFound => 'Can\'t find your company?';

  @override
  String get companyAddManually => 'Add Manually';

  @override
  String get companySkip => 'Skip for now';

  @override
  String get manualSubmitTitle => 'Add Your Company';

  @override
  String get manualSubmitSubtitle => 'We\'ll review and add it within 24 hours';

  @override
  String get manualSubmitName => 'Company Name';

  @override
  String get manualSubmitCategory => 'Category';

  @override
  String get manualSubmitRegistration => 'GST / Registration Number';

  @override
  String get manualSubmitWebsite => 'Website (optional)';

  @override
  String get manualSubmitButton => 'Submit for Review';

  @override
  String get manualSubmitSuccess => 'Submitted! We\'ll review within 24 hours.';

  @override
  String get permissionsTitle => 'Enable Permissions';

  @override
  String get permissionsSubtitle => 'For the best experience';

  @override
  String get permissionCamera => 'Camera';

  @override
  String get permissionCameraDesc => 'For barcode scanning';

  @override
  String get permissionNotifications => 'Notifications';

  @override
  String get permissionNotificationsDesc => 'For low-stock alerts';

  @override
  String get permissionAllow => 'Allow';

  @override
  String get permissionSkipForNow => 'Skip for now';

  @override
  String get permissionContinue => 'Continue to Dashboard';
}
