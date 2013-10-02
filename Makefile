# A Make file, that conforms with the web site's expectations. Running 'make'
# has to create a directory called 'compiled-lectures' that will be linked by
# the site's deploy process.
all:
	bundle install
	bundle exec thor rebuild
