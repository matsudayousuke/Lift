require 'spec_helper'

describe User do

  describe "登録テスト" do

    before do
      @user = Factory(:user)
    end

    describe "必須項目チェック" do

      context "正常パターン" do
        it {@user.should be_valid}
      end

      context "first_nameが未入力の場合" do
        it do
          @user.first_name = ""
          @user.should_not be_valid
        end
      end

      context "last_nameが未入力の場合" do
        it do
          @user.last_name = ""
          @user.should_not be_valid
        end
      end

      context "user_nameが未入力の場合" do
        it do
          @user.user_name = ""
          @user.should_not be_valid
        end
      end

      context "passwordが未入力の場合" do
        it do
          @user.password = ""
          @user.should_not be_valid
        end
      end

    end

    describe "桁数チェック" do

      context "first_nameがmaxlength+1の場合" do
        it do
          @user.first_name = "a" * 21
          @user.should_not be_valid
        end
      end

      context "上記以外の場合(＝正常パターン)" do
        it do
          @user.first_name = "a" * 20
          @user.should be_valid
        end
      end

      context "last_nameがmaxlength+1の場合" do
        it do
          @user.last_name = "a" * 21
          @user.should_not be_valid
        end
      end

      context "上記以外の場合(＝正常パターン)" do
        it do
          @user.last_name = "a" * 20
          @user.should be_valid
        end
      end

      context "user_nameがmaxlength+1の場合" do
        it do
          @user.user_name = "a" * 21
          @user.should_not be_valid
        end
      end

      context "上記以外の場合(＝正常パターン)" do
        it do
          @user.user_name = "a" * 20
          @user.should be_valid
        end
      end

      context "passwordがminlength-1の場合" do
        it do
          @user.password = "a" * 3
          @user.password_confirmation = @user.password
          @user.should_not be_valid
        end
      end

      context "上記以外の場合(＝正常パターン)" do
        it do
          @user.password = "a" * 4
          @user.password_confirmation = @user.password
          @user.should be_valid
        end
      end

      context "passwordがmaxlength+1の場合" do
        it do
          @user.password = "a" * 21
          @user.password_confirmation = @user.password
          @user.should_not be_valid
        end
      end

      context "上記以外の場合(＝正常パターン)" do
        it do
          @user.password = "a" * 20
          @user.password_confirmation = @user.password
          @user.should be_valid
        end
      end
    end

    describe "パスワード妥当性検証ロジックテスト" do

      context "正常パターン" do
        it {@user.should be_valid}
      end

      context "confirmationと一致しない場合" do
        it do
          @user.password_confirmation = "invalid"
          @user.should_not be_valid
        end
      end
    end

    describe "パスワード暗号化ロジックテスト" do
      it {@user.encrypted_password.should_not be_blank}
      it {@user.should respond_to(:encrypted_password)}
    end

  end

  describe "#has_password?" do

    before do
      @password = "testpassword"
      @user = Factory(:user, :password => @password, :password_confirmation => @password)
    end

    it {@user.has_password?(@password).should be_true}

    it {@user.has_password?("invalid").should be_false}
  end

  describe "#authenticate" do

    before do
      @user = Factory(:user)
    end

    context "user_nameとpasswordが一致しない場合" do
      it do
        wrong_password_user = User.authenticate(@user.user_name, "wrongpass")
        wrong_password_user.should be_nil
      end

      it do
        nonexistent_user = User.authenticate("wrongname", @user.password)
        nonexistent_user.should be_nil
      end
    end

    context "user_nameとpasswordが一致する場合" do
      it do
        matching_user = User.authenticate(@user.user_name, @user.password)
        matching_user.should == @user
      end
    end
  end

  describe "#objectives" do

    describe "抽出ロジックテスト" do

      context "他のユーザの目標も登録されている場合" do

        before do
          @matsuda = Factory(:user, :user_name => "matsuda")
          @kenjin  = Factory(:user, :user_name => "kenjin")
          @yabu    = Factory(:user, :user_name => "yabu")
          @matsuda_objectives = Array.new
          @kenjin_objectives = Array.new
          @yabu_objectives = Array.new
          3.times {@matsuda_objectives << Factory(:objective, :user => @matsuda)}
          3.times {@kenjin_objectives  << Factory(:objective, :user => @kenjin)}
          3.times {@yabu_objectives    << Factory(:objective, :user => @yabu)}
        end

        it "自身の目標のみが取得されている" do
          User.find(@matsuda.id).objectives.should == @matsuda_objectives
          User.find(@kenjin.id).objectives.should == @kenjin_objectives
          User.find(@yabu.id).objectives.should == @yabu_objectives
        end
      end
    end

    describe "ソートロジックテスト" do

      before do
        @user = Factory(:user)
        @objectives = Array.new
        @objectives << Factory(:objective, :user => @user, :order => 3)
        @objectives << Factory(:objective, :user => @user, :order => 2)
        @objectives << Factory(:objective, :user => @user, :order => 1)
      end

      it do
        User.find(@user.id).objectives.should == @objectives.reverse
      end
    end
  end
end
