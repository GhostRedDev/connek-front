# 🤖 Greg AI - Asistente Inteligente Estilo ChatGPT

## 📖 Descripción

Greg es el asistente de IA personal de Connek, diseñado con una interfaz moderna inspirada en ChatGPT. Ofrece conversaciones naturales, comprensión de audio, y ayuda contextual sobre la plataforma.

## ✨ Características Principales

### 🎨 UI Estilo ChatGPT

- **Diseño Moderno**: Interfaz limpia y profesional inspirada en ChatGPT
- **Modo Oscuro/Claro**: Adaptación automática al tema del sistema
- **Mensajes Organizados**: Layout de dos columnas con avatares
- **Markdown Rendering**: Respuestas formateadas con:
  - **Negrita** y *cursiva*
  - `Código inline`
  - Bloques de código con syntax highlighting
  - Listas numeradas y con viñetas
  - Encabezados (H1, H2, H3)
  - Citas en bloque

### 🎤 Comprensión de Audio

- **Transcripción Automática**: Usa Whisper API de OpenAI
- **Soporte Multiidioma**: Detecta automáticamente español e inglés
- **Indicador Visual**: Badge especial para mensajes de audio
- **Procesamiento en Tiempo Real**: Transcribe y responde automáticamente

### 💬 Conversaciones Inteligentes

- **Contexto Persistente**: Mantiene historial de conversación
- **Respuestas Personalizadas**: Adaptadas al contexto de Connek
- **Multiidioma**: Responde en el mismo idioma que el usuario
- **Emojis Contextuales**: Usa emojis para mayor expresividad

### 🚀 Funcionalidades Avanzadas

#### 1. **Sugerencias Rápidas (Quick Prompts)**
Preguntas predefinidas para comenzar rápidamente:
- "¿Cómo puedo reservar una cita?"
- "Busca peluquerías cerca de mí"
- "¿Qué servicios ofrece Connek?"
- "Recomiéndame un restaurante"

#### 2. **Regenerar Respuestas**
- Botón para regenerar la última respuesta de Greg
- Útil si la respuesta no fue satisfactoria
- Mantiene el contexto de la conversación

#### 3. **Copiar Respuestas**
- Botón para copiar cualquier respuesta al portapapeles
- Feedback visual con SnackBar
- Útil para compartir información

#### 4. **Scroll Inteligente**
- Auto-scroll al enviar mensajes
- Botón flotante para volver al final
- Aparece solo cuando hay scroll significativo

#### 5. **Pantalla de Bienvenida**
Cuando no hay mensajes, muestra:
- Presentación de Greg
- Ejemplos de preguntas
- Capacidades del asistente
- Quick prompts interactivos

## 🎨 Paleta de Colores

### Tema Oscuro
```dart
Background: #0D0D0D
Cards: #1A1A1A
Buttons: #2F2F2F
Text Primary: #FFFFFF
Text Secondary: #B4B4B4
Text Muted: #6B6B6B
Accent: #10A37F (Verde ChatGPT)
User Bubble: #5B5BD6 (Púrpura)
```

### Tema Claro
```dart
Background: #F7F7F8
Cards: #FFFFFF
Buttons: #F0F0F0
Text Primary: #1F1F1F
Text Secondary: #6B6B6B
Text Muted: #B4B4B4
Accent: #10A37F (Verde ChatGPT)
User Bubble: #5B5BD6 (Púrpura)
```

## 🔧 Configuración

### 1. API Key de OpenAI

Necesitas configurar tu API key de OpenAI. Hay dos opciones:

#### Opción A: Variable de Entorno (Recomendado)
```bash
flutter run --dart-define=OPENAI_API_KEY=tu_api_key_aqui
```

#### Opción B: Hardcoded (Solo para desarrollo)
```dart
// En greg_ai_service.dart
GregAIService({
  required this.apiKey, // Pasar directamente
  this.baseUrl = 'https://api.openai.com/v1',
});
```

### 2. Modelos Utilizados

- **Chat**: `gpt-3.5-turbo` (puedes cambiar a `gpt-4` para mejores respuestas)
- **Audio**: `whisper-1` (transcripción de audio)

### 3. Parámetros de Configuración

```dart
// En sendMessage()
{
  'model': 'gpt-3.5-turbo',
  'max_tokens': 800,           // Longitud máxima de respuesta
  'temperature': 0.7,          // Creatividad (0.0 - 1.0)
  'presence_penalty': 0.6,     // Evita repetición
  'frequency_penalty': 0.3,    // Variedad en respuestas
}
```

## 📱 Uso

### Enviar Mensaje de Texto

```dart
await ref.read(gregConversationProvider.notifier).sendMessage('Hola Greg');
```

### Enviar Audio

```dart
final audioFile = File('/path/to/audio.m4a');
await ref.read(gregConversationProvider.notifier).sendAudio(audioFile);
```

### Regenerar Última Respuesta

```dart
await ref.read(gregConversationProvider.notifier).regenerateLastResponse();
```

### Limpiar Conversación

```dart
ref.read(gregConversationProvider.notifier).clearConversation();
```

## 🎯 Casos de Uso

### 1. Ayuda con Reservas
```
Usuario: "¿Cómo reservo una cita?"
Greg: "¡Claro! Reservar una cita en Connek es muy fácil 📅

1. **Busca** el negocio que te interesa
2. **Selecciona** el servicio que necesitas
3. **Elige** fecha y hora disponible
4. **Confirma** tu reserva

¿Necesitas ayuda con algún paso específico?"
```

### 2. Búsqueda de Servicios
```
Usuario: "Busca peluquerías cerca de mí"
Greg: "Para buscar peluquerías cerca de ti:

1. Ve a la pestaña **Explorar** 🔍
2. Usa el filtro de **Categorías**
3. Selecciona **Belleza > Peluquerías**
4. Activa la **ubicación** para ver las más cercanas

¿Te gustaría que te explique cómo filtrar por calificaciones o precios?"
```

### 3. Preguntas sobre la Plataforma
```
Usuario: "¿Qué servicios ofrece Connek?"
Greg: "Connek es una plataforma que conecta usuarios con negocios locales. Ofrece:

**Servicios Principales:**
- 💇 Belleza y cuidado personal
- 🍽️ Restaurantes y comida
- 🔧 Servicios técnicos y reparaciones
- 🏋️ Fitness y bienestar
- 🎓 Educación y cursos
- Y mucho más...

**Funcionalidades:**
- Reservas en línea
- Chat directo con negocios
- Reseñas y calificaciones
- Pagos seguros

¿Sobre qué categoría te gustaría saber más?"
```

### 4. Audio (Transcripción)
```
Usuario: [Envía audio] "Hola Greg, necesito encontrar un mecánico"
Greg: [Transcribe automáticamente]
"¡Hola! Claro, te ayudo a encontrar un mecánico 🔧

Para buscar mecánicos en Connek:

1. Abre la sección **Explorar**
2. Categoría: **Automotriz > Mecánica**
3. Filtra por:
   - 📍 Ubicación cercana
   - ⭐ Calificaciones altas
   - 💰 Rango de precios

¿Necesitas un servicio específico como cambio de aceite, frenos, etc.?"
```

## 🔒 Control de Acceso

### Verificar Acceso del Usuario

```dart
final hasAccess = await ref.read(gregAccessProvider.future);

if (hasAccess) {
  // Mostrar chat de Greg
} else {
  // Mostrar pantalla de compra
}
```

### Implementar Sistema de Compra

```dart
// TODO: En greg_ai_service.dart
static Future<bool> checkUserHasAccess(int userId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/users/$userId/purchases'),
  );
  
  final purchases = jsonDecode(response.body);
  return purchases.any((p) => p['product_id'] == 'greg_ai_premium');
}
```

## 📊 Métricas y Límites

### Costos Aproximados (OpenAI)

- **GPT-3.5-turbo**: ~$0.002 por 1K tokens
- **Whisper**: ~$0.006 por minuto de audio

### Límites Recomendados

- **Tokens por respuesta**: 800 (ajustable)
- **Historial de contexto**: 10 mensajes
- **Duración máxima de audio**: 25 MB / ~10 minutos

## 🐛 Solución de Problemas

### Error: "API Key inválida"
```
Solución: Verifica que tu OPENAI_API_KEY esté configurada correctamente
```

### Error: "Rate limit exceeded"
```
Solución: Espera unos minutos o actualiza tu plan de OpenAI
```

### Audio no se transcribe
```
Solución: 
1. Verifica que el archivo sea válido (m4a, mp3, wav)
2. Comprueba que no exceda 25 MB
3. Revisa los permisos de micrófono
```

### Respuestas en inglés cuando debería ser español
```
Solución: El modelo detecta el idioma automáticamente. 
Asegúrate de que el usuario escriba en español.
```

## 🚀 Mejoras Futuras

### Corto Plazo
- [ ] Historial de conversaciones guardado
- [ ] Búsqueda en conversaciones
- [ ] Exportar conversación
- [ ] Modo voz continua (sin presionar botón)

### Mediano Plazo
- [ ] Integración con base de datos de Connek
- [ ] Búsqueda real de negocios
- [ ] Reservas directas desde el chat
- [ ] Recomendaciones basadas en ubicación real

### Largo Plazo
- [ ] Modelo personalizado entrenado con datos de Connek
- [ ] Soporte para imágenes (GPT-4 Vision)
- [ ] Asistente de voz completo
- [ ] Integración con calendario

## 📚 Recursos

- [OpenAI API Docs](https://platform.openai.com/docs)
- [Whisper API](https://platform.openai.com/docs/guides/speech-to-text)
- [ChatGPT Best Practices](https://platform.openai.com/docs/guides/gpt-best-practices)
- [Flutter Markdown](https://pub.dev/packages/flutter_markdown)

## 🤝 Contribuir

Para mejorar Greg:

1. Actualiza el system prompt en `greg_ai_service.dart`
2. Agrega nuevos quick prompts en `getSuggestedPrompts()`
3. Mejora el UI en `greg_chat_page.dart`
4. Optimiza parámetros de GPT según feedback

---

**Creado con ❤️ por Antigravity AI**
**Versión**: 2.0.0 - ChatGPT Style
**Última actualización**: 2026-02-10
