# JSMA Flutter Workspace

Monorepo para os projetos da JSMA.

## Estrutura

```
packages/
  jsma_client/   # Client HTTP/API compartilhado (Dart puro)
  ...            # Outros pacotes compartilhados (models, utils, etc.)

apps/
  client_flutter/ # Aplicação Flutter principal
  server/        # Projeto server existente

docs/            # Documentação geral
scripts/         # Scripts de automação e CI
```

## Pré-requisitos

- Flutter >= 3.16.0
- Dart >= 3.0.0
- Melos (opcional, para scripts multi-pacote)

## Setup

1. Instale o Melos globalmente (se ainda não tiver):
   ```bash
   dart pub global activate melos
   ```

2. Inicialize o workspace:
   ```bash
   melos bootstrap
   ```

3. Verifique a análise estática:
   ```bash
   melos run analyze
   ```

4. Execute os testes:
   ```bash
   melos run test
   ```

## Dependência entre pacotes

O `client_flutter` depende do `jsma_client` via path dependency.

## Executar

- Flutter app:
  ```bash
  cd apps/client_flutter
  flutter run
  ```

- Server:
  ```bash
  cd apps/server
  # Comandos do server (preservar existentes)
  ```
