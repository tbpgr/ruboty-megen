# Ruboty::Ume

An Ruboty Handler + Actions to An Ruboty Handler + Actions to output N line messages..

[Ruboty](https://github.com/r7kamura/ruboty) is Chat bot framework. Ruby + Bot = Ruboty

## :arrow_down: Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruboty-ume'
```

And then execute:

    $ bundle

## :cl: Commands

|Command|Pattern|Description|
|:--|:--|:--|
|[ume](#ume)|/ume (?<count>.*?)z/|output empty message N lines (<count> times)|
|[umec](#umec)|/umec (?<text>.+?) (?<count>.*?)z/|output <text> message N lines (<count> times)|

## :scroll: Usage
### ume
* output empty message N lines (<count> times)

~~~
> ruboty help
ruboty /ume (?<count>.*?)z/               - output empty message N lines (<count> times)
> ruboty ume 3
.
.
.
> ruboty ume 5
.
.
.
.
.
~~~

### umec
* output <text> message N lines (<count> times)

~~~
> ruboty help
ruboty /umec (?<text>.+?) (?<count>.*?)z/ - output <text> message N lines (<count> times)
> ruboty umec hoge 3
hoge
hoge
hoge

> ruboty umec hoge 5
hoge
hoge
hoge
hoge
hoge

~~~

## :earth_asia: ENV

|Name|Description|
|:--|:--|
|ENV1|ENV1 desc|
|ENV2|ENV2 desc|

## :couple: Dependency

|Name|Description|
|:--|:--|
|dependency2|dependency2 description|

## :two_men_holding_hands: Contributing :two_women_holding_hands:

1. Fork it ( https://github.com/tbpgr/ruboty-ume/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
