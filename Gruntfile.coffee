"use strict"
module.exports = (grunt) ->

  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  require('time-grunt')(grunt)

  # config
  grunt.initConfig

    watch:
      options:
        livereload: false
        spawn: false

      images:
        files: ["_assets/images/**/*"]
        tasks: ['imagemin', 'copy']

      vendor:
        files: [
          "_assets/scripts/vendor/*.js"
          "_assets/scripts/vendor/**/*.js"
        ]
        tasks: ["concurrent:compress"]

      coffee:
        files: ["_assets/scripts/**/*.coffee"]
        tasks: ["coffee", "concurrent:compress"]

      styles:
        files: ["_assets/styles/**/*.styl"]
        tasks: ["stylus", ""]

    stylus:
      application:
        options:
          linenos: true
          'include css': true
        files:
          'css/application.css': '_assets/styles/application.styl'

    concat:

      application:
        src: [
          "_assets/scripts/app/**/*.js"
          "_assets/scripts/application.js"
        ]
        dest: "scripts/application.js"

      vendor:
        src: [
          "_assets/components/modernizr/modernizr.js"
          "_assets/components/scripts/highlight.pack.js"
          "_assets/scripts/vendor/*.js"
        ]
        dest: 'scripts/vendor.js'

    # compiles all coffeescript 1 to 1
    coffee:
      dev:
        options:
          sourceMap: true
        expand: true
        cwd: "_assets/scripts"
        src: "**/*.coffee"
        dest: "_assets/scripts"
        ext: ".js"

# minification and beautification tasks

    # minify and compress css
    cssmin:
      options:
        report: 'min'
        banner: "/* minified via grunt task. Check Gruntfile.coffee for more info. */"
      app:
        files: "css/application.min.css": "css/application.css"

    # uglify pages and vendor javsacript files
    uglify:
      application:
        options:
          report: 'min'
        files:
          'scripts/application.min.js': [
            'scripts/application.js'
          ]
      vendor:
        options:
          report: 'min'
        files:
          'scripts/vendor.min.js': [
            'scripts/vendor.js'
          ]

    copy:
      fonts:
        files: [
          expand: true
          src: '_assets/fonts/*'
          dest: 'fonts/'
          flatten: true
        ]
      jquery:
        files: [
          cwd: '_assets/components/jquery/',
          src: 'jquery.min.js',
          dest: 'scripts',
          expand: true
        ]

    # image optimization
    imagemin:
      dist:
        options:
            optimizationLevel: 7
            progressive: true
        files: [
          expand: true
          cwd: '_assets/images/'
          src: '**/*'
          dest: 'images/'
        ]

    clean:
      all: ["_site/**/*"]

    open:
      dev:
        path: 'http://localhost:4000'
        app: 'Google Chrome'

    # exec
    exec:
      serve:
        cmd: "jekyll serve -w"

    # concurrent
    # let's run some tasks simultaneously

    concurrent:
      build: ['copy', 'stylus', 'coffee']
      compress: ['concat', 'uglify', 'cssmin', 'imagemin']

    sftp:
      deploy:
        files:
          "./": "{**/*, !_assets/}"

  # Tasks
  grunt.registerTask('default', ['concurrent', 'open', 'watch'])
  grunt.registerTask('serve', ['exec'])