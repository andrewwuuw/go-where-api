require 'rails_helper'

RSpec.describe 'User API', type: :request do
  describe 'POST /sign_up' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    let(:valid_attributes) {{user: {email: email, password: pwd, password_confirmation: pwd}}}

    context 'when sign_up the request is valid' do
      before { post '/sign_up', params: valid_attributes }

      it 'creates a user and returns status code 200' do
        expect(json['user']['email']).to eq email
        expect(response).to have_http_status(200)
      end
    end

    context 'when sign_up the request is invalid' do
      it 'returns status code 422 and validation failure message' do
        post '/sign_up', params: {user: {password: pwd, password_confirmation: pwd}}
        expect(response).to have_http_status(422)
        expect(response.body).to match(/Validation failed: Email can't be blank/)
      end

      it 'returns status code 422 and validation failure message' do
        post '/sign_up', params: {user: {email: email, password: pwd}}
        expect(response).to have_http_status(422)
        expect(response.body).to match(/password_confirmation can't be blank/)
      end

      it 'returns status code 422 and validation failure message' do
        post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: 123}}
        expect(response).to have_http_status(422)
        expect(response.body).to match(/The values should be same./)
      end
    end
  end

  describe 'POST /sign_in' do
    let(:email) {Faker::Internet.email}
    let(:pwd) {Faker::Internet.password}
    before {post '/sign_up', params: {user: {email: email, password: pwd, password_confirmation: pwd}}}

    context 'when sign_in the request is valid' do
      before :each do
        post '/sign_in', params: {email: email, password: pwd}
      end

      it 'Login After Registered and returns status code 200' do
        expect(json['user_id']).to eq json['user_id']
        expect(response).to have_http_status(200)
      end
    end

    context 'when sign_up the request is invalid' do
      it 'Email failed and returns status code 422 and validation failure message' do
        post '/sign_in', params: {email: "abc@a.a", password: pwd}
        expect(response).to have_http_status(422)
        expect(response.body).to match(/Email or Password is uncorrect/)
      end

      it 'Password failed and returns status code 422 and validation failure message' do
        post '/sign_in', params: {email: email, password: "123"}
        expect(response).to have_http_status(422)
        expect(response.body).to match(/Email or Password is uncorrect/)
      end
    end
  end
end