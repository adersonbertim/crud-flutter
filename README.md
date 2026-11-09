# Gerenciador de Jogos

Aplicação desenvolvida como parte das atividades práticas da disciplina de **Dispositivos Móveis**, com o objetivo de aplicar os conhecimentos vistos em aula no desenvolvimento de um app com **Flutter** e **Firebase**.

O app é um CRUD de jogos: o usuário cadastra, lista, edita e exclui jogos, e os dados ficam salvos no **Cloud Firestore**, com atualização da lista em tempo real.

## Funcionalidades

- Login e logout de usuário
- Listagem de jogos em tempo real (a lista atualiza sozinha quando o banco muda)
- Cadastro de novos jogos
- Edição de jogos existentes
- Exclusão de jogos, com confirmação antes de apagar

Cada jogo possui:

| Campo | Tipo | Descrição |
|-------|------|-----------|
| `nome` | texto | Nome do jogo |
| `plataforma` | texto | Plataforma em que o jogo é jogado |
| `nota` | número | Nota dada ao jogo |

## Tecnologias

- [Flutter](https://flutter.dev/) / Dart
- [Firebase](https://firebase.google.com/) (Cloud Firestore e autenticação)

## Estrutura do repositório

```
gerenciador_jogos_flutter/
├── gerenciador_jogos/   # Projeto Flutter (código-fonte do app)
├── .gitignore
└── README.md            # Este arquivo
```


## Como executar

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado
- Um projeto criado no [console do Firebase](https://console.firebase.google.com/) com o **Firestore** e a **autenticação** habilitados, e um app **Web** registrado nele

### Passo a passo

1. Clone o repositório:

   ```bash
   git clone https://github.com/adersonbertim/gerenciador_jogos_flutter.git
   cd gerenciador_jogos_flutter/gerenciador_jogos
   ```

2. Baixe as dependências:

   ```bash
   flutter pub get
   ```

3. Crie o arquivo de chaves do Firebase (veja a seção abaixo).

4. Execute o app no navegador:

   ```bash
   flutter run -d chrome
   ```

## Configuração das chaves do Firebase

Por segurança, o arquivo com as chaves **não é versionado** (está no `.gitignore`). Quem clonar o projeto precisa criá-lo manualmente.

1. Crie o arquivo `lib/firebase_keys.dart` dentro da pasta `gerenciador_jogos`.
2. Cole o conteúdo abaixo e preencha com os dados do seu projeto:

   ```dart
   const String firebaseWebApiKey = '';
   const String firebaseWebAppId = '';
   const String firebaseMessagingSenderId = '';
   const String firebaseProjectId = '';
   const String firebaseAuthDomain = '';
   const String firebaseStorageBucket = '';
   ```

3. Os valores estão no console do Firebase, em **Configurações do projeto → Seus aplicativos → app Web**.

> Os nomes das constantes precisam ficar exatamente como acima, pois o arquivo `firebase_options.dart` depende deles.

## Autor

Desenvolvido por **Aderson Bertim** para a disciplina de Dispositivos Móveis.
