require 'rails_helper'

RSpec.describe Wishes::CreateFromTelegram, type: :service do
  let(:service_instance) { described_class.new(params) }
  subject(:call_service) { service_instance.call }
  let(:params) { { telegram_user: telegram_user_attributes, wish: wish_attributes } }

  let(:wish_attributes) { { body: 'body', url: 'url' } }
  let(:chat_id) { 123 }
  let(:telegram_user_attributes) do
    {
      chat_id: chat_id,
      username: 'username',
      firstname: 'firstname',
      lastname: 'lastname'
    }
  end

  context 'without dependencies' do
    let(:user_mock) { double }
    let(:create_service) { Wishes::Create }

    before do
      allow(user_mock).to receive(:id).and_return(1)
      allow(service_instance).to receive(:user).and_return(user_mock)
    end

    it 'calls Wishes::Create' do
      expect(create_service).to receive(:call).with(user_id: 1, wish: wish_attributes).once

      call_service
    end
  end

  context 'with real dependecies' do
    context 'and user already exists' do
      let!(:user_id) { create(:user, telegram_id: chat_id).id }

      it 'creates a wish for user' do
        expect { call_service }.to change(Wish, :count).by(1)
        expect(subject).to have_attributes(user_id: user_id, **wish_attributes)
      end
    end

    context 'and user does not exist' do
      it 'creates a user and wish for created user' do
        expect { call_service }.to change(User, :count).by(1)
                                                       .and change(Wish, :count).by(1)
        expect(subject).to have_attributes(user_id: service_instance.send(:user).id, **wish_attributes)
      end
    end
  end
end
