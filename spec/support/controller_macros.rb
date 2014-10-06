module ControllerMacros
  def sign_in_user
    before do
      @user = create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @user
    end
  end

  def user_is_question_author
    before do
      question.user = @user
      question.save
    end

  end
end
