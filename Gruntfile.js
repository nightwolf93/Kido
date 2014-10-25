module.exports = function(grunt) {
    grunt.initConfig({
        sass: {
            compile: {
              files: {
                'styles/app.css': ['styles/sass/app.scss'],
              }
            }
        },
        coffee: {
            compile: {
                files: {
                  'scripts/js/prod.js': ['scripts/coffee/*.coffee', 'scripts/coffee/scenes/*.coffee'] // compile and concat into single file
                }
            },
        },
        uglify: {
            prod: {
              files: {
                'scripts/js/prod.min.js': ['scripts/js/prod.js']
              }
            }
        },
        watch: {
            stylus: {
                files: ['styles/sass/*.scss'],
                tasks: ['dev'],
                options: {
                    spawn: false,
                }
            },

            coffee: {
                files: ['scripts/coffee/*.coffee', 'scripts/coffee/scenes/*.coffee'],
                tasks: ['dev'],
                options: {
                    spawn: false,
                }
            },
      },
    });
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-uglify');

    grunt.registerTask('dev', ['sass:compile', 'coffee:compile', 'uglify:prod', 'watch']);
};
