# encoding: utf-8
require 'spec_helper'
require 'ruboty/gen'

# rubocop:disable LineLength, UnusedMethodArgument
describe Ruboty::Gen::Readme do
  context :generate do
    let(:tmp) { 'tmp' }
    let(:ruboty_megen_template) do
      template = <<-EOS
# encoding: utf-8

user_name 'tbpgr'
gem_class_name 'SampleGem'
gem_name 'sample_gem'
title 'output sample messages'

env do |e|
  e.name 'ENV1'
  e.description 'ENV1 description'
end

env do |e|
  e.name 'ENV2'
  e.description 'ENV2 description'
end

dependency do |d|
  d.name 'dependency1 name'
  d.description 'dependency1 description'
end

dependency do |d|
  d.name 'dependency2 name'
  d.description 'dependency2 description'
end

command do |c|
  c.name 'command1'
  c.pattern '/command1 | hoge/'
  c.description 'command1 description'
  c.example <<-EOT
example1_1
example1_2
  EOT
end

command do |c|
  c.name 'command2'
  c.pattern '/command2 | hoge/'
  c.description 'command2 description'
  c.example <<-EOT
example2_1
example2_2
  EOT
end
      EOS
      template
    end

    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        options: {},
        expected: <<-EOS
# Ruboty::SampleGem

An Ruboty Handler + Actions to output sample messages.

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-sample_gem'
```

And then execute:

    $ bundle

## Commands

|Command|Pattern|Description|
|:--|:--|:--|
|[command1](#command1)|/command1 &#124; hoge/|command1 description|
|[command2](#command2)|/command2 &#124; hoge/|command2 description|

## Usage
### command1
* command1 description

~~~
example1_1
example1_2
~~~

### command2
* command2 description

~~~
example2_1
example2_2
~~~

## ENV

|Name|Description|
|:--|:--|
|ENV1|ENV1 description|
|ENV2|ENV2 description|

## Dependency

|Name|Description|
|:--|:--|
|dependency1 name|dependency1 description|
|dependency2 name|dependency2 description|

## Contributing

1. Fork it ( https://github.com/tbpgr/ruboty-sample_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
        EOS
      },
      {
        case_no: 1,
        case_title: 'valid case',
        options: { emoji: true },
        expected: <<-EOS
# Ruboty::SampleGem

An Ruboty Handler + Actions to output sample messages.

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## :arrow_down: Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-sample_gem'
```

And then execute:

    $ bundle

## :cl: Commands

|Command|Pattern|Description|
|:--|:--|:--|
|[command1](#command1)|/command1 &#124; hoge/|command1 description|
|[command2](#command2)|/command2 &#124; hoge/|command2 description|

## :scroll: Usage
### command1
* command1 description

~~~
example1_1
example1_2
~~~

### command2
* command2 description

~~~
example2_1
example2_2
~~~

## :earth_asia: ENV

|Name|Description|
|:--|:--|
|ENV1|ENV1 description|
|ENV2|ENV2 description|

## :couple: Dependency

|Name|Description|
|:--|:--|
|dependency1 name|dependency1 description|
|dependency2 name|dependency2 description|

## :two_men_holding_hands: Contributing :two_women_holding_hands:

1. Fork it ( https://github.com/tbpgr/ruboty-sample_gem/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
        EOS
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when --
          Ruboty::Gen::Readme.generate(c[:options])
          actual = File.open(Ruboty::Gen::Readme::README, 'r:utf-8') { |e|e.read }

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        FileUtils.mkdir_p(tmp) unless Dir.exist? tmp
        Dir.chdir(tmp)
        File.open(Ruboty::Gen::Readme::RUBOTY_MEGEN_FILE, 'w:utf-8') do |file|
          file.puts ruboty_megen_template
        end
      end

      def case_after(_c)
        Dir.chdir('../')
        FileUtils.rm_rf(tmp) if Dir.exist? tmp
      end
    end
  end
end
# rubocop:enable LineLength, UnusedMethodArgument
