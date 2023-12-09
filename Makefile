build:
	cd src && bundle install

run:
	cd src && ruby main.rb

test:
	cd src && bundle exec rspec --format documentation