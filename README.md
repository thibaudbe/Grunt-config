Grunt config
============

My Grunt.js personnal config using for application project. You can also use it for Wordpress developement with MAMP. 


## Features

- Bower
- Livereload
- Sass or Less
- Coffee
- JsHint
- Image minification
- Ftp deploy


## Installation

Make sure you have **Grunt** and **Bower** installed, check it with `grunt --version`. Then follow these lines
  
    # Install bower components
    bower update

    # Install npm packages
    npm update
  
Default jQuery component is exclude from default compilation. To print path in folder and add it

    # Will return paths
    bower list --paths


Add another components from **Bower** or anywhere with link
  
    # Search by name in Bower and save it in bower.json
    bower search component-name --save

    # Install from root with url and a custom name 
    bower install component-name=http://root/file-name.js --save
    # or
    bower install component-name=https:/github.com/root/file-name.git
  

## Usage

When you've comment or not Sass and Less for example, and simply run

    grunt app     # for app development
    grunt wp      # for wordpress development
    

## TODO

- auto Javascript folder to uglify containing jquery from bower
- test ftp deploy
- test sourcemap uglify settings

[![Analytics](https://ga-beacon.appspot.com/UA-59640055-1/Grunt-config/readme)](https://github.com/igrigorik/ga-beacon)
