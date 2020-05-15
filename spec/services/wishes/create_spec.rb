require 'rails_helper'

RSpec.describe Wishes::Create, type: :service do
  let(:service_instance) { described_class.new(*params) }
  subject(:call_service) { service_instance.call }

  let(:user) { build_stubbed(:user) }

  let(:wish_attributes) { { body: 'body', url: 'url' } }
  let(:params) { [ user, wish: wish_attributes ] }

  context 'without dependecies' do
    let(:factory) { double }

    before do
      allow(service_instance).to receive(:wish_factory).and_return(factory)
    end

    it 'calls factory' do
      expect(factory).to receive(:create).with(wish_attributes)

      call_service
    end
  end

  context 'with real dependecies' do
    let(:user) { create(:user) }

    it 'creates a wish' do
      expect { call_service }.to change(Wish, :count).by(1)
    end
  end
end
