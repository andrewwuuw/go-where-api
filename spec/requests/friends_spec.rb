require 'rails_helper'

RSpec.describe 'Friend API', type: :request do
  describe 'get /friends' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    before {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      @me = OpenStruct.new(json['user'])
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      @user = OpenStruct.new(json['user'])
      post "/friends/apply/#{@me.id}", headers: {Authorization: @user.id}
      get "/friends/applicant", headers: {Authorization: @me.id}
      user_list = OpenStruct.new(json)
      post '/friends', params: {applicants: user_list.apply_me}, headers: {Authorization: @me.id}
    }

    context 'when friends the request is valid' do
      it 'search friend list and returns status code 200' do
        get '/friends', headers: {Authorization: @me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /#{@user.id}/
      end
    end

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        get "/friends"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end


  describe 'POST /friends/apply' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    
    before {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      @me = OpenStruct.new(json['user'])
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      @user = OpenStruct.new(json['user'])
    }

    context 'when apply the request is valid' do
      it 'apply for friend and returns status code 200' do
        post "/friends/apply/#{@user.id}", headers: {Authorization: @me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Apply for friend success/
      end
    end

    context 'when apply the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        post "/friends/apply/#{@user.id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end


  describe 'POST /friends/applicant' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    before {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      @me = OpenStruct.new(json['user'])
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      @user = OpenStruct.new(json['user'])
      post "/friends/apply/#{@user.id}", headers: {Authorization: @me.id}
    }

    context 'when applicant the request is valid' do
      it 'get applicants and returns status code 200' do
        get "/friends/applicant", headers: {Authorization: @me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /#{@user.id}/
      end
    end

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        get "/friends/applicant"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end


  describe 'POST /friends' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    before {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      @me = OpenStruct.new(json['user'])
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      @user = OpenStruct.new(json['user'])
      post "/friends/apply/#{@me.id}", headers: {Authorization: @user.id}
    }
    let(:user_list) {
      get "/friends/applicant", headers: {Authorization: @me.id}
      OpenStruct.new(json)
    }

    context 'when friends the request is valid' do
      it 'agree friend apply and returns status code 200' do
        post '/friends', params: {all: true}, headers: {Authorization: @me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Add all success/
      end

      it 'agree friend apply and returns status code 200' do
        post '/friends', params: {applicants: user_list.apply_me}, headers: {Authorization: @me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Agree friend success/
      end
    end    

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        post "/friends"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
      
      it 'returns status code 422 and validation failure message' do
        post "/friends", headers: {Authorization: @me.id}
        expect(response).to have_http_status(422)
        expect(response.body).to match /Miss params: all or applicants/
      end
    end
  end

  describe 'delete /friends' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    before {
      post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}
      @me = OpenStruct.new(json['user'])
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      @user = OpenStruct.new(json['user'])
      post "/friends/apply/#{@me.id}", headers: {Authorization: @user.id}
      get "/friends/applicant", headers: {Authorization: @me.id}
      user_list = OpenStruct.new(json)
      post '/friends', params: {applicants: user_list.apply_me}, headers: {Authorization: @me.id}
    }

    context 'when friends the request is valid' do
      it 'remove friend and returns status code 200' do
        delete "/friends/#{@user.id}", headers: {Authorization: @me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Delete success/
      end
    end

    context 'when applicant the request is invalid' do
      it 'returns status code 404 and validation failure message' do
        delete "/friends/#{@user.id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end
end