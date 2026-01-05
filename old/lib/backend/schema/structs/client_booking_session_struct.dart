// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ClientBookingSessionStruct extends BaseStruct {
  ClientBookingSessionStruct({
    ServiceDataStruct? services,
    BusinessDataStruct? business,
    List<ResourceDataStruct>? resources,
    List<BookingSlotStruct>? slots,
    DateTime? daySelected,
    BookingSlotStruct? slotSelected,
    ClientRequestStruct? request,
    ResourceDataStruct? resourceSelected,
  })  : _services = services,
        _business = business,
        _resources = resources,
        _slots = slots,
        _daySelected = daySelected,
        _slotSelected = slotSelected,
        _request = request,
        _resourceSelected = resourceSelected;

  // "services" field.
  ServiceDataStruct? _services;
  ServiceDataStruct get services => _services ?? ServiceDataStruct();
  set services(ServiceDataStruct? val) => _services = val;

  void updateServices(Function(ServiceDataStruct) updateFn) {
    updateFn(_services ??= ServiceDataStruct());
  }

  bool hasServices() => _services != null;

  // "business" field.
  BusinessDataStruct? _business;
  BusinessDataStruct get business => _business ?? BusinessDataStruct();
  set business(BusinessDataStruct? val) => _business = val;

  void updateBusiness(Function(BusinessDataStruct) updateFn) {
    updateFn(_business ??= BusinessDataStruct());
  }

  bool hasBusiness() => _business != null;

  // "resources" field.
  List<ResourceDataStruct>? _resources;
  List<ResourceDataStruct> get resources => _resources ?? const [];
  set resources(List<ResourceDataStruct>? val) => _resources = val;

  void updateResources(Function(List<ResourceDataStruct>) updateFn) {
    updateFn(_resources ??= []);
  }

  bool hasResources() => _resources != null;

  // "slots" field.
  List<BookingSlotStruct>? _slots;
  List<BookingSlotStruct> get slots => _slots ?? const [];
  set slots(List<BookingSlotStruct>? val) => _slots = val;

  void updateSlots(Function(List<BookingSlotStruct>) updateFn) {
    updateFn(_slots ??= []);
  }

  bool hasSlots() => _slots != null;

  // "daySelected" field.
  DateTime? _daySelected;
  DateTime? get daySelected => _daySelected;
  set daySelected(DateTime? val) => _daySelected = val;

  bool hasDaySelected() => _daySelected != null;

  // "slotSelected" field.
  BookingSlotStruct? _slotSelected;
  BookingSlotStruct get slotSelected => _slotSelected ?? BookingSlotStruct();
  set slotSelected(BookingSlotStruct? val) => _slotSelected = val;

  void updateSlotSelected(Function(BookingSlotStruct) updateFn) {
    updateFn(_slotSelected ??= BookingSlotStruct());
  }

  bool hasSlotSelected() => _slotSelected != null;

  // "request" field.
  ClientRequestStruct? _request;
  ClientRequestStruct get request => _request ?? ClientRequestStruct();
  set request(ClientRequestStruct? val) => _request = val;

  void updateRequest(Function(ClientRequestStruct) updateFn) {
    updateFn(_request ??= ClientRequestStruct());
  }

  bool hasRequest() => _request != null;

  // "resourceSelected" field.
  ResourceDataStruct? _resourceSelected;
  ResourceDataStruct get resourceSelected =>
      _resourceSelected ?? ResourceDataStruct();
  set resourceSelected(ResourceDataStruct? val) => _resourceSelected = val;

  void updateResourceSelected(Function(ResourceDataStruct) updateFn) {
    updateFn(_resourceSelected ??= ResourceDataStruct());
  }

  bool hasResourceSelected() => _resourceSelected != null;

  static ClientBookingSessionStruct fromMap(Map<String, dynamic> data) =>
      ClientBookingSessionStruct(
        services: data['services'] is ServiceDataStruct
            ? data['services']
            : ServiceDataStruct.maybeFromMap(data['services']),
        business: data['business'] is BusinessDataStruct
            ? data['business']
            : BusinessDataStruct.maybeFromMap(data['business']),
        resources: getStructList(
          data['resources'],
          ResourceDataStruct.fromMap,
        ),
        slots: getStructList(
          data['slots'],
          BookingSlotStruct.fromMap,
        ),
        daySelected: data['daySelected'] as DateTime?,
        slotSelected: data['slotSelected'] is BookingSlotStruct
            ? data['slotSelected']
            : BookingSlotStruct.maybeFromMap(data['slotSelected']),
        request: data['request'] is ClientRequestStruct
            ? data['request']
            : ClientRequestStruct.maybeFromMap(data['request']),
        resourceSelected: data['resourceSelected'] is ResourceDataStruct
            ? data['resourceSelected']
            : ResourceDataStruct.maybeFromMap(data['resourceSelected']),
      );

  static ClientBookingSessionStruct? maybeFromMap(dynamic data) => data is Map
      ? ClientBookingSessionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'services': _services?.toMap(),
        'business': _business?.toMap(),
        'resources': _resources?.map((e) => e.toMap()).toList(),
        'slots': _slots?.map((e) => e.toMap()).toList(),
        'daySelected': _daySelected,
        'slotSelected': _slotSelected?.toMap(),
        'request': _request?.toMap(),
        'resourceSelected': _resourceSelected?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'services': serializeParam(
          _services,
          ParamType.DataStruct,
        ),
        'business': serializeParam(
          _business,
          ParamType.DataStruct,
        ),
        'resources': serializeParam(
          _resources,
          ParamType.DataStruct,
          isList: true,
        ),
        'slots': serializeParam(
          _slots,
          ParamType.DataStruct,
          isList: true,
        ),
        'daySelected': serializeParam(
          _daySelected,
          ParamType.DateTime,
        ),
        'slotSelected': serializeParam(
          _slotSelected,
          ParamType.DataStruct,
        ),
        'request': serializeParam(
          _request,
          ParamType.DataStruct,
        ),
        'resourceSelected': serializeParam(
          _resourceSelected,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ClientBookingSessionStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ClientBookingSessionStruct(
        services: deserializeStructParam(
          data['services'],
          ParamType.DataStruct,
          false,
          structBuilder: ServiceDataStruct.fromSerializableMap,
        ),
        business: deserializeStructParam(
          data['business'],
          ParamType.DataStruct,
          false,
          structBuilder: BusinessDataStruct.fromSerializableMap,
        ),
        resources: deserializeStructParam<ResourceDataStruct>(
          data['resources'],
          ParamType.DataStruct,
          true,
          structBuilder: ResourceDataStruct.fromSerializableMap,
        ),
        slots: deserializeStructParam<BookingSlotStruct>(
          data['slots'],
          ParamType.DataStruct,
          true,
          structBuilder: BookingSlotStruct.fromSerializableMap,
        ),
        daySelected: deserializeParam(
          data['daySelected'],
          ParamType.DateTime,
          false,
        ),
        slotSelected: deserializeStructParam(
          data['slotSelected'],
          ParamType.DataStruct,
          false,
          structBuilder: BookingSlotStruct.fromSerializableMap,
        ),
        request: deserializeStructParam(
          data['request'],
          ParamType.DataStruct,
          false,
          structBuilder: ClientRequestStruct.fromSerializableMap,
        ),
        resourceSelected: deserializeStructParam(
          data['resourceSelected'],
          ParamType.DataStruct,
          false,
          structBuilder: ResourceDataStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ClientBookingSessionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ClientBookingSessionStruct &&
        services == other.services &&
        business == other.business &&
        listEquality.equals(resources, other.resources) &&
        listEquality.equals(slots, other.slots) &&
        daySelected == other.daySelected &&
        slotSelected == other.slotSelected &&
        request == other.request &&
        resourceSelected == other.resourceSelected;
  }

  @override
  int get hashCode => const ListEquality().hash([
        services,
        business,
        resources,
        slots,
        daySelected,
        slotSelected,
        request,
        resourceSelected
      ]);
}

ClientBookingSessionStruct createClientBookingSessionStruct({
  ServiceDataStruct? services,
  BusinessDataStruct? business,
  DateTime? daySelected,
  BookingSlotStruct? slotSelected,
  ClientRequestStruct? request,
  ResourceDataStruct? resourceSelected,
}) =>
    ClientBookingSessionStruct(
      services: services ?? ServiceDataStruct(),
      business: business ?? BusinessDataStruct(),
      daySelected: daySelected,
      slotSelected: slotSelected ?? BookingSlotStruct(),
      request: request ?? ClientRequestStruct(),
      resourceSelected: resourceSelected ?? ResourceDataStruct(),
    );
