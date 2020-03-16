[![Build Status](https://travis-ci.org/glenbray/elastic_parser.svg?branch=master)](https://travis-ci.org/glenbray/elastic_parser)

# ElasticParser

Build an elasticsearch query from a search expression.

**Code for**
- https://dev.to/glenbray/search-parser-part-1-45m4
- https://dev.to/glenbray/search-parser-part-2-683

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elastic_parser'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install elastic_parser

## Usage

#### Simple term search

```ruby
ElasticParser.parse("word")
```


#### Phrase search

```ruby
ElasticParser.parse('"search for this exact string"')
```


#### Perform `AND` operations

```ruby
ElasticParser.parse("a b c")
```
or

```ruby
ElasticParser.parse("a AND b AND c")
```


#### Perform `OR` operations

```ruby
ElasticParser.parse("a OR b OR c")
```


#### Perform `NOT` operations

```ruby
ElasticParser.parse("a -b")
```


#### Grouping

```ruby
ElasticParser.parse("a (b (c (e d)))")
```



