# Focacceria · Conti — Guida di installazione

Tempo: circa 30 minuti, meglio da un PC. Costo: zero.
Alla fine avrai un'app con icona su Android, iPhone, tablet e PC, con dati sincronizzati tra te e il socio.

## Cosa serve
- Un account GitHub (ce l'hai già)
- Un account Supabase (gratuito, ci entri con GitHub)

## Parte 1 — Database (Supabase)
1. Vai su supabase.com → **Start your project** → accedi con GitHub.
2. **New project**. Nome: `focacceria`. Scegli una password del database (salvala) e la regione **Europe (Frankfurt)** o vicina. Attendi 1–2 minuti.
3. Menu a sinistra → **SQL Editor** → **New query**. Apri il file `1-database.sql`, copia tutto, incolla, premi **Run**. Deve comparire "Success".
4. Menu **Authentication** → **Users** → **Add user** → **Create new user**. Inserisci la tua email e una password, spunta **Auto Confirm User**. Ripeti per il socio.
5. Menu **Authentication** → **Sign In / Providers** (o Settings): disattiva **Allow new users to sign up**, così nessun altro può registrarsi.
6. **SQL Editor** → nuova query. Apri `2-ruoli.sql`, sostituisci le due email con quelle vere, **Run**.
7. Menu **Project Settings** → **API**. Copia due valori: **Project URL** e la chiave **anon public**.

## Parte 2 — Collega l'app
1. Apri `config.js` con il Blocco note e incolla i due valori tra le virgolette. Salva.

## Parte 3 — Metti l'app online (GitHub Pages)
1. Su github.com → **New repository**. Nome: `focacceria`. Imposta **Public**. **Create repository**.
2. **uploading an existing file** → trascina TUTTI i file della cartella (compresa la cartella `icons`, `config.js`, `index.html`, `sw.js`, `manifest.webmanifest`). **Commit changes**.
3. **Settings** → **Pages** → Source: **Deploy from a branch** → Branch: `main`, cartella `/ (root)` → **Save**.
4. Dopo 1–2 minuti l'indirizzo sarà: `https://IL-TUO-NOME-GITHUB.github.io/focacceria/`

Il repository pubblico non è un problema: la chiave "anon public" è fatta per essere pubblica. I dati restano protetti perché solo gli utenti abilitati (tu e il socio) possono leggerli.

## Parte 4 — Installa sul telefono
- **iPhone**: apri l'indirizzo in Safari → Condividi → **Aggiungi alla schermata Home**.
- **Android**: apri in Chrome → menu ⋮ → **Installa app** (o **Aggiungi a schermata Home**).
- **Tablet**: come sopra, in base al sistema.
- **PC**: in Chrome o Edge → icona **Installa** nella barra degli indirizzi.

Accedi con email e password. L'accesso resta attivo.

## Ruoli
- **Admin (tu)**: inserisce, modifica ed elimina.
- **Socio**: inserisce e modifica incassi, spese e fatture, ma non può eliminare nulla.

## Backup consigliato
Su Supabase i dati sono salvati online, ma ogni mese scarica i report Excel dalla scheda Report e conservali.

## Se qualcosa non funziona
- "App non configurata": controlla `config.js`.
- "Utente non abilitato": hai eseguito il passo 6 con la stessa email dell'utente?
- Pagina vecchia dopo un aggiornamento: chiudi e riapri l'app.
