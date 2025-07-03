// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Health Care App`
  String get app_title {
    return Intl.message(
      'Health Care App',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signup {
    return Intl.message(
      'Sign Up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phone {
    return Intl.message(
      'Phone Number',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Doctor `
  String get welcomeDoctor {
    return Intl.message(
      'Welcome Doctor ',
      name: 'welcomeDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Health Care App`
  String get welcome_message {
    return Intl.message(
      'Welcome to the Health Care App',
      name: 'welcome_message',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get language {
    return Intl.message(
      'Languages',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get my_wallet {
    return Intl.message(
      'My Wallet',
      name: 'my_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message(
      'Security',
      name: 'security',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get new_password {
    return Intl.message(
      'New Password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Language changed successfully to`
  String get language_changed_to {
    return Intl.message(
      'Language changed successfully to',
      name: 'language_changed_to',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Let's Find Your Specialist`
  String get lets_find_doctor {
    return Intl.message(
      'Let\'s Find Your Specialist',
      name: 'lets_find_doctor',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Profile`
  String get doctor_profile {
    return Intl.message(
      'Doctor Profile',
      name: 'doctor_profile',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get book_appointment {
    return Intl.message(
      'Book Appointment',
      name: 'book_appointment',
      desc: '',
      args: [],
    );
  }

  /// `Appointment confirmed successfully`
  String get appointment_confirmed {
    return Intl.message(
      'Appointment confirmed successfully',
      name: 'appointment_confirmed',
      desc: '',
      args: [],
    );
  }

  /// `No specializations `
  String get no_specialization {
    return Intl.message(
      'No specializations ',
      name: 'no_specialization',
      desc: '',
      args: [],
    );
  }

  /// `Contact Details`
  String get contact_details {
    return Intl.message(
      'Contact Details',
      name: 'contact_details',
      desc: '',
      args: [],
    );
  }

  /// `No phone number`
  String get no_phone {
    return Intl.message(
      'No phone number',
      name: 'no_phone',
      desc: '',
      args: [],
    );
  }

  /// `No email address`
  String get no_email {
    return Intl.message(
      'No email address',
      name: 'no_email',
      desc: '',
      args: [],
    );
  }

  /// `No address`
  String get no_address {
    return Intl.message(
      'No address',
      name: 'no_address',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Details`
  String get doctor_details {
    return Intl.message(
      'Doctor Details',
      name: 'doctor_details',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Booking successful`
  String get booking_successful {
    return Intl.message(
      'Booking successful',
      name: 'booking_successful',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logout_confirmation {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logout_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Logout successful`
  String get logout_successful {
    return Intl.message(
      'Logout successful',
      name: 'logout_successful',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get select_language {
    return Intl.message(
      'Select Language',
      name: 'select_language',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Doctor `
  String get welcome {
    return Intl.message(
      'Welcome Doctor ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Have A Nice Day`
  String get haveANiceDay {
    return Intl.message(
      'Have A Nice Day',
      name: 'haveANiceDay',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Appointments`
  String get upcomingAppointments {
    return Intl.message(
      'Upcoming Appointments',
      name: 'upcomingAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Receive Notification`
  String get receiveNotifications {
    return Intl.message(
      'Receive Notification',
      name: 'receiveNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Vibration`
  String get vibration {
    return Intl.message(
      'Vibration',
      name: 'vibration',
      desc: '',
      args: [],
    );
  }

  /// `Help and Support`
  String get helpSupport {
    return Intl.message(
      'Help and Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Need Help or have a question?`
  String get needHelp {
    return Intl.message(
      'Need Help or have a question?',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get faq {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `If you have any issues or inquiries, please contact us through one of the methods below.`
  String get supportMessage {
    return Intl.message(
      'If you have any issues or inquiries, please contact us through one of the methods below.',
      name: 'supportMessage',
      desc: '',
      args: [],
    );
  }

  /// `If you need help, feel free to reach out to us. We're here to support you.`
  String get contactUsDescription {
    return Intl.message(
      'If you need help, feel free to reach out to us. We\'re here to support you.',
      name: 'contactUsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Live Chat`
  String get liveChat {
    return Intl.message(
      'Live Chat',
      name: 'liveChat',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get support {
    return Intl.message(
      'Support',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `How do I reset my password?`
  String get faqQ1 {
    return Intl.message(
      'How do I reset my password?',
      name: 'faqQ1',
      desc: '',
      args: [],
    );
  }

  /// `Go to Settings > Change Password and follow the instructions.`
  String get faqA1 {
    return Intl.message(
      'Go to Settings > Change Password and follow the instructions.',
      name: 'faqA1',
      desc: '',
      args: [],
    );
  }

  /// `How can I contact support?`
  String get faqQ2 {
    return Intl.message(
      'How can I contact support?',
      name: 'faqQ2',
      desc: '',
      args: [],
    );
  }

  /// `You can contact us through the support screen via WhatsApp.`
  String get faqA2 {
    return Intl.message(
      'You can contact us through the support screen via WhatsApp.',
      name: 'faqA2',
      desc: '',
      args: [],
    );
  }

  /// `How can I book a new appointment?`
  String get faqQ3 {
    return Intl.message(
      'How can I book a new appointment?',
      name: 'faqQ3',
      desc: '',
      args: [],
    );
  }

  /// `From the home screen, tap on 'Book Appointment' and select the doctor and preferred date.`
  String get faqA3 {
    return Intl.message(
      'From the home screen, tap on \'Book Appointment\' and select the doctor and preferred date.',
      name: 'faqA3',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message(
      'Contact Us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Chat with us on WhatsApp`
  String get chatWithUs {
    return Intl.message(
      'Chat with us on WhatsApp',
      name: 'chatWithUs',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureLogout',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Logout`
  String get logoutConfirmationTitle {
    return Intl.message(
      'Confirm Logout',
      name: 'logoutConfirmationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Logged out successfully`
  String get logoutSuccess {
    return Intl.message(
      'Logged out successfully',
      name: 'logoutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image From Gallery`
  String get chooseImageFromGallery {
    return Intl.message(
      'Choose Image From Gallery',
      name: 'chooseImageFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Delete Image`
  String get deleteImage {
    return Intl.message(
      'Delete Image',
      name: 'deleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Show Image`
  String get showImage {
    return Intl.message(
      'Show Image',
      name: 'showImage',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get change {
    return Intl.message(
      'Change Image',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Available Slots`
  String get available {
    return Intl.message(
      'Available Slots',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message(
      'Select Date',
      name: 'selectDate',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message(
      'Select Time',
      name: 'selectTime',
      desc: '',
      args: [],
    );
  }

  /// `Add Slot`
  String get addSlot {
    return Intl.message(
      'Add Slot',
      name: 'addSlot',
      desc: '',
      args: [],
    );
  }

  /// `Please enter both date and time.`
  String get pleaseEnterDateTime {
    return Intl.message(
      'Please enter both date and time.',
      name: 'pleaseEnterDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Delete Slot`
  String get deleteSlot {
    return Intl.message(
      'Delete Slot',
      name: 'deleteSlot',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this slot?`
  String get confirmDeleteSlot {
    return Intl.message(
      'Are you sure you want to delete this slot?',
      name: 'confirmDeleteSlot',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Select Time to Delete`
  String get selectTimeToDelete {
    return Intl.message(
      'Select Time to Delete',
      name: 'selectTimeToDelete',
      desc: '',
      args: [],
    );
  }

  /// `Slot deleted successfully`
  String get slotDeleted {
    return Intl.message(
      'Slot deleted successfully',
      name: 'slotDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Time slot deleted successfully`
  String get timeSlotDeleted {
    return Intl.message(
      'Time slot deleted successfully',
      name: 'timeSlotDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Slots updated successfully`
  String get slotsUpdated {
    return Intl.message(
      'Slots updated successfully',
      name: 'slotsUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update:`
  String get updateFailed {
    return Intl.message(
      'Failed to update:',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `No bookings on this date`
  String get bookSearch {
    return Intl.message(
      'No bookings on this date',
      name: 'bookSearch',
      desc: '',
      args: [],
    );
  }

  /// `No Appointments Found`
  String get noAppointmentsFound {
    return Intl.message(
      'No Appointments Found',
      name: 'noAppointmentsFound',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Edit Price`
  String get editPrice {
    return Intl.message(
      'Edit Price',
      name: 'editPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter new price`
  String get enterNewPrice {
    return Intl.message(
      'Enter new price',
      name: 'enterNewPrice',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get egp {
    return Intl.message(
      'EGP',
      name: 'egp',
      desc: '',
      args: [],
    );
  }

  /// `Examination Price`
  String get examinationPrice {
    return Intl.message(
      'Examination Price',
      name: 'examinationPrice',
      desc: '',
      args: [],
    );
  }

  /// `Main balance`
  String get mainBalance {
    return Intl.message(
      'Main balance',
      name: 'mainBalance',
      desc: '',
      args: [],
    );
  }

  /// `logout`
  String get logout {
    return Intl.message(
      'logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `visa`
  String get visa {
    return Intl.message(
      'visa',
      name: 'visa',
      desc: '',
      args: [],
    );
  }

  /// `Search By Date (e.g. 13 Aug)`
  String get searchByDate {
    return Intl.message(
      'Search By Date (e.g. 13 Aug)',
      name: 'searchByDate',
      desc: '',
      args: [],
    );
  }

  /// `enterDateAndTime`
  String get enterDateAndTime {
    return Intl.message(
      'enterDateAndTime',
      name: 'enterDateAndTime',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Rate Doctor`
  String get rate {
    return Intl.message(
      'Rate Doctor',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
