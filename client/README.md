# Book Management Client

Flutter app for the Book Management API.

## Tech Stack

- Flutter 3.x (Android, iOS, Web)
- Riverpod (state management)
- go_router (navigation)
- Dio (HTTP client)
- cached_network_image (book covers)

## Run

```bash
flutter pub get
flutter run -d chrome        # web
flutter run                  # mobile device
```

## Architecture

- `lib/data/` — API client + models
- `lib/domain/` — Riverpod providers
- `lib/presentation/` — Screens, widgets, router

## OpenAPI Generation (optional)

To replace the manual API client with an auto-generated one:

1. Start the backend with `dev` profile.
2. Export spec:
   ```bash
   cd ../server
   ./gradlew generateOpenApiDocs
   ```
3. Generate Dart client from `../server/app/build/openapi.json` using `openapi-generator-cli`.
4. Replace `lib/data/api_client.dart` with generated code and update `api_provider.dart`.
