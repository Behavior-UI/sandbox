Behavior-UI Sandbox
==============

## Requirements

* [nodejs](http://nodejs.org/)
* [ruby on rails](http://railsapps.github.io/installrubyonrails-mac.html)
* [pow](http://pow.cx/) - (optional, but highly recommended)
* [mysql](http://dev.mysql.com/doc/refman/5.1/en/macosx-installation-pkg.html)
	e.g. `gem install mysql2 -v '0.3.14'`
	(this is temporary; running rails w/o mysql is a pain)

## Installation

	git clone https://github.com/Behavior-UI/sandbox.git
	cd sandbox
	ln -s $(pwd) ~/.pow/sandbox   # creates link to sandbox directory in ~/.pow/
	bundle install                # installs gems
	npm install                   # installs bower
	rake bower:install            # installs vendor assets; bootstrap, flat-ui, behavior-ui
	powder up                     # starts powder

Then just open [http://sandbox.dev](http://sandbox.dev).

## Database configuration

You will find a file called `database.example.yml` in the `/config` directory.
You need to copy this to `database.yml` and change accordingly.
