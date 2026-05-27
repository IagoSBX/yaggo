# Yag-go Burgers — Web App com MySQL

App delivery completo com Node.js + Express + MySQL/MariaDB.

## Pré-requisitos

- Node.js 18+
- MySQL 8+ **ou** MariaDB 10.6+

---

## Setup — passo a passo

### 1. Instalar dependências
```bash
npm install
```

### 2. Criar o banco de dados
Abra o MySQL (Workbench, DBeaver, terminal ou phpMyAdmin) e execute:
```sql
-- Opção A: terminal
mysql -u root -p < db/schema.sql

-- Opção B: cole o conteúdo de db/schema.sql no seu cliente SQL
```
Isso cria o banco `yaggo` com todas as tabelas e views.

### 3. Configurar credenciais
Edite `db/connection.js` e preencha sua senha:
```js
const DB_PASSWORD = '';   // ← sua senha aqui
```
Ou copie `.env.example` para `.env` e preencha as variáveis.

### 4. Popular o banco (seed)
```bash
npm run seed
```
Insere as 4 categorias e 12 produtos.

### 5. Rodar o servidor
```bash
npm start          # produção
npm run dev        # desenvolvimento (auto-reload com nodemon)
```
Acesse: **http://localhost:3000**

---

## Estrutura de arquivos

```
yaggo_db/
├── server.js               # Entry point Express
├── package.json
├── .env.example            # Template de variáveis de ambiente
│
├── db/
│   ├── schema.sql          # DDL — cria banco, tabelas e views
│   ├── seed.sql            # DML — INSERTs dos dados iniciais (via SQL)
│   ├── seed.js             # Seed via Node (npm run seed)
│   ├── connection.js       # Conexão Sequelize + MySQL
│   └── models.js           # Modelos Sequelize (Categoria, Produto, etc.)
│
├── middleware/
│   └── usuario.js          # Resolve/cria usuário anônimo por sessão
│
├── routes/
│   └── index.js            # Todas as rotas GET/POST + API AJAX do carrinho
│
├── views/                  # Templates EJS com extensão .html
│   ├── partials/
│   │   ├── head.html
│   │   ├── header.html
│   │   └── footer.html
│   ├── home.html
│   ├── menu.html
│   ├── cart.html
│   ├── checkout.html
│   ├── confirmation.html
│   ├── orders.html
│   └── 404.html
│
└── public/
    ├── css/style.css
    ├── js/app.js
    └── images/             # 12 imagens dos produtos
        ├── smash_classico.png
        ├── double_smash.png
        └── ...
```

---

## Tabelas do banco

| Tabela         | Descrição |
|----------------|-----------|
| `categorias`   | Hambúrgueres, Combos, Bebidas, Sobremesas |
| `produtos`     | 12 produtos com preço, imagem, categoria |
| `usuarios`     | Usuários anônimos identificados por session_id |
| `carrinho`     | Itens no carrinho por usuário (persiste entre sessões) |
| `pedidos`      | Pedidos finalizados com status |
| `itens_pedido` | Snapshot dos itens no momento da compra |

## Views SQL

| View                  | Descrição |
|-----------------------|-----------|
| `v_carrinho_resumo`   | Subtotal do carrinho por usuário |
| `v_pedidos_completos` | Pedidos com contagem de itens |

---

## API do carrinho (AJAX)

```
POST /cart/add     { productId }           → { count, subtotal }
POST /cart/update  { productId, action }   → { count, subtotal, total, empty }
  action: 'inc' | 'dec' | 'remove'
```
