minimist = require 'minimist'
cson = require 'cson'
readlineSync = require 'readline-sync'
fs = require 'fs'
jshint = require('jshint').JSHINT
jsbeautify = require('js-beautify').js
htmlbeautify = require('js-beautify').html
cssbeautify = require('js-beautify').css

jshintOptions = cson.load "config/JSHint.cson"
beautifierOptions = cson.load "config/JS-Beautify.cson"

knownOptions = {
    string: ['out', 'source'],
    boolean: 'force',
    default: { force: false },
    alias: { out: 'o', source: 's', force: 'f' }
}

options = null
sourceFile = null

fileExists = (path) ->
    try
        fs.statSync path
    catch err
        return false if err.code == 'ENOENT'
    return true

parseOptions = (options) ->
    if !@options?
        @options = minimist process.argv.slice(2), knownOptions
    @options.out = @options.source if !options.out?

    if !source?
        sourceFile = fs.readFileSync @options.source, 'utf8'
    else
        throw Error "Nessun file sorgente specificato. " +
        "Usa l\'opzione {-s|--source} per indicarlo."

hint = ->
    if (@options.source.endsWith ".js") && (!looks_like_html @options.source)
        jshint(sourceFile, jshintOptions, {})
        if jshint.errors.length > 0
            for error in jshint.errors
                do (error) ->
                    console.log "[JSHint " + error.id + "] " +
                    "Linea " + error.line + ", Colonna " + error.character + ": " +
                    error.code + " - " + error.reason
            process.exit 1
        else
            console.log "[JSHint] Nessun problema rilevato."
    else
        console.log "[JSHint] Salto file non puramente JavaScript."

writeToOutputFile = (content) ->
    fs.writeFileSync @options.out, content
    console.log "[JSBeautifier] Output scritto in: " + @options.out

askConfirmation = ->
    readlineSync.question "[JSBeautifier] Il file di output esiste già, sovrascriverlo? [Sì/No] "

looks_like_html = (source) ->
    trimmed = source.replace(new RegExp("^[ \t\n\r]+", ''))
    comment_mark = '<' + '!-' + '-'
    return (trimmed && (trimmed.substring(0, 1) == '<' && trimmed.substring(0, 4) != comment_mark))

beautify = ->
    if (@options.source.endsWith ".css") && (!looks_like_html @options.source)
        beautifiedSourceFile = cssbeautify sourceFile, beautifierOptions
    else if looks_like_html sourceFile
        beautifiedSourceFile = htmlbeautify sourceFile, beautifierOptions
    else
        beautifiedSourceFile = jsbeautify sourceFile, beautifierOptions

    if beautifiedSourceFile == sourceFile
        if looks_like_html sourceFile
            console.log "[HTMLBeautifier] Nessuna modifica da apportare."
        else
            console.log "[JSBeautifier] Nessuna modifica da apportare."
        process.exit 0

    if fileExists @options.out
        if @options.force
            writeToOutputFile beautifiedSourceFile
        else
            sn = askConfirmation()
            while true
                if sn.toLowerCase().startsWith "s"
                    writeToOutputFile beautifiedSourceFile
                    break
                else if sn.toLowerCase().startsWith "n"
                    break
                sn = askConfirmation()
    else
        writeToOutputFile beautifiedSourceFile

module.exports.lintFile = lintFile = (options) ->
    parseOptions options
    hint()
    beautify()
