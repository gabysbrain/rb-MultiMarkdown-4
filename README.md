# Multimarkdown

This is a Ruby interface to the 
[multimarkdown](http://fletcherpenney.net/multimarkdown/) command line 
client written by Fletcher T. Penney.  Multimarkdown is an extension to
plain Markdown which adds support for things like tables, citations, and 
footnotes to the original format.

## Installation

Add this line to your application's Gemfile:

    gem 'multimarkdown-cli'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multimarkdown-cli

## Usage

    >> require 'multimarkdown-cli'

    >> puts MultiMarkdownCLI::Parser.new('Hello, world.').to_html
    # <p>Hello, world.</p>

    >> puts MultiMarkdownCLI::Parser.new('_Hello World!_').to_html
    # <p><em>Hello World!</em></p>

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
