"use strict"
module.exports = (grunt) ->

  # load all grunt tasks
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  config =
    _assets: "_assets"
    dist: "public"

  require('time-grunt')(grunt)
  # config
  grunt.initConfig

    watch:
      options:
        livereload: true
        spawn: false

      images:
        files: ["_assets/images/**/*"]
        tasks: ['imagemin', 'copy']

      vendor:
        files: [
          "_assets/scripts/vendor/*.js"
        ]
        tasks: ['concat', 'uglify']

      coffee:
        files: ["_assets/scripts/**/*.coffee"]
        tasks: ["coffee", "concat"]

      livereload:
        files: ["*.html", "*.php", "public/images/**/*.{png,jpg,jpeg,gif,webp,svg}"]

    stylus:


    concat:

      # # this may be overkill;
      # # maybe just have the coffee output to public/

      "application-js":
        src: [
          "_assets/scripts/app/**/*.js"
          "_assets/scripts/application.js"
        ]
        dest: "public/scripts/application.js"

      # load in vendor js libraries

      "vendor-js":
        src: [
          "_assets/components/modernizr/modernizr.js"
          "_assets/components/jquery.easing/js/jquery.easing.min.js"
          "_assets/components/jquery/jquery-migrate.min.js"
          "_assets/components/jquery.transit/jquery.transit.js"
          "_assets/components/jquery.equalheights/jquery.equalheights.min.js"
          "_assets/components/sass-bootstrap/dist/js/bootstrap.js"
          "_assets/components/jquery-mmenu/source/jquery.mmenu.min.all.js"
          "_assets/scripts/vendor/*.js"
        ]
        dest: 'public/scripts/vendor.js'

      # load in vendor styles
      # we should probably just use sass to import them...

      # "vendor-css":
      #   src: [
      #     '_assets/styles/vendor/**/*.css'
      #     '_assets/styles/vendor.css'
      #   ]
      #   dest: 'public/styles/vendor.css'

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

    # fonts and svg files need to be copied to public folder
    # since they are not compressed with any other tasks.

    copy:
      fonts:
        files: [
          expand: true
          src: '_assets/fonts/**/*.{eot,svg,ttf,woff,otf}'
          dest: 'public/fonts/'
          flatten: true
        ]
      images:
        files: [
          expand: true
          cwd: "_assets"
          src: "images/**/*.{png,jpg,jpeg,gif,svg}"
          dest: "public"
        ]

# minification and beautification tasks

    # minify and compress css

    cssmin:
      options:
        report: 'min'
        banner: "/* minified via grunt task. Check Gruntfile.coffee for more info. */"
      app:
        files: "public/css/application.min.css": "public/css/application.css"
      vendor:
        files: "public/css/vendor.min.css": "public/css/vendor.css"

    # uglify pages and vendor javsacript files

    uglify:
      # dist:
      #   files: [
      #     expand: true
      #     cwd: "public/scripts"
      #     src: "*.js"
      #     dest: "public/scripts"
      #     ext: ".min.js"
      #   ]
      "application-js":
        options:
          report: 'min'
        files:
          'public/scripts/application.min.js': [
            'public/scripts/application.js'
          ]
      vendor:
        options:
          report: 'min'
        files:
          'public/scripts/vendor.min.js': [
            'public/scripts/vendor.js'
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
          dest: 'public/images/'
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
      build: ['copy']
      compress: ['uglify', 'cssmin', 'imagemin']

    sftp:
      deploy:
        files:
          "./": "{**/*, !_assets/}"

  # Tasks
  grunt.registerTask('default', ['exec:serve', 'open'])

  # grunt.registerTask('build', ['coffee', 'sass', 'concurrent:build', 'concat', 'concurrent:compress'])
  # grunt.registerTask('zip', ['compress:zip'])
  # grunt.registerTask('deploy', ['build', 'sftp:deploy'])
  # grunt.registerTask('default', ['coffee', 'sass', 'concurrent:build', 'concat', 'concurrent:compress', 'open:dev', 'watch'])