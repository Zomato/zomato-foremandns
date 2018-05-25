require 'spec_helper'
describe 'foremandns' do
  context 'with default values for all parameters' do
    it { should contain_class('foremandns') }
  end
end
