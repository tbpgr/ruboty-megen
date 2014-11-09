# Ruboty::Gen::Readme

Generate README.md for Ruboty Handler + Actions plugin.

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-megen'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruboty-megen

## Rubotyme
### Setting File Parameters

|key|value|example|
|:--|:--|:--|
|user_name|github user name|tbpgr|
|gem_class_name|gem class name|Ume|
|gem_name|gem name|ume|
|title|title|An Ruboty Handler + Actions to output N line messages.|
|env/name|ENV variable name|DEFAULT_UME_TEXT|
|env/description|ENV description|default ume text|
|dependencies/name|dependency name|Ume API|
|dependencies/description|dependency description|this plugin depend on XXX API ver 1.2.3|
|commands/command name|Ruboty::Handler.on name|ume|
|commands/command pattern|Ruboty::Handler.on pattern|/ume (?<count>.*?)\z/  |
|commands/command description|Ruboty::Handler.on description|output empty message N lines (<count> times)|

## Usage
### init
generate Rubotyme template file.

~~~
$ ruboty-megen init
~~~

### generate
generate Ruboty Handler + Action README.md template

* edit Rubotyme file

~~~ruby
# encoding: utf-8
user_name "tbpgr"

gem_class_name "Ume"
gem_name "ume"

title "An Ruboty Handler + Actions to output N line messages."

env do |e|
  e.name "ENV1"
  e.description "ENV1 desc"
end

env do |e|
  e.name "ENV2"
  e.description "ENV2 desc"
end

dependency do |d|
  d.name "dependency2"
  d.description "dependency2 description"
end

command do |c|
  c.name "ume"
  c.pattern "/ume (?<count>.*?)\z/"
  c.description "output empty message N lines (<count> times)"
end

command do |c|
  c.name "umec"
  c.pattern "/umec (?<text>.+?) (?<count>.*?)\z/"
  c.description "output <text> message N lines (<count> times)"
end
~~~

* generate README

~~~
$ ruboty-megen generate
~~~

* output

[sample output ruboty-ume README](./sample/README.md)

## Contributing

1. Fork it ( https://github.com/tbpgr/ruboty_megen/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
