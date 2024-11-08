require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  render_views

  describe 'POST /users' do
    it 'renders new user object' do
      post :create, params: {
        user: {
          email: 'unique@test.com',
          password: 'asdasdasd',
          username: '12345678'
        }
      }

      expect(response.body).to eq({
        user: {
          username: '12345678',
          email: 'unique@test.com'
        }
      }.to_json)
    end
  end
end
