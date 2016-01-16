gulp = require 'gulp'
coffee = require 'coffee-script'
fs = require 'fs'
minimist = require 'minimist'

knownOptions = {
    string: 'out', 'source',
    boolean: 'force', 'beautify'
    default: { force: false },
    alias: { out: 'o', source: 's', force: 'f', beautify: 'b' }
}

options = minimist process.argv.slice(2), knownOptions

gulp.task 'compile', ->
    coffeeSource = fs.readFileSync "./LinterDojo.coffee", "utf8"
    fs.writeFileSync "./LinterDojo.js", coffee.compile coffeeSource
    #console.log 'Sorgente CoffeeScript compilato in: ' + options.out

gulp.task 'lint', ->
    LinterDojo = require './LinterDojo.js'
    options = { beautify: options.beautify, force: options.force, source: options.source, out: options.out }
    LinterDojo.lintFile(options)

gulp.task 'default', ['compile', 'lint'], ->
