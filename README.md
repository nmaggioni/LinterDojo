# LinterDojo [![David-dm Badge](https://david-dm.org/nmaggioni/linterdojo.svg)](https://david-dm.org/nmaggioni/linterdojo)
Un linter per HTML e JavaScript personalizzato per il CoderDojo fiorentino.

## Installazione
+ Assicurarsi di avere installato [NodeJS][1] e [Gulp][6].
+ Navigare nella cartella dove si è clonata la repo ed invocare `npm install` per installare i pacchetti necessari.

## Utilizzo
### Opzioni
| Opzione          | Valore      | Significato                                                                                   |
|------------------|-------------|-----------------------------------------------------------------------------------------------|
| -s \| --source   | **Stringa** | File sorgente da validare in input.                                                           |
| -o \| --out      | **Stringa** | File in cui copiare il sorgente formattato. Se non specificato, sovrascrive il file di input. |
| -f \| --force    | *Nessuno*   | Se specificata, non verrà chiesta conferma prima di sovrascrivere il file di output.          |
| -b \| --beautify | *Nessuno*   | Se specificata, verrà eseguita solo la riformattazione del codice (senza validarlo).          |

## Linting
Navigare nella cartella dove si è clonata la repo ed invocare `gulp -s nomeFile.js` oppure `gulp -s nomeFile.html`.
Sono inclusi dei file di test nell'omonima cartella.

## Configurazione
Le configurazioni di [js-beautify][2], [jshint][3] e [JSCS][5] si trovano nella cartella `config`. Seguono il formato [CSON][4].

[1]: https://nodejs.org/
[2]: https://github.com/beautify-web/js-beautify#options
[3]: http://jshint.com/docs/options/
[4]: https://github.com/bevry/cson#what-is-cson
[5]: http://jscs.info/rules
[6]: http://gulpjs.com/
