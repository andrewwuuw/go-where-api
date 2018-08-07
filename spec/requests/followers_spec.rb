require 'rails_helper'

RSpec.describe 'Follower API', type: :request do
  describe 'POST /followers/apply' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    let(:me) {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    let(:public_user) {
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    let(:private_user) {
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd, is_public: false}}
      OpenStruct.new(json.user)
    }

    context 'when apply public user the request is valid' do
      it 'apply for follower and returns status code 200' do
        post "/followers/apply/#{public_user.id}", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Follow success/
      end
    end

    context 'when apply private user the request is valid' do
      it 'apply for follower and returns status code 200' do
        post "/followers/apply/#{private_user.id}", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Apply for follow success/
      end
    end

    context 'when apply the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        post "/followers/apply/#{public_user.id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end

  describe 'POST /followers/applicant' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    let(:me) {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    let(:user) {
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd, is_public: false}}
      OpenStruct.new(json.user)
    }
    before {
      post "/followers/apply/#{user.id}", headers: {Authorization: me.id}
    }

    context 'when applicant the request is valid' do
      it 'get applicants and returns status code 200' do
        get "/followers/applicant", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(json.my_apply).to match_array user.id
      end
    end

    context 'when applicant the request is valid' do
      it 'get applicants and returns status code 200' do
        get "/followers/applicant", headers: {Authorization: user.id}
        expect(response).to have_http_status(200)
        expect(json.apply_me).to match_array me.id
      end
    end

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        get "/followers/applicant"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end

  describe 'get /followers' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    let(:me) {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    let(:user) {
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }

    context 'when followers the request is valid' do
      it 'search follow me list and returns status code 200' do
        post "/followers/apply/#{me.id}", headers: {Authorization: user.id}
        get '/followers', headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(json.follow_me).to match_array user.id
      end
    end

    context 'when followers the request is valid' do
      it 'search follow me list and returns status code 200' do
        post "/followers/apply/#{user.id}", headers: {Authorization: me.id}
        get '/followers', headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(json.my_follow).to match_array user.id
      end
    end

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        get "/followers"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end

  describe 'delete /followers' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    let(:me) {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    let(:user) {
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    before {
      post "/followers/apply/#{user.id}", headers: {Authorization: me.id}
    }

    context 'when followers the request is valid' do
      it 'remove friend and returns status code 200' do
        delete "/followers/#{user.id}", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Remove Follow Success/
      end
    end

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        delete "/followers/#{user.id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end
end