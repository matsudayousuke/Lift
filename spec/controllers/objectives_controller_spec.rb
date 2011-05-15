require 'spec_helper'

describe ObjectivesController do

  render_views

  before do
    @user = test_sign_in(Factory(:user))
  end

  describe "GET 'new'" do
    it "新規画面が表示される" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do

    before do
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

    it "成功メッセージがセットされている" do
      post :create, :objective => @attr
      flash[:success].should == I18n.t(:register_success, I18n.t(:objective))
    end
  end

  describe "GET 'edit'" do

    before do
      @objective = Factory(:objective)
    end

    it "渡されたidの目標が表示される" do
      get :edit, :id => @objective
      response.should be_success
    end
  end

  describe "POST 'update" do

    describe "エラーパターン" do

      before do
        @objective = Factory(:objective)
        @attr = {
          :name => "",
          :description => "",
          :order => nil,
          :tag_list => "",
          :user_id => nil
          }
      end

      it "editページに画面遷移されている" do
        put :update, :id => @objective, :objective => @attr
        response.should render_template('edit')
      end
    end

    describe "正常パターン" do

      before do
        @objective = Factory(:objective)
        @attr = {
          :name => "edit objective",
          :description => "update objective",
          :order => 33,
          :tag_list => "business, programming",
          :user_id => @user.id
          }
      end

      it "目標の各プロパティが更新されている" do
        post :update, :id => @objective, :objective => @attr
        @objective.reload
        @objective.name.should == @attr[:name]
        @objective.description.should == @attr[:description]
        @objective.order.should == @attr[:order]
        @objective.tag_list.should == @attr[:tag_list].split(", ")
        @objective.user_id.should == @attr[:user_id]
      end

      it "ユーザのルートページに画面遷移されている" do
        post :update, :id => @objective, :objective => @attr
        response.should redirect_to root_path
      end
    end

  end

  describe "DELETE 'destroy'" do

    before do
      @objective = Factory(:objective)
    end

    describe "正常パターン" do

      it "目標が削除されている" do
        lambda do
          delete :destroy, :id => @objective
        end.should change(Objective, :count).by(-1)
      end

      it "ルートに画面遷移されている" do
        delete :destroy, :id => @objective
        response.should redirect_to root_path
      end
    end
  end
end
