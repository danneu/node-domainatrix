{exec} = require "child_process"

REPORTER = "min"

task "compile", "compile src coffee into lib js and copy over .dat file", ->
  exec "coffee -cbo lib src", (err) ->
    throw err if err
    console.log "-> coffeescript compiled."
  exec "cp src/effective_tld_names.dat lib", (err) ->
    throw err if err
    console.log "-> .dat copied."

task "test", "run tests", ->
  exec "NODE_ENV=test 
    ./node_modules/.bin/mocha 
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script 
    --require test/test_helper.coffee
    --colors
  ", (err, output) ->
    throw err if err
    console.log output
