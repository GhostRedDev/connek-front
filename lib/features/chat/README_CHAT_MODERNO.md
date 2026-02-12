# 🎨 Chat Moderno con Shadcn UI

## 📖 Descripción

Sistema de chat completamente renovado con diseño moderno inspirado en **shadcn/ui**. Incluye soporte para múltiples tipos de archivos, reacciones, markdown, y mucho más.

## 🚀 Inicio Rápido

### 1. Ver la Demo

Para ver los nuevos componentes en acción, navega a la página de demostración:

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => const ModernChatDemo()),
);
```

O agrega la ruta en tu router:

```dart
GoRoute(
  path: '/chat/demo',
  builder: (context, state) => const ModernChatDemo(),
),
```

### 2. Usar en tu Chat Existente

#### Paso 1: Importar los componentes

```dart
import '../widgets/modern_chat_input.dart';
import '../widgets/modern_message_bubble.dart';
```

#### Paso 2: Reemplazar el input

```dart
ModernChatInput(
  onSendMessage: (text, {contentType}) async {
    // Tu lógica para enviar mensajes
    await sendMessage(text);
  },
  onSendFile: (file, type) async {
    // Tu lógica para subir archivos
    await uploadFile(file, type);
  },
  onTypingStart: () {
    // Opcional: Enviar indicador de escritura
  },
  onTypingStop: () {
    // Opcional: Detener indicador de escritura
  },
)
```

#### Paso 3: Reemplazar las burbujas de mensaje

```dart
ModernMessageBubble(
  content: message.content,
  contentType: message.contentType ?? 'text',
  isMe: message.senderId == currentUserId,
  timestamp: message.createdAt,
  senderName: message.senderName,
  senderAvatar: message.senderAvatar,
  showAvatar: true,
  isRead: message.isRead,
  reactions: message.reactions,
  onReact: () => showReactionPicker(message),
  onReply: () => replyToMessage(message),
  onForward: () => forwardMessage(message),
  onDelete: message.isMe ? () => deleteMessage(message) : null,
)
```

## 📦 Tipos de Archivos Soportados

### Imágenes
- JPG, JPEG, PNG, GIF, WebP
- Preview automático en el chat
- Lazy loading con caché

### Videos
- MP4, MOV, AVI
- Thumbnail con botón de play
- Indicador de duración

### Audio
- M4A, MP3, WAV
- Visualización de onda
- Controles de reproducción
- Indicador de duración

### Documentos
- PDF, DOC, DOCX
- TXT, RTF
- XLSX, XLS
- PPT, PPTX

### Archivos Generales
- Cualquier tipo de archivo
- Icono según extensión
- Nombre y tamaño visible

## 🎨 Personalización

### Colores

Los colores siguen la paleta de shadcn/ui y se adaptan automáticamente al tema:

```dart
// Modo Oscuro
Background: #09090B
Card: #18181B
Border: #27272A
Text: #FAFAFA
Muted: #71717A

// Modo Claro
Background: #FFFFFF
Card: #F4F4F5
Border: #E4E4E7
Text: #09090B
Muted: #A1A1AA
```

### Gradientes de Acción

```dart
// Primario (Enviar, Mensajes propios)
LinearGradient(
  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
)

// Secundario (Micrófono, Adjuntos)
LinearGradient(
  colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
)
```

## 🎯 Características

### ModernChatInput

- ✅ Entrada de texto multilínea
- ✅ Botón de adjuntos con menú expandible
- ✅ Grabación de audio con:
  - Temporizador en tiempo real
  - Bloqueo deslizando hacia arriba
  - Cancelar deslizando hacia la izquierda
- ✅ Botón de emoji (preparado para picker)
- ✅ Indicadores de escritura
- ✅ Animaciones suaves
- ✅ Diseño responsive

### ModernMessageBubble

- ✅ Soporte para 6 tipos de contenido
- ✅ Markdown rendering
- ✅ Avatares de usuario
- ✅ Reacciones con emojis
- ✅ Acciones contextuales (long press)
- ✅ Indicadores de lectura
- ✅ Timestamps formateados
- ✅ Diseño adaptativo según remitente

## 📱 Ejemplo Completo

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyChatPage extends ConsumerStatefulWidget {
  const MyChatPage({super.key});

  @override
  ConsumerState<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends ConsumerState<MyChatPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          // Lista de mensajes
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return ModernMessageBubble(
                  content: msg.content,
                  contentType: msg.type,
                  isMe: msg.isMe,
                  timestamp: msg.timestamp,
                  senderName: msg.senderName,
                  senderAvatar: msg.avatar,
                  showAvatar: true,
                  isRead: msg.isRead,
                  onReact: () => _handleReact(msg),
                  onReply: () => _handleReply(msg),
                  onForward: () => _handleForward(msg),
                  onDelete: msg.isMe ? () => _handleDelete(msg) : null,
                );
              },
            ),
          ),

          // Input
          ModernChatInput(
            onSendMessage: (text, {contentType}) async {
              await ref.read(chatProvider.notifier).sendMessage(text);
            },
            onSendFile: (file, type) async {
              await ref.read(chatProvider.notifier).uploadFile(file, type);
            },
          ),
        ],
      ),
    );
  }

  void _handleReact(Message msg) {
    // Implementar selector de reacciones
  }

  void _handleReply(Message msg) {
    // Implementar respuesta
  }

  void _handleForward(Message msg) {
    // Implementar reenvío
  }

  void _handleDelete(Message msg) {
    // Implementar eliminación
  }
}
```

## 🔧 Configuración Avanzada

### Deshabilitar Funciones

```dart
ModernChatInput(
  onSendMessage: _handleSend,
  onSendFile: _handleFile,
  // No pasar onTypingStart/Stop para deshabilitar indicadores
)
```

### Ocultar Acciones de Mensaje

```dart
ModernMessageBubble(
  content: message.content,
  isMe: true,
  timestamp: DateTime.now(),
  // No pasar callbacks para ocultar acciones
  // onReact: null,
  // onReply: null,
  // etc.
)
```

### Personalizar Avatares

```dart
ModernMessageBubble(
  content: 'Hola',
  isMe: false,
  timestamp: DateTime.now(),
  senderName: 'Usuario',
  senderAvatar: 'https://mi-cdn.com/avatar.jpg',
  showAvatar: true, // false para ocultar
)
```

## 🐛 Solución de Problemas

### Los archivos no se suben

Verifica que tienes los permisos necesarios en tu `AndroidManifest.xml` y `Info.plist`:

```xml
<!-- Android -->
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

```xml
<!-- iOS -->
<key>NSPhotoLibraryUsageDescription</key>
<string>Necesitamos acceso a tus fotos para enviar imágenes</string>
<key>NSCameraUsageDescription</key>
<string>Necesitamos acceso a la cámara para tomar fotos</string>
<key>NSMicrophoneUsageDescription</key>
<string>Necesitamos acceso al micrófono para grabar audio</string>
```

### El markdown no se renderiza

Asegúrate de tener instalado `flutter_markdown`:

```bash
flutter pub add flutter_markdown
```

### Los colores no coinciden

Los componentes usan el tema de Flutter. Asegúrate de que tu app tiene configurado correctamente el `ThemeData`:

```dart
MaterialApp(
  theme: ThemeData.light(),
  darkTheme: ThemeData.dark(),
  themeMode: ThemeMode.system,
)
```

## 📚 Recursos Adicionales

- [Documentación de shadcn/ui](https://ui.shadcn.com/)
- [Flutter Markdown](https://pub.dev/packages/flutter_markdown)
- [File Picker](https://pub.dev/packages/file_picker)
- [Image Picker](https://pub.dev/packages/image_picker)
- [Record](https://pub.dev/packages/record)

## 🤝 Contribuir

¿Encontraste un bug o tienes una sugerencia? ¡Abre un issue!

## 📄 Licencia

Este código es parte del proyecto Connek.

---

**Creado con ❤️ por Antigravity AI**
