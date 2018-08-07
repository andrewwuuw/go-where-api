require 'rails_helper'

RSpec.describe 'Friend API', type: :request do
  # --------init variable--------
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
  #  -----------------------------

  describe 'get /friends' do
    before {
      post "/friends/apply/#{me.id}", headers: {Authorization: user.id}
      get "/friends/applicant", headers: {Authorization: me.id}
      post '/friends', params: {applicants: json.apply_me}, headers: {Authorization: me.id}
    }

    context 'when friends the request is valid' do
      it 'search friend list and returns status code 200' do
        get '/friends', headers: {Authorization: me.id}
        friends = json.friends.map{|val| OpenStruct.new(val).friend_id}
        expect(response).to have_http_status(200)
        expect(friends).to match_array user.id
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
    context 'when apply the request is valid' do
      it 'apply for friend and returns status code 200' do
        post "/friends/apply/#{user.id}", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Apply for friend success/
      end
    end

    context 'when apply the request is invalid' do
      it 'apply for friend failed and returns status code 200' do
        post "/friends/apply/#{user.id}", headers: {Authorization: me.id}
        post "/friends/apply/#{me.id}", headers: {Authorization: user.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Please recheck friend application list/
      end

      it 'returns status code 404 and validation failure message' do
        post "/friends/apply/#{user.id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end


  describe 'POST /friends/applicant' do
    before {
      post "/friends/apply/#{user.id}", headers: {Authorization: me.id}
    }

    context 'when applicant the request is valid' do
      it 'get applicants and returns status code 200' do
        get "/friends/applicant", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(json.my_apply).to match_array user.id
      end

      it 'get applicants and returns status code 200' do
        get "/friends/applicant", headers: {Authorization: user.id}
        expect(response).to have_http_status(200)
        expect(json.apply_me).to match_array me.id
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
    let(:user_list) {
      get "/friends/applicant", headers: {Authorization: me.id}
      json
    }

    before {
      post "/friends/apply/#{me.id}", headers: {Authorization: user.id}
    }

    context 'when friends the request is valid' do
      it 'agree friend apply and returns status code 200' do
        post '/friends', params: {all: true}, headers: {Authorization: me.id}, as: :json
        expect(response).to have_http_status(200)
        expect(response.body).to match /Add all success/
      end

      it 'agree friend apply and returns status code 200' do
        post '/friends', params: {applicants: user_list.apply_me}, headers: {Authorization: me.id}
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
        post "/friends", headers: {Authorization: me.id}
        expect(response).to have_http_status(422)
        expect(response.body).to match /Miss params: all or applicants/
      end
    end
  end

  describe 'delete /friends' do
    before {
      post "/friends/apply/#{me.id}", headers: {Authorization: user.id}
      get "/friends/applicant", headers: {Authorization: me.id}
      post '/friends', params: {applicants: json.apply_me}, headers: {Authorization: me.id}
    }

    context 'when friends the request is valid' do
      it 'remove friend and returns status code 200' do
        delete "/friends/#{user.id}", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Remove Friend Success/
      end
    end
    
    context 'when applicant the request is invalid' do
      it 'friend doesn\'t exist and returns status code 200' do
        delete "/friends/0", headers: {Authorization: me.id}
        expect(response).to have_http_status(404)
        expect(response.body).to match /Your friend doesn't exist/
      end

      it 'returns status code 404 and validation failure message' do
        delete "/friends/#{user.id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end

  describe 'delete /friends/apply' do
    let(:user2) {
      post '/sign_up', params: {user: {email: Faker::Internet.email, password: pwd, password_confirmation: pwd}}
      OpenStruct.new(json.user)
    }
    let(:id) {
      post "/friends/apply/#{me.id}", headers: {Authorization: user.id}
      json.id
    }
    let(:id2) {
      post "/friends/apply/#{user2.id}", headers: {Authorization: user.id}
      json.id
    }
    
    context 'when the request is valid' do
      it 'reject apply and returns status code 200' do
        delete "/friends/apply/#{id}", headers: {Authorization: me.id}
        expect(response).to have_http_status(200)
        expect(response.body).to match /Reject Apply Success/
      end
    end

    context 'when the request is invalid' do
      it 'reject apply and returns status code 200' do
        delete "/friends/apply/#{id2}", headers: {Authorization: me.id}
        expect(response).to have_http_status(404)
        expect(response.body).to match /This application doesn't exist/
      end

      it 'returns status code 404 and validation failure message' do
        delete "/friends/apply/#{id}"
        expect(response).to have_http_status(404)
        expect(response.body).to match /Header can't find the key: Authorization/
      end
    end
  end
end