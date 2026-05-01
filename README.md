# Football League

Aplicação mobile desenvolvida em **Flutter** que exibe a tabela de classificação das principais ligas de futebol do mundo, com autenticação via **Firebase** e consumo de dados da **ESPN API**.

---

## Prints da Aplicação

(prints\login.jpeg)
(prints\home.jpeg)
(prints\classificacao.jpeg)

---

## Arquitetura da Aplicação

```
football_league/
├── lib/
│   ├── main.dart                  # Ponto de entrada da aplicação
│   ├── firebase_options.dart      # Configurações do Firebase
│   ├── models/
│   │   └── standing.dart          # Modelo de dados da classificação
│   ├── screens/
│   │   ├── login_screen.dart      # Tela de login com Google
│   │   ├── home_screen.dart       # Tela inicial com lista de ligas
│   │   └── standings_screen.dart  # Tela de classificação da liga
│   └── services/
│       └── football_service.dart  # Serviço de consumo da API
├── android/                       # Configurações Android
├── ios/                           # Configurações iOS
├── web/                           # Configurações Web
└── pubspec.yaml                   # Dependências do projeto
```

### Fluxo da Aplicação

```
Usuário abre o app
       ↓
Firebase verifica autenticação
       ↓                    ↓
[Não autenticado]          [Autenticado]
       ↓                        ↓
  Login Screen             Home Screen
  (Google Sign-In)         (Lista de Ligas)
       ↓                        ↓
  Firebase Auth            Standings Screen
                           (ESPN API → Tabela)
```

---

## Tecnologias Utilizadas

| Tecnologia | Versão | Finalidade |
|---|---|---|
| Flutter | 3.x | Framework principal |
| Dart | 3.x | Linguagem de programação |
| Firebase Auth | ^4.17.0 | Autenticação com Google |
| Firebase Core | ^2.27.0 | Integração com Firebase |
| Google Sign-In | ^6.2.1 | Login social |
| HTTP | ^1.2.0 | Requisições à API |
| ESPN API | Pública | Dados das ligas de futebol |

---

## Pré-requisitos

- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- Conta no [Firebase](https://firebase.google.com)
- [Git](https://git-scm.com) instalado

---

## Como Instalar e Rodar

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/football_league.git
cd football_league
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Configure o Firebase

- Acesse [console.firebase.google.com](https://console.firebase.google.com)
- Crie um projeto e ative o **Authentication → Google**
- Adicione um app Web e copie as configurações para `lib/firebase_options.dart`

### 4. Rode a aplicação

```bash
# Web
flutter run -d chrome

# Android
flutter run -d android

# iOS
flutter run -d ios
```

## API Utilizada

**ESPN Soccer API** — API pública e gratuita, sem necessidade de cadastro.

- Base URL: `https://site.api.espn.com/apis/v2/sports/soccer`
- Endpoint de classificação: `/{league_id}/standings`

### Ligas disponíveis

| Liga           | ID    |

| Premier League | eng.1 |
| La Liga        | esp.1 |
| Bundesliga     | ger.1 |
| Serie A        | ita.1 |
| Ligue 1        | fra.1 |

---

## 🔥 Integração com Firebase

O app utiliza **Firebase Authentication** para login social com Google:

- Usuário faz login com conta Google
- Firebase autentica e retorna o usuário
- App exibe nome e foto do usuário logado
- Logout disponível no canto superior direito

---

## 👨‍💻 Autor

**João Pucci e Matheus Ferrarezi**  
Curso de Desenvolvimento de Sistemas — UNIFACEF  
Disciplina: Programação para Dispositivos Móveis I
