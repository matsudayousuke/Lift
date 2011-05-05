require 'spec_helper'

describe ObjectivesController do

  render_views

  describe "GET 'new'" do
    
    it "正常パターン" do
      get 'new'
      response.should be_success
      response.should have_selector("input[type=text]#objective_name", :content => "")
      response.should have_selector("textarea#objective_description", :content => "")
      response.should have_selector("input[type=text]#objective_order", :content => "")
    end
  end

  describe "POST 'create'" do

    before do
      @user = test_sign_in(Factory(:user))
      @objective = Factory(:objective, :user => @user)
    end

    it "タグが1件登録されている" do
      lambda do
        post :create, :objective_tag => { :objective_id => @objecitve, :name => 'new tag' }
        response.should be_redirect
      end.should change(ObjectiveTag, :count).by(1)
    end
  end

end
