'use strict'
module.exports = (grunt) ->
	
	# Root
	dir =
		root: 	''
		bower:	'bower_components'

		lib:		'assets/src/lib'
		coffee:	'assets/src/coffee'
		scss:		'assets/src/scss'
		less:		'assets/src/less'
		cssIn:	'assets/src/css'
		imgIn:	'assets/src/img'

		js:			'assets/build/js'
		cssOut:	'assets/build/css'
		imgOut:	'assets/build/img'


	# Load all packages
	require('load-grunt-tasks') grunt

	# Tasks
	grunt.initConfig
		dir: dir

		# Start a server & livereload
		connect: 
			options: 
				port: 9000
				livereload: 35729
				hostname: '*' 
				default: '0.0.0.0'
			livereload: 
				options: 
					open: true
				base: '.'

		# Php livereload
		php:
			dist:
				options:
					keepalive: true
					open: true
					port: 8085

		# Image minification
		imagemin:
			dynamic:
				options: 
					optimizationLevel: 3
				files: [
					expand: true
					cwd: '<%= dir.imgIn %>'
					src: ['**/*.{png,jpg,gif}']
					dest: '<%= dir.imgOut %>'
				]

		# Sass style
		sass:
			dist:
				options: 
					style: 'compressed'
					sourcemap: true
				files:
					'<%= dir.cssOut %>/main.min.css': '<%= dir.scss %>/**/*.scss'

		# Less style
		less:
			development:
				options:
					compress: true
					# cleancss: true
					report: 'min'
					sourceMap: true
					sourceMapFilename: '<%= dir.cssOut %>/main.min.css.map'
				files:
					'<%= dir.cssOut %>/main.min.css': '<%= dir.less %>/**/*.less'

		# Min css plugins
		cssmin:
			combine:
				files:
					'<%= dir.cssOut %>/styles.min.css': '<%= dir.cssIn %>/*.css'

		# Coffee
		coffee:
			compile:
				files:
					'<%= dir.js %>/main.js': '<%= dir.coffee %>/*.coffee'
			compileWithMaps:
				options:
					sourceMap: true
				files:
					'<%= dir.js %>/main.js': '<%= dir.coffee %>/*.coffee'

		# Bower components
		bower_concat:
			all:
				dest: '<%= dir.js %>/_bower.js'
				exclude:
						'jquery'
				bowerOptions:
					relative: false

		# Hint javascript plugins
		jshint:
			all: ['<%= dir.js %>/main.js']

		# Uglify all javascript
		uglify:
				my_target:
					files:
						'<%= dir.js %>/scripts.min.js': '<%= dir.js %>/_bower.js'
						'<%= dir.js %>/main.min.js': '<%= dir.js %>/main.js'


		# Clean folder
		clean: [
			'<%= dir.js %>/_bower.js'
			'<%= dir.js %>/main.js'
			'<%= dir.cssOut %>/main.css'
			'<%= dir.cssOut %>/styles.css'
		]

		# Deploy on FTP
		'ftp-deploy':
		  build:
		    auth:
		      host: 'server.com'
		      authKey: '###'
		      port: 21
		    src: ''
		    dest: '/path'
		    exclusions: [
		    	'.DS_Store'
		    	'Thumbs.db'
		    	'node_modules'
		    	'bower_components'
		    	'assets/src'
		    ]


		# Watch
		watch:
			php:
				files: [
					'<%= dir.root %>/*.php'
					'<%= dir.root %>/*.html'
					'<%= dir.root %>/templates/*.html'
				]
			# less:
			# 	files: '<%= dir.less %>/**/*.less' 
			# 	tasks: ['less', 'clean']
			sass:
				files: '<%= dir.scss %>/**/*.scss' 
				tasks: ['sass', 'clean']
			styles:
				files: '<%= dir.cssIn %>/*.css'
				tasks: ['cssmin', 'clean']
			scripts: 
				files: '<%= dir.coffee %>/*.coffee'
				tasks : ['coffee', 'jshint', 'uglify', 'clean']
			packages:
				files: '<%= dir.bower %>'
				tasks: ['bower_concat', 'uglify']
			images:
				files: '<%= dir.imgIn %>'
				tasks: 'imagemin'
			options:
				livereload: true
				nospawn: true


	grunt.registerTask 'default', [
		'connect:livereload'
		# 'php'
		'imagemin'
		# 'less'
		'sass'
		'cssmin'
		'coffee'
		'bower_concat'
		'jshint'
		'uglify'
		'watch'
		'clean'
	]