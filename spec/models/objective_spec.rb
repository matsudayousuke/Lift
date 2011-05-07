require 'spec_helper'

describe Objective do

  describe "登録テスト" do

    before do
      @objective = Factory.build(:objective)
    end

    describe "必須項目チェック" do

      context "正常パターン" do
        it {@objective.should be_valid}
      end

      context "名前が未入力の場合" do
        it do
          @objective.name = ""
          @objective.should_not be_valid
        end
      end

      context "ユーザidが未入力の場合" do
        it do
          @objective.user_id = nil
          @objective.should_not be_valid
        end
      end

    end

    describe "桁数チェック" do

      context "名前がmaxlength+1の場合" do
        it do
          @objective.name = "a" * 101
          @objective.should_not be_valid
        end
      end

      context "上記以外の場合(＝正常パターン)" do
        it do
          @objective.name = "a" * 100
          @objective.should be_valid
        end
      end
    end

    describe "タグの登録ロジックチェック" do
      it do
        lambda do
          @objective.tag_list = "life, work, 趣味"
          @objective.save
        end.should change(ActsAsTaggableOn::Tag, :count).by(3)
      end
    end
  end

end
