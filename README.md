# Flutter Firebase Auth App

Este projeto é uma aplicação Flutter com autenticação Firebase, que permite o registro, login e gerenciamento de usuários. Foi desenvolvido pelas alunas Ana Maria Olska e Julia Weiller. A seguir, você encontrará as funcionalidades de cada tela, os erros tratados, as dependências utilizadas e as instruções para execução.

## 📋 Funcionalidades por Tela

### **HomePage**

`_checkUserStatus`: Verifica o status de login e redireciona para login quando necessário.

`_fetchUserData`: Obtém os dados do usuário autenticado.

`_logout`: Realiza o logout do usuário.

`_deleteUser`: Remove a conta do usuário.

`_confirmDelete`: Mostra confirmação antes da exclusão da conta.

- **Componentes da Interface:**
    - Foto do usuário ou ícone padrão.
    - Botão de logout.
    - Botão de exclusão de conta com confirmação.

![image](https://github.com/user-attachments/assets/b72436ae-c7b9-4d8b-b126-bda2ce8a1867)

### **LoginPage**

`_signInWithEmailAndPassword`: Efetua login com e-mail e senha.

`_signInWithGitHub`: Efetua login via GitHub OAuth.

- **Componentes da Interface:**
    - Campos para e-mail e senha.
    - Botão de login.
    - Botão de login via GitHub.
    - Link para registro.

![image](https://github.com/user-attachments/assets/15b5bda4-075b-40ec-87f4-038f73e82472)

### **RegisterPage**

`_register`: Cria novo usuário com e-mail, senha e nome no Firestore.

- **Componentes da Interface:**
    - Campos para nome, e-mail e senha.
    - Botão de registro.

![image](https://github.com/user-attachments/assets/afd1c114-ad7b-4127-9b44-364b6702c1b3)

---

## ⚠️ Tipos de Erros do Provedor (FirebaseAuth)

`user-not-found`: Usuário não encontrado.

`wrong-password`: Senha incorreta.

`too-many-requests`: Excesso de tentativas de login.

`invalid-email`: E-mail em formato inválido.

`email-already-in-use`: E-mail já cadastrado.

`weak-password`: Senha muito fraca.

`requires-recent-login`: Requer login recente para operações sensíveis.

`account-exists-with-different-credential`: Conta já existe com outro método de login.

`auth/cancelled-popup-request`: Operação cancelada pelo usuário.

---

## 📦 Dependências Utilizadas

`sdk: flutter ^3.5.4`

`flutter_dotenv: ^5.0.2`

`firebase_auth: ^5.3.3`

`cloud_firestore: ^5.5.0`

`firebase_core: ^3.8.0`

`font_awesome_flutter: ^10.8.0`

`cupertino_icons: ^1.0.8`

---

## 🚀 Execução do Projeto

1. **Instale as dependências do projeto:**
    
    ```bash
    git clone <repositório git>
    flutter pub get
    ```
    
2. **Defina a porta 5000**
    
    ```bash
    flutter run -d web-server --web-port 5000
    ```
    
3. **Acesse o projeto pelo navegador:**
    - Inicie o projeto e abra o navegador para que seja direcionado ao `http://localhost:5000`.
