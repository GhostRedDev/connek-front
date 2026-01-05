import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _authToken = prefs.getString('ff_authToken') ?? _authToken;
    });
    _safeInit(() {
      _selectedTabIndex =
          prefs.getInt('ff_selectedTabIndex') ?? _selectedTabIndex;
    });
    _safeInit(() {
      _examplesIDlist =
          prefs.getStringList('ff_examplesIDlist') ?? _examplesIDlist;
    });
    _safeInit(() {
      _exampleNumberList = prefs
              .getStringList('ff_exampleNumberList')
              ?.map(int.parse)
              .toList() ??
          _exampleNumberList;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  AccountStruct _account = AccountStruct();
  AccountStruct get account => _account;
  set account(AccountStruct value) {
    _account = value;
  }

  void updateAccountStruct(Function(AccountStruct) updateFn) {
    updateFn(_account);
  }

  List<ClientPaymentMethodsStruct> _clientPaymentMethods = [];
  List<ClientPaymentMethodsStruct> get clientPaymentMethods =>
      _clientPaymentMethods;
  set clientPaymentMethods(List<ClientPaymentMethodsStruct> value) {
    _clientPaymentMethods = value;
  }

  void addToClientPaymentMethods(ClientPaymentMethodsStruct value) {
    clientPaymentMethods.add(value);
  }

  void removeFromClientPaymentMethods(ClientPaymentMethodsStruct value) {
    clientPaymentMethods.remove(value);
  }

  void removeAtIndexFromClientPaymentMethods(int index) {
    clientPaymentMethods.removeAt(index);
  }

  void updateClientPaymentMethodsAtIndex(
    int index,
    ClientPaymentMethodsStruct Function(ClientPaymentMethodsStruct) updateFn,
  ) {
    clientPaymentMethods[index] = updateFn(_clientPaymentMethods[index]);
  }

  void insertAtIndexInClientPaymentMethods(
      int index, ClientPaymentMethodsStruct value) {
    clientPaymentMethods.insert(index, value);
  }

  MyBotsStruct _myBots = MyBotsStruct();
  MyBotsStruct get myBots => _myBots;
  set myBots(MyBotsStruct value) {
    _myBots = value;
  }

  void updateMyBotsStruct(Function(MyBotsStruct) updateFn) {
    updateFn(_myBots);
  }

  List<DepositsDataStruct> _deposits = [];
  List<DepositsDataStruct> get deposits => _deposits;
  set deposits(List<DepositsDataStruct> value) {
    _deposits = value;
  }

  void addToDeposits(DepositsDataStruct value) {
    deposits.add(value);
  }

  void removeFromDeposits(DepositsDataStruct value) {
    deposits.remove(value);
  }

  void removeAtIndexFromDeposits(int index) {
    deposits.removeAt(index);
  }

  void updateDepositsAtIndex(
    int index,
    DepositsDataStruct Function(DepositsDataStruct) updateFn,
  ) {
    deposits[index] = updateFn(_deposits[index]);
  }

  void insertAtIndexInDeposits(int index, DepositsDataStruct value) {
    deposits.insert(index, value);
  }

  BusinessLeadsStruct _activeBusinessLead = BusinessLeadsStruct();
  BusinessLeadsStruct get activeBusinessLead => _activeBusinessLead;
  set activeBusinessLead(BusinessLeadsStruct value) {
    _activeBusinessLead = value;
  }

  void updateActiveBusinessLeadStruct(Function(BusinessLeadsStruct) updateFn) {
    updateFn(_activeBusinessLead);
  }

  BusinessDataStruct _businessData = BusinessDataStruct();
  BusinessDataStruct get businessData => _businessData;
  set businessData(BusinessDataStruct value) {
    _businessData = value;
  }

  void updateBusinessDataStruct(Function(BusinessDataStruct) updateFn) {
    updateFn(_businessData);
  }

  List<BusinessLeadsStruct> _businessLeads = [];
  List<BusinessLeadsStruct> get businessLeads => _businessLeads;
  set businessLeads(List<BusinessLeadsStruct> value) {
    _businessLeads = value;
  }

  void addToBusinessLeads(BusinessLeadsStruct value) {
    businessLeads.add(value);
  }

  void removeFromBusinessLeads(BusinessLeadsStruct value) {
    businessLeads.remove(value);
  }

  void removeAtIndexFromBusinessLeads(int index) {
    businessLeads.removeAt(index);
  }

  void updateBusinessLeadsAtIndex(
    int index,
    BusinessLeadsStruct Function(BusinessLeadsStruct) updateFn,
  ) {
    businessLeads[index] = updateFn(_businessLeads[index]);
  }

  void insertAtIndexInBusinessLeads(int index, BusinessLeadsStruct value) {
    businessLeads.insert(index, value);
  }

  BusinessVerifiedStruct _businessVerified = BusinessVerifiedStruct();
  BusinessVerifiedStruct get businessVerified => _businessVerified;
  set businessVerified(BusinessVerifiedStruct value) {
    _businessVerified = value;
  }

  void updateBusinessVerifiedStruct(Function(BusinessVerifiedStruct) updateFn) {
    updateFn(_businessVerified);
  }

  BusinessDepositStruct _businessDeposit = BusinessDepositStruct();
  BusinessDepositStruct get businessDeposit => _businessDeposit;
  set businessDeposit(BusinessDepositStruct value) {
    _businessDeposit = value;
  }

  void updateBusinessDepositStruct(Function(BusinessDepositStruct) updateFn) {
    updateFn(_businessDeposit);
  }

  LatLng? _businessLocation = const LatLng(45.502836, -73.567832);
  LatLng? get businessLocation => _businessLocation;
  set businessLocation(LatLng? value) {
    _businessLocation = value;
  }

  ContactDataStruct _activeContact = ContactDataStruct();
  ContactDataStruct get activeContact => _activeContact;
  set activeContact(ContactDataStruct value) {
    _activeContact = value;
  }

  void updateActiveContactStruct(Function(ContactDataStruct) updateFn) {
    updateFn(_activeContact);
  }

  ClientBookingSessionStruct _clientBookingSession =
      ClientBookingSessionStruct();
  ClientBookingSessionStruct get clientBookingSession => _clientBookingSession;
  set clientBookingSession(ClientBookingSessionStruct value) {
    _clientBookingSession = value;
  }

  void updateClientBookingSessionStruct(
      Function(ClientBookingSessionStruct) updateFn) {
    updateFn(_clientBookingSession);
  }

  Pages? _pageSelected = Pages.home;
  Pages? get pageSelected => _pageSelected;
  set pageSelected(Pages? value) {
    _pageSelected = value;
  }

  OfficePages? _officeDashboardPage = OfficePages.myBots;
  OfficePages? get officeDashboardPage => _officeDashboardPage;
  set officeDashboardPage(OfficePages? value) {
    _officeDashboardPage = value;
  }

  ProfilePages? _profilePage = ProfilePages.profile;
  ProfilePages? get profilePage => _profilePage;
  set profilePage(ProfilePages? value) {
    _profilePage = value;
  }

  BusinessPages? _businessDashboardPage = BusinessPages.overview;
  BusinessPages? get businessDashboardPage => _businessDashboardPage;
  set businessDashboardPage(BusinessPages? value) {
    _businessDashboardPage = value;
  }

  String _authToken = '';
  String get authToken => _authToken;
  set authToken(String value) {
    _authToken = value;
    prefs.setString('ff_authToken', value);
  }

  String _notification = '';
  String get notification => _notification;
  set notification(String value) {
    _notification = value;
  }

  bool _weekState = true;
  bool get weekState => _weekState;
  set weekState(bool value) {
    _weekState = value;
  }

  List<EmployeesStruct> _employeesNotHired = [];
  List<EmployeesStruct> get employeesNotHired => _employeesNotHired;
  set employeesNotHired(List<EmployeesStruct> value) {
    _employeesNotHired = value;
  }

  void addToEmployeesNotHired(EmployeesStruct value) {
    employeesNotHired.add(value);
  }

  void removeFromEmployeesNotHired(EmployeesStruct value) {
    employeesNotHired.remove(value);
  }

  void removeAtIndexFromEmployeesNotHired(int index) {
    employeesNotHired.removeAt(index);
  }

  void updateEmployeesNotHiredAtIndex(
    int index,
    EmployeesStruct Function(EmployeesStruct) updateFn,
  ) {
    employeesNotHired[index] = updateFn(_employeesNotHired[index]);
  }

  void insertAtIndexInEmployeesNotHired(int index, EmployeesStruct value) {
    employeesNotHired.insert(index, value);
  }

  bool _loadingDialog = false;
  bool get loadingDialog => _loadingDialog;
  set loadingDialog(bool value) {
    _loadingDialog = value;
  }

  /// business and services results from normal search.
  ///
  /// events and products soon
  NormalSearchResultsStruct _normalSearchResults =
      NormalSearchResultsStruct.fromSerializableMap(
          jsonDecode('{\"services\":\"[]\",\"businesses\":\"[]\"}'));
  NormalSearchResultsStruct get normalSearchResults => _normalSearchResults;
  set normalSearchResults(NormalSearchResultsStruct value) {
    _normalSearchResults = value;
  }

  void updateNormalSearchResultsStruct(
      Function(NormalSearchResultsStruct) updateFn) {
    updateFn(_normalSearchResults);
  }

  BusinessServicesStruct _editService = BusinessServicesStruct();
  BusinessServicesStruct get editService => _editService;
  set editService(BusinessServicesStruct value) {
    _editService = value;
  }

  void updateEditServiceStruct(Function(BusinessServicesStruct) updateFn) {
    updateFn(_editService);
  }

  List<DateTime> _highPricesList = [
    DateTime.fromMillisecondsSinceEpoch(1742078640000),
    DateTime.fromMillisecondsSinceEpoch(1742165040000),
    DateTime.fromMillisecondsSinceEpoch(1742683440000)
  ];
  List<DateTime> get highPricesList => _highPricesList;
  set highPricesList(List<DateTime> value) {
    _highPricesList = value;
  }

  void addToHighPricesList(DateTime value) {
    highPricesList.add(value);
  }

  void removeFromHighPricesList(DateTime value) {
    highPricesList.remove(value);
  }

  void removeAtIndexFromHighPricesList(int index) {
    highPricesList.removeAt(index);
  }

  void updateHighPricesListAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    highPricesList[index] = updateFn(_highPricesList[index]);
  }

  void insertAtIndexInHighPricesList(int index, DateTime value) {
    highPricesList.insert(index, value);
  }

  List<DateTime> _notAvalaibleList = [
    DateTime.fromMillisecondsSinceEpoch(1742339400000),
    DateTime.fromMillisecondsSinceEpoch(1742512200000),
    DateTime.fromMillisecondsSinceEpoch(1742944260000)
  ];
  List<DateTime> get notAvalaibleList => _notAvalaibleList;
  set notAvalaibleList(List<DateTime> value) {
    _notAvalaibleList = value;
  }

  void addToNotAvalaibleList(DateTime value) {
    notAvalaibleList.add(value);
  }

  void removeFromNotAvalaibleList(DateTime value) {
    notAvalaibleList.remove(value);
  }

  void removeAtIndexFromNotAvalaibleList(int index) {
    notAvalaibleList.removeAt(index);
  }

  void updateNotAvalaibleListAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    notAvalaibleList[index] = updateFn(_notAvalaibleList[index]);
  }

  void insertAtIndexInNotAvalaibleList(int index, DateTime value) {
    notAvalaibleList.insert(index, value);
  }

  ClientPages? _clientDashboardPage = ClientPages.requests;
  ClientPages? get clientDashboardPage => _clientDashboardPage;
  set clientDashboardPage(ClientPages? value) {
    _clientDashboardPage = value;
  }

  BusinessLeadsStruct _selectedLeadDetail = BusinessLeadsStruct();
  BusinessLeadsStruct get selectedLeadDetail => _selectedLeadDetail;
  set selectedLeadDetail(BusinessLeadsStruct value) {
    _selectedLeadDetail = value;
  }

  void updateSelectedLeadDetailStruct(Function(BusinessLeadsStruct) updateFn) {
    updateFn(_selectedLeadDetail);
  }

  ClientDataProfileStruct _clientProfile = ClientDataProfileStruct();
  ClientDataProfileStruct get clientProfile => _clientProfile;
  set clientProfile(ClientDataProfileStruct value) {
    _clientProfile = value;
  }

  void updateClientProfileStruct(Function(ClientDataProfileStruct) updateFn) {
    updateFn(_clientProfile);
  }

  List<BusinessDataStruct> _clientRequestBusinesses = [];
  List<BusinessDataStruct> get clientRequestBusinesses =>
      _clientRequestBusinesses;
  set clientRequestBusinesses(List<BusinessDataStruct> value) {
    _clientRequestBusinesses = value;
  }

  void addToClientRequestBusinesses(BusinessDataStruct value) {
    clientRequestBusinesses.add(value);
  }

  void removeFromClientRequestBusinesses(BusinessDataStruct value) {
    clientRequestBusinesses.remove(value);
  }

  void removeAtIndexFromClientRequestBusinesses(int index) {
    clientRequestBusinesses.removeAt(index);
  }

  void updateClientRequestBusinessesAtIndex(
    int index,
    BusinessDataStruct Function(BusinessDataStruct) updateFn,
  ) {
    clientRequestBusinesses[index] = updateFn(_clientRequestBusinesses[index]);
  }

  void insertAtIndexInClientRequestBusinesses(
      int index, BusinessDataStruct value) {
    clientRequestBusinesses.insert(index, value);
  }

  List<int> _clientRequestLeadIds = [];
  List<int> get clientRequestLeadIds => _clientRequestLeadIds;
  set clientRequestLeadIds(List<int> value) {
    _clientRequestLeadIds = value;
  }

  void addToClientRequestLeadIds(int value) {
    clientRequestLeadIds.add(value);
  }

  void removeFromClientRequestLeadIds(int value) {
    clientRequestLeadIds.remove(value);
  }

  void removeAtIndexFromClientRequestLeadIds(int index) {
    clientRequestLeadIds.removeAt(index);
  }

  void updateClientRequestLeadIdsAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    clientRequestLeadIds[index] = updateFn(_clientRequestLeadIds[index]);
  }

  void insertAtIndexInClientRequestLeadIds(int index, int value) {
    clientRequestLeadIds.insert(index, value);
  }

  int _loopCounts = 0;
  int get loopCounts => _loopCounts;
  set loopCounts(int value) {
    _loopCounts = value;
  }

  List<ClientRequestQuoteStruct> _clientRequestQuotes = [];
  List<ClientRequestQuoteStruct> get clientRequestQuotes =>
      _clientRequestQuotes;
  set clientRequestQuotes(List<ClientRequestQuoteStruct> value) {
    _clientRequestQuotes = value;
  }

  void addToClientRequestQuotes(ClientRequestQuoteStruct value) {
    clientRequestQuotes.add(value);
  }

  void removeFromClientRequestQuotes(ClientRequestQuoteStruct value) {
    clientRequestQuotes.remove(value);
  }

  void removeAtIndexFromClientRequestQuotes(int index) {
    clientRequestQuotes.removeAt(index);
  }

  void updateClientRequestQuotesAtIndex(
    int index,
    ClientRequestQuoteStruct Function(ClientRequestQuoteStruct) updateFn,
  ) {
    clientRequestQuotes[index] = updateFn(_clientRequestQuotes[index]);
  }

  void insertAtIndexInClientRequestQuotes(
      int index, ClientRequestQuoteStruct value) {
    clientRequestQuotes.insert(index, value);
  }

  double _swipePosition = 0.0;
  double get swipePosition => _swipePosition;
  set swipePosition(double value) {
    _swipePosition = value;
  }

  bool _swipeConfirmed = false;
  bool get swipeConfirmed => _swipeConfirmed;
  set swipeConfirmed(bool value) {
    _swipeConfirmed = value;
  }

  ClientRequestQuoteStruct _clientRequestAcceptedQuote =
      ClientRequestQuoteStruct();
  ClientRequestQuoteStruct get clientRequestAcceptedQuote =>
      _clientRequestAcceptedQuote;
  set clientRequestAcceptedQuote(ClientRequestQuoteStruct value) {
    _clientRequestAcceptedQuote = value;
  }

  void updateClientRequestAcceptedQuoteStruct(
      Function(ClientRequestQuoteStruct) updateFn) {
    updateFn(_clientRequestAcceptedQuote);
  }

  BusinessDataStruct _clientRequestAcceptedBusiness = BusinessDataStruct();
  BusinessDataStruct get clientRequestAcceptedBusiness =>
      _clientRequestAcceptedBusiness;
  set clientRequestAcceptedBusiness(BusinessDataStruct value) {
    _clientRequestAcceptedBusiness = value;
  }

  void updateClientRequestAcceptedBusinessStruct(
      Function(BusinessDataStruct) updateFn) {
    updateFn(_clientRequestAcceptedBusiness);
  }

  List<ClientPaymentsStruct> _clientPayments = [];
  List<ClientPaymentsStruct> get clientPayments => _clientPayments;
  set clientPayments(List<ClientPaymentsStruct> value) {
    _clientPayments = value;
  }

  void addToClientPayments(ClientPaymentsStruct value) {
    clientPayments.add(value);
  }

  void removeFromClientPayments(ClientPaymentsStruct value) {
    clientPayments.remove(value);
  }

  void removeAtIndexFromClientPayments(int index) {
    clientPayments.removeAt(index);
  }

  void updateClientPaymentsAtIndex(
    int index,
    ClientPaymentsStruct Function(ClientPaymentsStruct) updateFn,
  ) {
    clientPayments[index] = updateFn(_clientPayments[index]);
  }

  void insertAtIndexInClientPayments(int index, ClientPaymentsStruct value) {
    clientPayments.insert(index, value);
  }

  ClientPaymentMethodsStruct _selectedClientPaymentMethod =
      ClientPaymentMethodsStruct();
  ClientPaymentMethodsStruct get selectedClientPaymentMethod =>
      _selectedClientPaymentMethod;
  set selectedClientPaymentMethod(ClientPaymentMethodsStruct value) {
    _selectedClientPaymentMethod = value;
  }

  void updateSelectedClientPaymentMethodStruct(
      Function(ClientPaymentMethodsStruct) updateFn) {
    updateFn(_selectedClientPaymentMethod);
  }

  List<ClientRequestStruct> _clientRequests = [];
  List<ClientRequestStruct> get clientRequests => _clientRequests;
  set clientRequests(List<ClientRequestStruct> value) {
    _clientRequests = value;
  }

  void addToClientRequests(ClientRequestStruct value) {
    clientRequests.add(value);
  }

  void removeFromClientRequests(ClientRequestStruct value) {
    clientRequests.remove(value);
  }

  void removeAtIndexFromClientRequests(int index) {
    clientRequests.removeAt(index);
  }

  void updateClientRequestsAtIndex(
    int index,
    ClientRequestStruct Function(ClientRequestStruct) updateFn,
  ) {
    clientRequests[index] = updateFn(_clientRequests[index]);
  }

  void insertAtIndexInClientRequests(int index, ClientRequestStruct value) {
    clientRequests.insert(index, value);
  }

  List<ServiceDataStruct> _servicesData = [];
  List<ServiceDataStruct> get servicesData => _servicesData;
  set servicesData(List<ServiceDataStruct> value) {
    _servicesData = value;
  }

  void addToServicesData(ServiceDataStruct value) {
    servicesData.add(value);
  }

  void removeFromServicesData(ServiceDataStruct value) {
    servicesData.remove(value);
  }

  void removeAtIndexFromServicesData(int index) {
    servicesData.removeAt(index);
  }

  void updateServicesDataAtIndex(
    int index,
    ServiceDataStruct Function(ServiceDataStruct) updateFn,
  ) {
    servicesData[index] = updateFn(_servicesData[index]);
  }

  void insertAtIndexInServicesData(int index, ServiceDataStruct value) {
    servicesData.insert(index, value);
  }

  BookingDataStruct _businessBookingssss = BookingDataStruct();
  BookingDataStruct get businessBookingssss => _businessBookingssss;
  set businessBookingssss(BookingDataStruct value) {
    _businessBookingssss = value;
  }

  void updateBusinessBookingssssStruct(Function(BookingDataStruct) updateFn) {
    updateFn(_businessBookingssss);
  }

  ClientRequestFullDataStruct _clientRequestFull =
      ClientRequestFullDataStruct();
  ClientRequestFullDataStruct get clientRequestFull => _clientRequestFull;
  set clientRequestFull(ClientRequestFullDataStruct value) {
    _clientRequestFull = value;
  }

  void updateClientRequestFullStruct(
      Function(ClientRequestFullDataStruct) updateFn) {
    updateFn(_clientRequestFull);
  }

  QuoteFullDataStruct _clientRequestAcceptedQuote2 = QuoteFullDataStruct();
  QuoteFullDataStruct get clientRequestAcceptedQuote2 =>
      _clientRequestAcceptedQuote2;
  set clientRequestAcceptedQuote2(QuoteFullDataStruct value) {
    _clientRequestAcceptedQuote2 = value;
  }

  void updateClientRequestAcceptedQuote2Struct(
      Function(QuoteFullDataStruct) updateFn) {
    updateFn(_clientRequestAcceptedQuote2);
  }

  QuoteDataStruct _businessLeadAcceptedQuote = QuoteDataStruct();
  QuoteDataStruct get businessLeadAcceptedQuote => _businessLeadAcceptedQuote;
  set businessLeadAcceptedQuote(QuoteDataStruct value) {
    _businessLeadAcceptedQuote = value;
  }

  void updateBusinessLeadAcceptedQuoteStruct(
      Function(QuoteDataStruct) updateFn) {
    updateFn(_businessLeadAcceptedQuote);
  }

  BookingDataStruct _businessLeadBooking = BookingDataStruct();
  BookingDataStruct get businessLeadBooking => _businessLeadBooking;
  set businessLeadBooking(BookingDataStruct value) {
    _businessLeadBooking = value;
  }

  void updateBusinessLeadBookingStruct(Function(BookingDataStruct) updateFn) {
    updateFn(_businessLeadBooking);
  }

  BookingDataStruct _clientDashboardBooking = BookingDataStruct();
  BookingDataStruct get clientDashboardBooking => _clientDashboardBooking;
  set clientDashboardBooking(BookingDataStruct value) {
    _clientDashboardBooking = value;
  }

  void updateClientDashboardBookingStruct(
      Function(BookingDataStruct) updateFn) {
    updateFn(_clientDashboardBooking);
  }

  List<TransactionsDataStruct> _transactions = [];
  List<TransactionsDataStruct> get transactions => _transactions;
  set transactions(List<TransactionsDataStruct> value) {
    _transactions = value;
  }

  void addToTransactions(TransactionsDataStruct value) {
    transactions.add(value);
  }

  void removeFromTransactions(TransactionsDataStruct value) {
    transactions.remove(value);
  }

  void removeAtIndexFromTransactions(int index) {
    transactions.removeAt(index);
  }

  void updateTransactionsAtIndex(
    int index,
    TransactionsDataStruct Function(TransactionsDataStruct) updateFn,
  ) {
    transactions[index] = updateFn(_transactions[index]);
  }

  void insertAtIndexInTransactions(int index, TransactionsDataStruct value) {
    transactions.insert(index, value);
  }

  List<TransactionsDataStruct> _businessTransactions = [];
  List<TransactionsDataStruct> get businessTransactions =>
      _businessTransactions;
  set businessTransactions(List<TransactionsDataStruct> value) {
    _businessTransactions = value;
  }

  void addToBusinessTransactions(TransactionsDataStruct value) {
    businessTransactions.add(value);
  }

  void removeFromBusinessTransactions(TransactionsDataStruct value) {
    businessTransactions.remove(value);
  }

  void removeAtIndexFromBusinessTransactions(int index) {
    businessTransactions.removeAt(index);
  }

  void updateBusinessTransactionsAtIndex(
    int index,
    TransactionsDataStruct Function(TransactionsDataStruct) updateFn,
  ) {
    businessTransactions[index] = updateFn(_businessTransactions[index]);
  }

  void insertAtIndexInBusinessTransactions(
      int index, TransactionsDataStruct value) {
    businessTransactions.insert(index, value);
  }

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;
  set selectedTabIndex(int value) {
    _selectedTabIndex = value;
    prefs.setInt('ff_selectedTabIndex', value);
  }

  int _dashboardTabIndex = 0;
  int get dashboardTabIndex => _dashboardTabIndex;
  set dashboardTabIndex(int value) {
    _dashboardTabIndex = value;
  }

  List<ClientBookingsFullDataStruct> _clientBookings = [];
  List<ClientBookingsFullDataStruct> get clientBookings => _clientBookings;
  set clientBookings(List<ClientBookingsFullDataStruct> value) {
    _clientBookings = value;
  }

  void addToClientBookings(ClientBookingsFullDataStruct value) {
    clientBookings.add(value);
  }

  void removeFromClientBookings(ClientBookingsFullDataStruct value) {
    clientBookings.remove(value);
  }

  void removeAtIndexFromClientBookings(int index) {
    clientBookings.removeAt(index);
  }

  void updateClientBookingsAtIndex(
    int index,
    ClientBookingsFullDataStruct Function(ClientBookingsFullDataStruct)
        updateFn,
  ) {
    clientBookings[index] = updateFn(_clientBookings[index]);
  }

  void insertAtIndexInClientBookings(
      int index, ClientBookingsFullDataStruct value) {
    clientBookings.insert(index, value);
  }

  List<BusinessBookingsFullDataStruct> _businessBookings = [];
  List<BusinessBookingsFullDataStruct> get businessBookings =>
      _businessBookings;
  set businessBookings(List<BusinessBookingsFullDataStruct> value) {
    _businessBookings = value;
  }

  void addToBusinessBookings(BusinessBookingsFullDataStruct value) {
    businessBookings.add(value);
  }

  void removeFromBusinessBookings(BusinessBookingsFullDataStruct value) {
    businessBookings.remove(value);
  }

  void removeAtIndexFromBusinessBookings(int index) {
    businessBookings.removeAt(index);
  }

  void updateBusinessBookingsAtIndex(
    int index,
    BusinessBookingsFullDataStruct Function(BusinessBookingsFullDataStruct)
        updateFn,
  ) {
    businessBookings[index] = updateFn(_businessBookings[index]);
  }

  void insertAtIndexInBusinessBookings(
      int index, BusinessBookingsFullDataStruct value) {
    businessBookings.insert(index, value);
  }

  List<ClientRequestFullDataStruct> _clientRequestsFull = [];
  List<ClientRequestFullDataStruct> get clientRequestsFull =>
      _clientRequestsFull;
  set clientRequestsFull(List<ClientRequestFullDataStruct> value) {
    _clientRequestsFull = value;
  }

  void addToClientRequestsFull(ClientRequestFullDataStruct value) {
    clientRequestsFull.add(value);
  }

  void removeFromClientRequestsFull(ClientRequestFullDataStruct value) {
    clientRequestsFull.remove(value);
  }

  void removeAtIndexFromClientRequestsFull(int index) {
    clientRequestsFull.removeAt(index);
  }

  void updateClientRequestsFullAtIndex(
    int index,
    ClientRequestFullDataStruct Function(ClientRequestFullDataStruct) updateFn,
  ) {
    clientRequestsFull[index] = updateFn(_clientRequestsFull[index]);
  }

  void insertAtIndexInClientRequestsFull(
      int index, ClientRequestFullDataStruct value) {
    clientRequestsFull.insert(index, value);
  }

  List<ResourceDataStruct> _businessResources = [];
  List<ResourceDataStruct> get businessResources => _businessResources;
  set businessResources(List<ResourceDataStruct> value) {
    _businessResources = value;
  }

  void addToBusinessResources(ResourceDataStruct value) {
    businessResources.add(value);
  }

  void removeFromBusinessResources(ResourceDataStruct value) {
    businessResources.remove(value);
  }

  void removeAtIndexFromBusinessResources(int index) {
    businessResources.removeAt(index);
  }

  void updateBusinessResourcesAtIndex(
    int index,
    ResourceDataStruct Function(ResourceDataStruct) updateFn,
  ) {
    businessResources[index] = updateFn(_businessResources[index]);
  }

  void insertAtIndexInBusinessResources(int index, ResourceDataStruct value) {
    businessResources.insert(index, value);
  }

  List<ContactDataStruct> _contacts = [];
  List<ContactDataStruct> get contacts => _contacts;
  set contacts(List<ContactDataStruct> value) {
    _contacts = value;
  }

  void addToContacts(ContactDataStruct value) {
    contacts.add(value);
  }

  void removeFromContacts(ContactDataStruct value) {
    contacts.remove(value);
  }

  void removeAtIndexFromContacts(int index) {
    contacts.removeAt(index);
  }

  void updateContactsAtIndex(
    int index,
    ContactDataStruct Function(ContactDataStruct) updateFn,
  ) {
    contacts[index] = updateFn(_contacts[index]);
  }

  void insertAtIndexInContacts(int index, ContactDataStruct value) {
    contacts.insert(index, value);
  }

  GregTrainPages? _gregTrainPage;
  GregTrainPages? get gregTrainPage => _gregTrainPage;
  set gregTrainPage(GregTrainPages? value) {
    _gregTrainPage = value;
  }

  String _updateMessage = '';
  String get updateMessage => _updateMessage;
  set updateMessage(String value) {
    _updateMessage = value;
  }

  String _apnsStatus = 'buenas tardes';
  String get apnsStatus => _apnsStatus;
  set apnsStatus(String value) {
    _apnsStatus = value;
  }

  String _fcmToken = 'NoToken';
  String get fcmToken => _fcmToken;
  set fcmToken(String value) {
    _fcmToken = value;
  }

  List<String> _examplesIDlist = ['0', '1', '2', '3', '4'];
  List<String> get examplesIDlist => _examplesIDlist;
  set examplesIDlist(List<String> value) {
    _examplesIDlist = value;
    prefs.setStringList('ff_examplesIDlist', value);
  }

  void addToExamplesIDlist(String value) {
    examplesIDlist.add(value);
    prefs.setStringList('ff_examplesIDlist', _examplesIDlist);
  }

  void removeFromExamplesIDlist(String value) {
    examplesIDlist.remove(value);
    prefs.setStringList('ff_examplesIDlist', _examplesIDlist);
  }

  void removeAtIndexFromExamplesIDlist(int index) {
    examplesIDlist.removeAt(index);
    prefs.setStringList('ff_examplesIDlist', _examplesIDlist);
  }

  void updateExamplesIDlistAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    examplesIDlist[index] = updateFn(_examplesIDlist[index]);
    prefs.setStringList('ff_examplesIDlist', _examplesIDlist);
  }

  void insertAtIndexInExamplesIDlist(int index, String value) {
    examplesIDlist.insert(index, value);
    prefs.setStringList('ff_examplesIDlist', _examplesIDlist);
  }

  List<int> _exampleNumberList = [20, 40, 60, 80];
  List<int> get exampleNumberList => _exampleNumberList;
  set exampleNumberList(List<int> value) {
    _exampleNumberList = value;
    prefs.setStringList(
        'ff_exampleNumberList', value.map((x) => x.toString()).toList());
  }

  void addToExampleNumberList(int value) {
    exampleNumberList.add(value);
    prefs.setStringList('ff_exampleNumberList',
        _exampleNumberList.map((x) => x.toString()).toList());
  }

  void removeFromExampleNumberList(int value) {
    exampleNumberList.remove(value);
    prefs.setStringList('ff_exampleNumberList',
        _exampleNumberList.map((x) => x.toString()).toList());
  }

  void removeAtIndexFromExampleNumberList(int index) {
    exampleNumberList.removeAt(index);
    prefs.setStringList('ff_exampleNumberList',
        _exampleNumberList.map((x) => x.toString()).toList());
  }

  void updateExampleNumberListAtIndex(
    int index,
    int Function(int) updateFn,
  ) {
    exampleNumberList[index] = updateFn(_exampleNumberList[index]);
    prefs.setStringList('ff_exampleNumberList',
        _exampleNumberList.map((x) => x.toString()).toList());
  }

  void insertAtIndexInExampleNumberList(int index, int value) {
    exampleNumberList.insert(index, value);
    prefs.setStringList('ff_exampleNumberList',
        _exampleNumberList.map((x) => x.toString()).toList());
  }

  List<double> _exampleQuantiWeek = [10.2, 20.0, 34.0, 25.0, 50.0, 10.0, 4.0];
  List<double> get exampleQuantiWeek => _exampleQuantiWeek;
  set exampleQuantiWeek(List<double> value) {
    _exampleQuantiWeek = value;
  }

  void addToExampleQuantiWeek(double value) {
    exampleQuantiWeek.add(value);
  }

  void removeFromExampleQuantiWeek(double value) {
    exampleQuantiWeek.remove(value);
  }

  void removeAtIndexFromExampleQuantiWeek(int index) {
    exampleQuantiWeek.removeAt(index);
  }

  void updateExampleQuantiWeekAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    exampleQuantiWeek[index] = updateFn(_exampleQuantiWeek[index]);
  }

  void insertAtIndexInExampleQuantiWeek(int index, double value) {
    exampleQuantiWeek.insert(index, value);
  }

  List<double> _exampleQuantiMonths = [
    120.0,
    50.0,
    38.0,
    200.0,
    137.0,
    62.0,
    77.0,
    90.0,
    210.0,
    0.0,
    22.0,
    98.0
  ];
  List<double> get exampleQuantiMonths => _exampleQuantiMonths;
  set exampleQuantiMonths(List<double> value) {
    _exampleQuantiMonths = value;
  }

  void addToExampleQuantiMonths(double value) {
    exampleQuantiMonths.add(value);
  }

  void removeFromExampleQuantiMonths(double value) {
    exampleQuantiMonths.remove(value);
  }

  void removeAtIndexFromExampleQuantiMonths(int index) {
    exampleQuantiMonths.removeAt(index);
  }

  void updateExampleQuantiMonthsAtIndex(
    int index,
    double Function(double) updateFn,
  ) {
    exampleQuantiMonths[index] = updateFn(_exampleQuantiMonths[index]);
  }

  void insertAtIndexInExampleQuantiMonths(int index, double value) {
    exampleQuantiMonths.insert(index, value);
  }

  List<dynamic> _TEMPSTATE = [];
  List<dynamic> get TEMPSTATE => _TEMPSTATE;
  set TEMPSTATE(List<dynamic> value) {
    _TEMPSTATE = value;
  }

  void addToTEMPSTATE(dynamic value) {
    TEMPSTATE.add(value);
  }

  void removeFromTEMPSTATE(dynamic value) {
    TEMPSTATE.remove(value);
  }

  void removeAtIndexFromTEMPSTATE(int index) {
    TEMPSTATE.removeAt(index);
  }

  void updateTEMPSTATEAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    TEMPSTATE[index] = updateFn(_TEMPSTATE[index]);
  }

  void insertAtIndexInTEMPSTATE(int index, dynamic value) {
    TEMPSTATE.insert(index, value);
  }

  dynamic _TEMPSTATEJSON;
  dynamic get TEMPSTATEJSON => _TEMPSTATEJSON;
  set TEMPSTATEJSON(dynamic value) {
    _TEMPSTATEJSON = value;
  }

  BusinessRegistrationStruct _businessRegistration =
      BusinessRegistrationStruct();
  BusinessRegistrationStruct get businessRegistration => _businessRegistration;
  set businessRegistration(BusinessRegistrationStruct value) {
    _businessRegistration = value;
  }

  void updateBusinessRegistrationStruct(
      Function(BusinessRegistrationStruct) updateFn) {
    updateFn(_businessRegistration);
  }

  List<BusinessClientsDataStruct> _businessClients = [];
  List<BusinessClientsDataStruct> get businessClients => _businessClients;
  set businessClients(List<BusinessClientsDataStruct> value) {
    _businessClients = value;
  }

  void addToBusinessClients(BusinessClientsDataStruct value) {
    businessClients.add(value);
  }

  void removeFromBusinessClients(BusinessClientsDataStruct value) {
    businessClients.remove(value);
  }

  void removeAtIndexFromBusinessClients(int index) {
    businessClients.removeAt(index);
  }

  void updateBusinessClientsAtIndex(
    int index,
    BusinessClientsDataStruct Function(BusinessClientsDataStruct) updateFn,
  ) {
    businessClients[index] = updateFn(_businessClients[index]);
  }

  void insertAtIndexInBusinessClients(
      int index, BusinessClientsDataStruct value) {
    businessClients.insert(index, value);
  }

  bool _temporal = false;
  bool get temporal => _temporal;
  set temporal(bool value) {
    _temporal = value;
  }

  int _balance = 0;
  int get balance => _balance;
  set balance(int value) {
    _balance = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
