'use strict';

const express        = require('express');
const session        = require('express-session');
const SequelizeStore = require('connect-session-sequelize')(session.Store);
const path           = require('path');
const ejs            = require('ejs');
const sequelize      = require('./db/connection');

require('./db/models');

const resolveUsuario = require('./middleware/usuario');

const app  = express();
const PORT = process.env.PORT || 3000;

app.engine('html', ejs.renderFile);
app.set('view engine', 'html');
app.set('views', path.join(__dirname, 'views'));

const sessionStore = new SequelizeStore({ db: sequelize });

app.use(session({
  secret:            'yaggo-mysql-2025',
  resave:            false,
  saveUninitialized: true,
  store:             sessionStore,
  cookie:            { maxAge: 1000 * 60 * 60 * 24 * 7 },
}));

sessionStore.sync();

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(resolveUsuario);

app.use('/',      require('./routes/index'));
app.use('/chat',  require('./routes/chat'));

app.use((err, req, res, _next) => {
  console.error('Erro:', err.message);
  res.status(500).render('404', { title: 'Erro — Yag-go', cartCount: 0, active: '' });
});

app.use((req, res) => {
  res.status(404).render('404', { title: '404 — Yag-go', cartCount: 0, active: '' });
});

sequelize.authenticate()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`\n🍔  Yag-go em http://localhost:${PORT}`);
      console.log(`🤖  Chatbot em http://localhost:${PORT}/chat`);
      console.log(`🗄️   MySQL: ${sequelize.config.database}@${sequelize.config.host}\n`);
    });
  })
  .catch(err => {
    console.error('\nFalha ao conectar no MySQL:', err.message);
    process.exit(1);
  });
