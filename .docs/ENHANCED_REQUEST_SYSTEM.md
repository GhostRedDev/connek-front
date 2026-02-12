# Sistema de Solicitudes y Propuestas Mejorado

## 🎯 Objetivo
Hacer **estupidamente sencillo** crear solicitudes de trabajo detalladas, con detección automática de categorías y relaciones.

---

## ✨ Características Principales

### 1. **Detección Inteligente de Categorías**

La aplicación analiza automáticamente lo que escribes y sugiere categorías relevantes:

```dart
// Usuario escribe: "Necesito un corte de pelo fade y arreglar mi barba"
// 🤖 App detecta automáticamente:
- Categoría: "Belleza y Cuidado Personal"
- Keywords: 💇 Peluquería, 🧔 Barbería
```

**Palabras clave detectadas:**

| Categoría | Palabras Clave | Emoji |
|-----------|----------------|-------|
| **Belleza** | corte, pelo, barber, peluquer, fade, tinte | 💇 |
| | uñas, manicure, pedicure | 💅 |
| | masaje, spa, relax | 💆 |
| **Hogar** | plomero, tubería, fuga, leak | 🔧 |
| | electricista, luz, cable | ⚡ |
| | pintar, paint, pared | 🎨 |
| | limpieza, clean | 🧹 |
| **Eventos** | boda, wedding, matrimonio | 💒 |
| | fiesta, party, cumpleaños | 🎉 |
| | foto, fotografía | 📸 |
| **Profesional** | abogado, lawyer, legal | ⚖️ |
| | contador, contabilidad, tax | 📊 |
| **Auto** | auto, car, mecánico | 🚗 |
| **Salud** | doctor, médico, consulta | 🏥 |
| | dentista, dental | 🦷 |

### 2. **Formulario Super Detallado pero Simple**

#### **Campos del Formulario:**

```dart
✅ Título (obligatorio, mín. 5 caracteres)
   "Necesito un plomero para reparar fuga"

✅ Descripción (obligatorio, mín. 20 caracteres)
   "Tengo una fuga en el baño principal que está mojando el piso.
    Necesito que alguien venga a revisarlo lo antes posible."

🤖 Sugerencias Automáticas (basadas en descripción)
   Chips: 🔧 Plomería, 💧 Reparación de fugas

✅ Categoría (dropdown con todas las categorías)
   Selección: "Servicios del Hogar"

✅ Subcategoría (aparece después de seleccionar categoría)
   Selección: "Plomería"

💰 Presupuesto Máximo (opcional)
   Ejemplo: $250
   Nota: "Deja en blanco si prefieres recibir cotizaciones"

📍 Ubicación (opcional)
   Ejemplo: "Montreal, QC"

⏰ Urgencia (segmented button)
   Opciones:
   - 🗓️ Flexible (sin prisa)
   - 📅 Normal (esta semana)
   - 🚨 Urgente (hoy/mañana)
```

### 3. **Flujo de Usuario Mejorado**

```
1. Usuario abre "Publicar Trabajo"
   ↓
2. Escribe título y descripción
   ↓
3. 🤖 App analiza y sugiere categorías automáticamente
   ↓
4. Usuario confirma o ajusta categoría
   ↓
5. Completa detalles opcionales (presupuesto, ubicación, urgencia)
   ↓
6. Presiona "Publicar Trabajo"
   ↓
7. ✅ Solicitud enviada a negocios relevantes
```

---

## 🔧 Implementación Técnica

### **Análisis Inteligente de Texto**

```dart
void _analyzeDescription() {
  final text = _descriptionController.text.toLowerCase();
  
  // Detecta patrones con RegExp
  if (text.contains(RegExp(r'(corte|pelo|cabello|barber|peluquer|hair|fade|tinte)'))) {
    suggestions.add('Belleza y Cuidado Personal');
    keywords.add('💇 Peluquería');
  }
  
  // Actualiza UI en tiempo real
  setState(() {
    _suggestedCategories = suggestions.toSet().toList();
    _suggestedKeywords = keywords.toSet().toList();
  });
}
```

### **Payload Enviado al Backend**

```json
{
  "client_id": 208,
  "title": "Necesito un plomero para reparar fuga",
  "description": "Tengo una fuga en el baño principal...",
  "is_direct": false,
  "budget_max_cents": 25000,
  "category": "Servicios del Hogar",
  "subcategory": "Plomería",
  "location": "Montreal, QC",
  "urgency": "urgent",
  "keywords": ["🔧 Plomería", "💧 Reparación de fugas"]
}
```

---

## 🎨 Diseño Visual

### **Componentes Usados:**

- ✅ **AppText** - Tipografía consistente
- ✅ **AppInput** - Campos de entrada con placeholder
- ✅ **AppButton** - Botones con estados de loading
- ✅ **AppContainer** - Contenedores con bordes redondeados
- ✅ **AppColors** - Paleta de colores del sistema
- ✅ **AppSpacing** - Espaciado consistente

### **Tarjeta de Sugerencias:**

```dart
AppContainer(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: AppColors.primary.withOpacity(0.1),
    borderRadius: AppBorderRadius.medium,
    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
  ),
  child: Column(
    children: [
      // Ícono + Título
      Row([
        Icon(Icons.lightbulb_outline),
        Text('Detectamos que necesitas:'),
      ]),
      // Chips con keywords
      Wrap(
        children: keywords.map((k) => Chip(label: Text(k))),
      ),
    ],
  ),
)
```

---

## 📊 Ventajas del Nuevo Sistema

### **Para el Usuario (Cliente):**

1. ✅ **Más fácil**: No tiene que pensar en categorías, la app las sugiere
2. ✅ **Más rápido**: Autocompletado inteligente reduce tiempo de escritura
3. ✅ **Más detallado**: Campos opcionales para especificar mejor el trabajo
4. ✅ **Más visual**: Chips con emojis hacen la interfaz más amigable
5. ✅ **Más claro**: Indicadores de urgencia y presupuesto

### **Para el Negocio:**

1. ✅ **Mejor matching**: Reciben solicitudes más relevantes
2. ✅ **Más información**: Detalles completos para hacer propuestas precisas
3. ✅ **Filtrado automático**: Solo reciben solicitudes de su categoría
4. ✅ **Priorización**: Pueden ver urgencia y presupuesto de inmediato

---

## 🚀 Próximos Pasos

### **Fase 1: Implementación Básica** ✅
- [x] Crear formulario mejorado
- [x] Implementar detección de categorías
- [x] Agregar sugerencias inteligentes
- [x] Diseño con System UI

### **Fase 2: Integración Backend**
- [ ] Actualizar endpoint `/requests/create` para aceptar nuevos campos
- [ ] Implementar matching automático de negocios por categoría
- [ ] Crear notificaciones push para negocios relevantes

### **Fase 3: Features Avanzadas**
- [ ] Subir fotos del problema
- [ ] Selección de fecha/hora preferida con calendario
- [ ] Historial de solicitudes similares
- [ ] Estimación de precio basada en solicitudes anteriores
- [ ] Chat en vivo con negocios interesados

---

## 💡 Ejemplos de Uso

### **Ejemplo 1: Plomería Urgente**

```
Título: "Fuga de agua en el baño"
Descripción: "Tengo una fuga importante en la tubería del lavabo. 
              El agua está cayendo al piso y necesito ayuda urgente."

🤖 Detección automática:
   - Categoría: Servicios del Hogar
   - Keywords: 🔧 Plomería, 💧 Reparación de fugas
   
Usuario completa:
   - Presupuesto: $200
   - Ubicación: Montreal, QC
   - Urgencia: 🚨 Urgente
   
✅ Resultado: 5 plomeros cercanos reciben la solicitud en tiempo real
```

### **Ejemplo 2: Corte de Pelo**

```
Título: "Necesito un corte fade profesional"
Descripción: "Busco un barbero que haga buenos fades. 
              Quiero un skin fade con textura arriba."

🤖 Detección automática:
   - Categoría: Belleza y Cuidado Personal
   - Keywords: 💇 Peluquería, 🧔 Barbería
   
Usuario completa:
   - Presupuesto: $40
   - Ubicación: Montreal, QC
   - Urgencia: 📅 Normal
   
✅ Resultado: 8 barberías reciben la solicitud
```

### **Ejemplo 3: Fiesta de Cumpleaños**

```
Título: "Organización de fiesta de cumpleaños"
Descripción: "Necesito ayuda para organizar una fiesta de cumpleaños 
              para 30 personas. Busco decoración, catering y música."

🤖 Detección automática:
   - Categoría: Eventos y Entretenimiento
   - Keywords: 🎉 Fiestas, 🎂 Cumpleaños
   
Usuario completa:
   - Presupuesto: $1,500
   - Ubicación: Montreal, QC
   - Urgencia: 🗓️ Flexible
   
✅ Resultado: 12 empresas de eventos reciben la solicitud
```

---

## 🔄 Migración desde Versión Anterior

### **Cambios en el Código:**

```dart
// ANTES (create_request_page.dart)
TextField(
  controller: _descriptionController,
  decoration: InputDecoration(
    labelText: 'Descripción del trabajo',
  ),
)

// AHORA (create_request_page_v2.dart)
AppInput(
  controller: _descriptionController,
  placeholder: 'Describe qué necesitas...',
  maxLines: 6,
)
// + Análisis automático en tiempo real
// + Sugerencias de categorías
// + Chips visuales con keywords
```

### **Ruta de Navegación:**

```dart
// Actualizar en router.dart
GoRoute(
  path: '/client/create-request',
  builder: (context, state) => const CreateRequestPageV2(), // V2
),
```

---

## 📝 Notas de Desarrollo

1. **Performance**: El análisis de texto se ejecuta en cada cambio del TextField, pero es muy rápido (< 1ms)
2. **Extensibilidad**: Fácil agregar nuevas categorías y palabras clave en el futuro
3. **Localización**: Actualmente en español, pero preparado para i18n
4. **Accesibilidad**: Usa semántica correcta y contraste de colores adecuado

---

## ✅ Checklist de Implementación

- [x] Crear `create_request_page_v2.dart`
- [x] Implementar análisis de texto inteligente
- [x] Diseñar UI con System UI components
- [x] Agregar validaciones de formulario
- [x] Documentar sistema completo
- [ ] Actualizar router para usar V2
- [ ] Probar con usuarios reales
- [ ] Ajustar backend para nuevos campos
- [ ] Implementar notificaciones a negocios
