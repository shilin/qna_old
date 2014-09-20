require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }
    it 'creates a new question and assigns it to @question' do
      
    end
    it 'renders a new view' do
      expect(response).to render_template :new
    end
  end

end
