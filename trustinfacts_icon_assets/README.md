# TrustInFacts icon assets

Archivos incluidos:

- `icon_foreground.png`: capa foreground transparente para Android adaptive icon.
- `icon_background.png`: capa background para Android adaptive icon.
- `icon_store.png`: icono 512x512 para Google Play.
- `icon_ios.png`: icono master 1024x1024 para iOS.
- `flutter_launcher_icons.yaml`: configuración base para Flutter.
- `preview.png`: vista previa visual del icono.

## Uso en Flutter

Copia estos archivos a:

```text
assets/icon/
```

En tu `pubspec.yaml`, deja la configuración así:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.4

flutter_launcher_icons:
  android: true
  ios: true

  image_path: "assets/icon/icon_ios.png"

  adaptive_icon_background: "assets/icon/icon_background.png"
  adaptive_icon_foreground: "assets/icon/icon_foreground.png"

  remove_alpha_ios: true
```

Después ejecuta:

```bash
flutter pub get
dart run flutter_launcher_icons
flutter clean
flutter pub get
```

Para compilar Android:

```bash
flutter build appbundle --release
```

Nota: si el móvil sigue mostrando el icono antiguo, desinstala la app anterior o borra la caché del launcher.
