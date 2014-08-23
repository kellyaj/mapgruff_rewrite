module.exports = function(grunt) {

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    jst: {
      compile: {
        files: {
          ".tmp/scripts/templates.js": ["scripts/templates/*.ejs"]
        }
      }
    },
    watch: {
     jst: {
        files: ["js/templates/*.ejs"],
        tasks: ["jst"]
      }
    },
    clean: {
      test: {
        files: [{
          src: ['.tmp']
        }]
      }
    },
    coffee: {
      compileScripts: {
        expand: true,
        flatten: true,
        cwd: 'app/scripts',
        src: '**/**/*.coffee',
        dest: '.tmp/scripts',
        ext: '.js'
      },
      compileSpecs: {
        expand: true,
        flatten: true,
        cwd: 'spec',
        src: '**/*.coffee',
        dest: '.tmp/spec',
        ext: '.js'
      }
    },
    uglify: {
      my_target: {
        files: {'mapgruff.min.js': [
                                    'app/bower_components/jquery/jquery.js',
                                    'app/bower_components/underscore/underscore.js',
                                    'app/bower_components/backbone/backbone.js',
                                   ]
        }
      }
    },
    connect: {
      server: {
        options: {
          port: 1066,
          hostname: 'localhost',
          keepalive: true,
          open: true,
          middleware: function (connect) {
            return [
              connect.static(require('path').resolve('.tmp')),
              connect.static(require('path').resolve('app'))
            ]
          }
        }
      }
    }

  });

  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-jst');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-connect');

  grunt.registerTask('default', ['jst']);
  grunt.registerTask('compile', ['clean', 'jst', 'coffee', 'uglify']);
  grunt.registerTask('build', ['clean', 'jst', 'coffee']);
  grunt.registerTask('server', ['connect:server']);
}
