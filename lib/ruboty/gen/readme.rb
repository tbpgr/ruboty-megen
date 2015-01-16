# encoding: utf-8
require 'erb'

# rubocop:disable LineLength
module Ruboty
  module Gen
    # ReadmeGen Core
    class Readme
      README = 'README.md'
      RUBOTY_MEGEN_FILE = 'Rubotyme'
      RUBOTY_MEGEN_TEMPLATE = <<-EOS
# encoding: utf-8

# user_name(github user name)
# user_name is required
# user_name allow only String
# user_name's default value => "user_name"
user_name "user_name"

# gem_class_name
# gem_class_name is required
# gem_class_name allow only String
# gem_class_name's default value => "your_gem_class_name"
# ex: SampleGem (Ruboty::SampleGem)
gem_class_name "your_gem_class_name"

# gem_name
# gem_name is required
# gem_name allow only String
# gem_name's default value => "your_gem_name"
# ex: sample_gem (not ruboty-sample_gem)
gem_name "your_gem_name"

# title
# title is required
# title allow only String
# title's default value => "title"
# ex: output N line messages.
title "title"

# you can set multiple ENV variables
env do |e|
  # name
  # name allow only String
  # name's default value => ""
  e.name "environment variable name"

  # description
  # description allow only String
  # description's default value => ""
  e.description ""
end

# you can set multiple dependencies
dependency do |d|
  # name
  # name allow only String
  # name's default value => ""
  d.name ""

  # description
  # description allow only String
  # description's default value => ""
  d.description ""
end

# you can set multiple commands
command do |c|
  # name
  # name allow only String
  # name's default value => ""
  c.name ""

  # pattern
  # pattern allow only String
  # pattern's default value => ""
  c.pattern ""

  # description
  # description allow only String
  # description's default value => ""
  c.description ""

  # example
  # example allow only String
  # example's default value => ""
  c.example ""
end
      EOS

      RUBOTY_README_TEMPLATE = <<-EOS
# Ruboty::<%=gem_class_name%>

An Ruboty Handler + Actions to <%=title%>.

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-<%=gem_name%>'
```

And then execute:

    $ bundle

## Commands

|Command|Pattern|Description|
|:--|:--|:--|
<%=command_table%>

## Usage
<%=usages%>

## ENV

|Name|Description|
|:--|:--|
<%=env_table%>

## Dependency

|Name|Description|
|:--|:--|
<%=dependency_table%>

## Contributing

1. Fork it ( https://github.com/<%=user_name%>/ruboty-<%=gem_name%>/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
      EOS

      RUBOTY_README_EMOJI_TEMPLATE = <<-EOS
# Ruboty::<%=gem_class_name%>

An Ruboty Handler + Actions to <%=title%>.

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## :arrow_down: Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-<%=gem_name%>'
```

And then execute:

    $ bundle

## :cl: Commands

|Command|Pattern|Description|
|:--|:--|:--|
<%=command_table%>

## :scroll: Usage
<%=usages%>

## :earth_asia: ENV

|Name|Description|
|:--|:--|
<%=env_table%>

## :couple: Dependency

|Name|Description|
|:--|:--|
<%=dependency_table%>

## :two_men_holding_hands: Contributing :two_women_holding_hands:

1. Fork it ( https://github.com/<%=user_name%>/ruboty-<%=gem_name%>/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
      EOS

      # generate Rubotymegenfile to current directory.
      def self.init
        File.open(RUBOTY_MEGEN_FILE, 'w') do |f|
          f.puts RUBOTY_MEGEN_TEMPLATE
        end
      end

      # generate ruboty README.md template.
      def self.generate(options = {})
        src = read_dsl
        dsl = Ruboty::Dsl.new
        dsl.instance_eval src
        src = apply(dsl.ruboty_megen, options)
        File.open(README, 'w:utf-8') { |file|file.puts src }
      end

      def self.read_dsl
        File.open(RUBOTY_MEGEN_FILE) { |f|f.read }
      end
      private_class_method :read_dsl

      # rubocop:disable UselessAssignment
      def self.apply(config, options)
        gem_class_name = config.gem_class_name
        gem_name = config.gem_name
        title = config.title
        command_table = command_table(config.commands)
        usages = usages(config.commands)
        env_table = env_table(config.env)
        dependency_table = dependency_table(config.dependencies)
        user_name = config.user_name

        erb = ERB.new(choose_template(options))
        erb.result(binding)
      end
      private_class_method :apply
      # rubocop:enable UselessAssignment

      def self.command_table(commands)
        command_table = commands.each_with_object([]) do |e, memo|
          command_link = "[#{e.read_name}](##{e.read_name})"
          list = ['', command_link, e.read_pattern, e.read_description, '']
          list = normalize_markdown_table(list)
          memo << list.join('|')
        end
        command_table.join("\n")
      end
      private_class_method :command_table

      def self.usages(commands)
        usages = commands.each_with_object([]) do |e, memo|
          name = e.read_name
          description = e.read_description
          example = e.read_example
          row = ["### #{name}", "* #{description}", '', '~~~', example.chomp, '~~~']
          memo << row.join("\n")
        end
        usages.join("\n\n")
      end
      private_class_method :usages

      def self.env_table(env)
        env_table = env.each_with_object([]) do |e, memo|
          list = ['', e.read_name, e.read_description, '']
          list = normalize_markdown_table(list)
          memo << list.join('|')
        end
        env_table.join("\n")
      end
      private_class_method :env_table

      def self.dependency_table(dependencies)
        dependency_table = dependencies.each_with_object([]) do |e, memo|
          list = ['', e.read_name, e.read_description, '']
          list = normalize_markdown_table(list)
          memo << list.join('|')
        end
        dependency_table.join("\n")
      end
      private_class_method :dependency_table

      def self.normalize_markdown_table(texts)
        texts.map { |e| e.gsub('|', '&#124;') }
      end
      private_class_method :normalize_markdown_table

      def self.choose_template(options)
        options[:emoji] ? RUBOTY_README_EMOJI_TEMPLATE : RUBOTY_README_TEMPLATE
      end
      private_class_method :choose_template
    end
  end
end
# rubocop:enable LineLength
