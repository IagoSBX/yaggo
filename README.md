# 🍔📱 Yag-go Burgers — App Mobile (Flutter)

Contraparte **mobile** do sistema de delivery **Yag-go Burgers**, construída em Flutter com a mesma proposta visual e de produto da versão web.

![Flutter](https://img.shields.io/badge/Flutter-3.3+-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/State%20Management-Provider-blue)

## 📖 Sobre o projeto

Este app reproduz a experiência de um delivery real em ambiente mobile: catálogo de produtos por categoria, carrinho de compras e fluxo de pedido, consumindo a mesma lógica de negócio do projeto irmão [**yaggo-web**](https://github.com/IagoSBX/yaggo-web) (back-end Node.js + MySQL).

## ✨ Funcionalidades

- 🍔 Catálogo de produtos por categoria (Hambúrgueres, Combos, Bebidas, Sobremesas)
- 🛒 Carrinho de compras com gerenciamento de estado reativo
- 🎨 Tema visual consistente com a identidade da marca Yag-go Burgers
- 🧩 Arquitetura organizada em models, providers, screens e widgets reutilizáveis

## 🧱 Stack técnica

- **Flutter** (Dart, SDK ^3.3.0)
- **Provider** — gerenciamento de estado
- **Google Fonts** — tipografia customizada

## 🗂️ Estrutura do projeto

```
lib/
├── main.dart      # Entry point do app
├── models/        # Modelos de dados (produtos, categorias, pedido...)
├── providers/      # Gerenciamento de estado (carrinho, produtos, usuário)
├── screens/        # Telas do app (home, menu, carrinho, checkout...)
├── theme/          # Cores, tipografia e estilos globais
└── widgets/        # Componentes reutilizáveis de UI
android/             # Projeto Android nativo
test/                # Testes do app
```

## 🚀 Como rodar localmente

```bash
# Pré-requisito: Flutter 3.3+ instalado

git clone https://github.com/IagoSBX/yaggo.git
cd yaggo

flutter pub get
flutter run
```

## 🔗 Projeto relacionado

- **Back-end + Web app:** [yaggo-web](https://github.com/IagoSBX/yaggo-web) — Node.js, Express e MySQL/MariaDB

## 👨‍💻 Autores

Feito por **Iago Santos** em colaboração com **Yago Ribeiro**

[![GitHub](https://img.shields.io/badge/GitHub-IagoSBX-181717?logo=github)](https://github.com/IagoSBX)
