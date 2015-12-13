gulp = require 'gulp'
jade = require 'gulp-jade'
watch = require 'gulp-watch'
webserver = require 'gulp-webserver'
open = require 'gulp-open'
runSequence = require('run-sequence').use(gulp)
del = require 'del'

jadePattern = ['src/jade/index.jade']


gulp.task 'clean:all', (cb) ->
      del 'dist/*', cb

gulp.task 'jade', ->
    gulp.src jadePattern
    .pipe jade
        pretty: true
    .pipe gulp.dest('dist')

gulp.task 'watch', ->
    watch jadePattern, ->
        gulp.start ['jade']

gulp.task 'webserver', ->
    gulp.src 'dist'
    .pipe webserver
        host: 'localhost'
        livereload: true
        port: 8000
    .pipe open
        uri: 'http://localhost:8000'

gulp.task 'run', (cb)->
    runSequence ['clean:all'], ['jade'], ['watch', 'webserver'], cb
