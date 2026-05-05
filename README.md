# Book Management Monorepo

Personal book and comic collection manager.

## Structure

- `server/` — Kotlin Spring Boot REST API (Clean Architecture)
- `client/` — Flutter app (Android, iOS, Web)

## Quick Start

### Prerequisites

- Java 17
- Flutter 3.x + Dart 3.x
- Docker + Docker Compose

### Run Backend

```bash
cd server
./gradlew bootRun --args='--spring.profiles.active=dev'
```

Or with Docker Compose (full stack):

```bash
docker compose up --build
```

Backend runs on `http://localhost:8080`.
Swagger UI: `http://localhost:8080/swagger-ui.html`
OpenAPI spec: `http://localhost:8080/v3/api-docs`

### Run Flutter Client

```bash
cd client
flutter pub get
flutter run -d chrome        # web
flutter run                  # connected device / emulator
```

## Generate OpenAPI Dart Client

1. Start the backend locally with the `dev` profile.
2. Export the OpenAPI spec:
   ```bash
   cd server
   ./gradlew generateOpenApiDocs
   ```
3. Generate the Dart client (see `client/README.md` for generator command).

## Architecture

- **Server**: Clean Architecture with `domain` (pure Kotlin) and `app` (Spring Boot + infrastructure) modules.
- **Client**: Riverpod for state management, `go_router` for navigation, OpenAPI-generated Dio client for API integration.
