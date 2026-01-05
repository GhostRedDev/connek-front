import 'package:collection/collection.dart';

enum SearchResultTypes {
  business,
  service,
}

enum Pages {
  home,
  client,
  business,
  social,
  chat,
  profile,
  employees,
  settings,
}

enum CompanyTypes {
  individual,
  company,
}

enum BusinessPages {
  overview,
  employees,
  leads,
  settings,
  services,
  posts,
  profile,
  media,
  clients,
  sales,
  invoices,
  quotes,
  bookings,
}

enum BusinessBar {
  Home,
  Services,
  Products,
  Events,
  About,
}

enum ClientBar {
  profile,
  notifications,
  requests,
  chats,
  posts,
  wallet,
}

enum ClientPages {
  requests,
  profile,
  wallet,
  settings,
  bookings,
  activity,
  bookmark,
}

enum RequestStatus {
  completed,
  pending,
  cancelled,
}

enum LeadSteps {
  requestReceived,
  clientContacted,
}

enum DateElements {
  day,
  month,
  year,
}

enum RequestsFilter {
  all,
  completed,
  pending,
  cancelled,
  booking,
}

enum ChatsFilter {
  all,
  client,
  business,
}

enum ProfilePages {
  profile,
  media,
  reviews,
  settings,
}

enum OfficePages {
  overview,
  myBots,
  analytics,
  marketplace,
  trainGreg,
  gregSettings,
}

enum GregTrainPages {
  integrations,
  notifications,
  identity,
  conversation,
}

enum GregConversationTone {
  Friendly,
  Professional,
  Casual,
  Formal,
  Technical,
  Absolute,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (SearchResultTypes):
      return SearchResultTypes.values.deserialize(value) as T?;
    case (Pages):
      return Pages.values.deserialize(value) as T?;
    case (CompanyTypes):
      return CompanyTypes.values.deserialize(value) as T?;
    case (BusinessPages):
      return BusinessPages.values.deserialize(value) as T?;
    case (BusinessBar):
      return BusinessBar.values.deserialize(value) as T?;
    case (ClientBar):
      return ClientBar.values.deserialize(value) as T?;
    case (ClientPages):
      return ClientPages.values.deserialize(value) as T?;
    case (RequestStatus):
      return RequestStatus.values.deserialize(value) as T?;
    case (LeadSteps):
      return LeadSteps.values.deserialize(value) as T?;
    case (DateElements):
      return DateElements.values.deserialize(value) as T?;
    case (RequestsFilter):
      return RequestsFilter.values.deserialize(value) as T?;
    case (ChatsFilter):
      return ChatsFilter.values.deserialize(value) as T?;
    case (ProfilePages):
      return ProfilePages.values.deserialize(value) as T?;
    case (OfficePages):
      return OfficePages.values.deserialize(value) as T?;
    case (GregTrainPages):
      return GregTrainPages.values.deserialize(value) as T?;
    case (GregConversationTone):
      return GregConversationTone.values.deserialize(value) as T?;
    default:
      return null;
  }
}
