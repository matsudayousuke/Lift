require 'spec_helper'

describe ObjectivesController do

  render_views

  describe "GET 'new'" do
    
    before do
      @user = test_sign_in(Factory(:user))
    end

    it "正常パターン" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do

    before do
      @user = test_sign_in(Factory(:user))
      @tag_list = "work, life"
      @attr = {
        :name => "objective",
        :description => "objective description",
        :order => 1,
        :tag_list => @tag_list,
        :user_id => @user.id
        }
    end

    it "タグが1件登録されている" do
      lambda do
          post :create, :objective => @attr
      end.should change(ActsAsTaggableOn::Tag, :count).by(@tag_list.split(", ").size)
    end

    it "ルートに画面遷移されている" do
      post :create, :objective => @attr
      response.should redirect_to root_path
    end
  end

end
