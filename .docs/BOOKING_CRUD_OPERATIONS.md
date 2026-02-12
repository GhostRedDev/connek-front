# Booking CRUD Operations

## Overview
El sistema de bookings ahora tiene **CRUD completo** (Create, Read, Update, Delete) integrado con el backend FastAPI.

## ✨ Mejoras Recientes
- ✅ **Formato Consistente**: Todos los endpoints de escritura usan `application/x-www-form-urlencoded`
- ✅ **Manejo de Errores Mejorado**: Logs detallados con emojis para fácil debugging
- ✅ **Validación de Datos**: Verificación de campos antes de enviar al backend
- ✅ **Conversión UTC**: Todas las fechas se convierten automáticamente a UTC
- ✅ **Manejo de Direcciones**: Soporte para objetos de dirección anidados y planos
- ✅ **Respuestas Detalladas**: Mensajes de éxito/error específicos para cada operación

## Formato de Datos
Todos los endpoints de escritura (CREATE, UPDATE) usan **`application/x-www-form-urlencoded`** en lugar de JSON o multipart/form-data.

---

## 📋 CRUD Operations

### 1. **CREATE** - Crear Booking

#### **Cliente crea su propia reserva**
```dart
final success = await ref.read(bookingUpdateProvider).createClientBooking(
  businessId: 176,
  serviceId: 281,
  date: DateTime(2026, 2, 20, 16, 30),
  staffId: 42, // Opcional
);
```

**Backend Endpoint:** `POST /bookings/create`

**Payload:**
```
client_id=208&business_id=176&address_id=176&service_id=281&start_time_utc=2026-02-20T16:30:00.000Z&resource_id=42
```

#### **Negocio crea reserva manual para un cliente**
```dart
final success = await ref.read(bookingUpdateProvider).createManualBooking(
  clientId: 208,
  serviceId: 281,
  date: DateTime(2026, 2, 20, 16, 30),
  staffId: 42, // Opcional
);
```

**Backend Endpoint:** `POST /bookings/create`

---

### 2. **READ** - Leer Bookings

#### **Obtener todas las reservas (por rol)**
```dart
// Para negocios
final bookings = await ref.read(bookingListProvider('business').future);

// Para clientes
final bookings = await ref.read(bookingListProvider('client').future);
```

**Backend Endpoints:**
- `GET /bookings/business/{business_id}` - Reservas del negocio
- `GET /bookings/client/{client_id}` - Reservas del cliente

#### **Obtener una reserva específica**
```dart
final booking = await ref.read(bookingDetailsProvider('BK123').future);
```

**Backend Endpoint:** `GET /bookings/{booking_id}`

---

### 3. **UPDATE** - Actualizar Booking

```dart
final success = await ref.read(bookingUpdateProvider).updateBooking(
  bookingId: 'BK123',
  newDate: DateTime(2026, 2, 25, 14, 0), // Opcional
  newServiceId: 285, // Opcional
  newStaffId: 50, // Opcional
  newStatus: 'confirmed', // Opcional
  role: 'business',
);
```

**Backend Endpoint:** `PUT /bookings/{booking_id}`

**Payload (ejemplo):**
```
start_time_utc=2026-02-25T14:00:00.000Z&service_id=285&resource_id=50&status=confirmed
```

**Campos actualizables:**
- `start_time_utc` - Nueva fecha/hora
- `service_id` - Cambiar servicio
- `resource_id` - Cambiar staff asignado
- `status` - Cambiar estado (pending, confirmed, cancelled, completed)

---

### 4. **DELETE** - Eliminar Booking

```dart
final success = await ref.read(bookingUpdateProvider).deleteBooking(
  'BK123',
  'business', // rol para invalidar cache
);
```

**Backend Endpoint:** `DELETE /bookings/{booking_id}`

---

## 🔄 Métodos Auxiliares

### **Cancelar Reserva**
```dart
await ref.read(bookingUpdateProvider).cancelBooking('BK123', 'client');
```
Internamente llama a `updateBookingStatus(id, BookingStatus.cancelled)`

### **Reprogramar Reserva**
```dart
await ref.read(bookingUpdateProvider).reschedule(
  'BK123',
  DateTime(2026, 3, 1),
  '15:00',
  'business',
);
```

### **Re-reservar (Rebook)**
```dart
await ref.read(bookingUpdateProvider).rebook(
  'BK123',
  DateTime(2026, 3, 5),
  '10:00',
  '11:00',
  'client',
);
```

---

## 📊 Disponibilidad y Slots

### **Obtener slots disponibles**
```dart
final service = ref.read(bookingServiceProvider);

// Slots abiertos de un negocio
final slots = await service.getOpenSlots(
  businessId: 176,
  date: DateTime(2026, 2, 20),
);

// Disponibilidad de un recurso específico
final resourceSlots = await service.getResourceAvailableSlots(
  resourceId: 42,
  date: DateTime(2026, 2, 20),
  serviceId: 281,
);

// Disponibilidad de un servicio en rango de fechas
final availability = await service.getServiceAvailableSlots(
  businessId: 176,
  serviceId: 281,
  start: DateTime(2026, 2, 20),
  end: DateTime(2026, 2, 27),
);
```

---

## ✅ Estado de Implementación

| Operación | Servicio | Provider | Backend | Estado |
|-----------|----------|----------|---------|--------|
| CREATE (Client) | ✅ | ✅ | ✅ | **Completo** |
| CREATE (Manual) | ✅ | ✅ | ✅ | **Completo** |
| READ (List) | ✅ | ✅ | ✅ | **Completo** |
| READ (Single) | ✅ | ✅ | ✅ | **Completo** |
| UPDATE | ✅ | ✅ | ✅ | **Completo** |
| DELETE | ✅ | ✅ | ✅ | **Completo** |

---

## 🔧 Notas Técnicas

1. **Formato de Request:** Todos los endpoints de escritura usan `application/x-www-form-urlencoded`
2. **IDs:** Los IDs de booking pueden venir como `'BK123'` pero se convierten a numérico internamente
3. **Fechas:** Todas las fechas se envían en formato ISO 8601 UTC
4. **Invalidación de Cache:** Después de cada operación de escritura, se invalidan los providers relevantes
5. **Autenticación:** Todos los endpoints requieren token Bearer en el header `Authorization`

---

## 🎯 Ejemplo de Uso Completo

```dart
// 1. Cliente crea una reserva
final created = await ref.read(bookingUpdateProvider).createClientBooking(
  businessId: 176,
  serviceId: 281,
  date: DateTime(2026, 2, 20, 16, 30),
  staffId: 42,
);

// 2. Ver todas las reservas del cliente
final myBookings = await ref.read(bookingListProvider('client').future);

// 3. Actualizar la reserva (cambiar fecha)
final updated = await ref.read(bookingUpdateProvider).updateBooking(
  bookingId: myBookings.first.id,
  newDate: DateTime(2026, 2, 25, 14, 0),
  role: 'client',
);

// 4. Cancelar la reserva
await ref.read(bookingUpdateProvider).cancelBooking(
  myBookings.first.id,
  'client',
);

// 5. Eliminar la reserva
final deleted = await ref.read(bookingUpdateProvider).deleteBooking(
  myBookings.first.id,
  'client',
);
```

---

## 🐛 Debugging

### **Logs del Sistema**

El sistema ahora incluye logs mejorados con emojis para facilitar el debugging:

```
📤 CreateClientBooking: Sending payload: {client_id: 208, business_id: 176, ...}
✅ CreateClientBooking: Success - Booking created

📤 UpdateBooking [123]: Sending payload: {start_time_utc: 2026-02-25T14:00:00.000Z}
✅ UpdateBooking [123]: Success

⚠️ CreateClientBooking: Failed - Validation Error
❌ Error creating client booking: Exception: API Error (422): ...
```

### **Tipos de Logs**

| Emoji | Significado | Nivel |
|-------|-------------|-------|
| 📤 | Request enviado | Info |
| ✅ | Operación exitosa | Success |
| ⚠️ | Operación fallida (respuesta del servidor) | Warning |
| ❌ | Error de excepción | Error |

### **Problemas Comunes**

#### **Error 422: Validation Error**
```
❌ Error: Field required - client_id, business_id, address_id
```
**Solución:** Verificar que todos los campos requeridos estén presentes en el payload.

#### **Error: Failed to fetch**
```
❌ API POST Form Error: ClientException: Failed to fetch
```
**Solución:** 
- Verificar que el backend esté corriendo
- Revisar CORS configuration
- Confirmar que el endpoint acepta `application/x-www-form-urlencoded`

#### **Error: address_id = 0**
```
⚠️ Using address_id=0 (fallback), backend may use business_id
```
**Solución:** El sistema usa `business_id` como fallback. Verificar que el negocio tenga una dirección configurada.

---

## 📝 Changelog

### v2.0.0 - 2026-02-09
- ✅ Agregado método `updateBooking()` para completar CRUD
- ✅ Unificado formato de requests a `application/x-www-form-urlencoded`
- ✅ Mejorado manejo de errores con logs detallados
- ✅ Agregada conversión automática a UTC en todas las fechas
- ✅ Mejorado manejo de `address_id` con soporte para objetos anidados
- ✅ Agregada validación de campos antes de enviar requests
- ✅ Documentación completa con ejemplos de uso
