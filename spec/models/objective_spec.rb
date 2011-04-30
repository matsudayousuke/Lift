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
  end

  describe "#tags" do

    describe "抽出ロジックテスト" do

      before do
        @objective_tags = Array.new
        @objective = Factory(:objective)
      end

      context "タグが何も設定されていない場合" do
        it {@objective.should have(0).tags}
      end

      context "タグが1つ設定されている場合" do

        before do
          tag = Factory(:tag)
          @objective_tags << Factory(:objective_tag, :tag => tag, :objective => @objective)
        end

        it do
          Objective.find(@objective.id).should have(@objective_tags.size).tags
        end
      end

      context "複数のタグが設定されている場合" do

        before do
          @tags = Array.new
          @tags << Factory(:tag)
          @tags << Factory(:tag)
          @tags.size.times do |i|
            @objective_tags << Factory(:objective_tag,
              :tag => @tags[i],
              :objective => @objective)

          end
        end

        it do
          Objective.find(@objective.id).should have(@objective_tags.size).tags
        end

        context "他の目標のレコードも存在する場合" do
          before do
            @other_objective = Factory(:objective)
            @tags_of_other_objective = Array.new
            3.times {@tags_of_other_objective << Factory(:tag)}
            @tags_of_other_objective.size.times do |i|
              Factory(:objective_tag,
                :tag => @tags_of_other_objective[i],
                :objective => @other_objective)
            end
          end

          it "自身の目標のタグのみが取得できている" do
            Objective.find(@objective.id).should have(@objective_tags.size).tags
            Objective.find(@other_objective.id).should have(@tags_of_other_objective.size).tags
          end
        end
      end
    end
  end
end
