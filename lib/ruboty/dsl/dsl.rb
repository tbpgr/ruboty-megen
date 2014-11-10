# encoding: utf-8
require 'ruboty/dsl/dsl_model'
require 'ruboty/models/env'
require 'ruboty/models/dependency'
require 'ruboty/models/command'

module Ruboty
  # Dsl
  class Dsl
    attr_accessor :ruboty_megen

    [:user_name, :gem_class_name, :gem_name, :title].each do |f|
      define_method f do |value|
        @ruboty_megen.send("#{f}=", value)
      end
    end

    def env
      e = Ruboty::Models::Env.new
      yield(e)
      @ruboty_megen.env << e
    end

    def dependency
      d = Ruboty::Models::Dependency.new
      yield(d)
      @ruboty_megen.dependencies << d
    end

    def command
      c = Ruboty::Models::Command.new
      yield(c)
      @ruboty_megen.commands << c
    end

    def initialize
      @ruboty_megen = Ruboty::DslModel.new
      @ruboty_megen.user_name = 'your github username'
      @ruboty_megen.gem_class_name = 'your_gem_class_name'
      @ruboty_megen.gem_name = 'your_gem_name'
      @ruboty_megen.title = 'title'
      @ruboty_megen.env = []
      @ruboty_megen.dependencies = []
      @ruboty_megen.commands = []
    end
  end
end
