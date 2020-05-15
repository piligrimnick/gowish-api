require 'rails_helper'

RSpec.describe Wishes::Create, type: :service do
  let(:service_instance) { described_class.new(params) }
  subject(:call_service) { service_instance.call }
  let(:params) { { user_id: user_id, wish: wish_attributes } }

  let(:user_id) { 1 }
  let(:wish_attributes) { { body: 'body', url: 'url' } }

  context 'without dependencies' do
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
    let(:user_id) { create(:user).id }

    it 'creates a wish' do
      expect { call_service }.to change(Wish, :count).by(1)
      expect(subject).to have_attributes(user_id: user_id, **wish_attributes)
    end
  end
end
