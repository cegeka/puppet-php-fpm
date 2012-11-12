#!/usr/bin/env rspec

require 'spec_helper'

describe 'php-fpm' do
  it { should contain_class 'php-fpm' }
end
