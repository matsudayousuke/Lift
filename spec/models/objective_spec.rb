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

  describe "検索テスト" do
    before do
      @objectives = Array.new
      3.times {@objectives.push(Factory(:objective))}
    end

    describe "ソートテスト" do
      context "正常パターン" do
        it do
          objectives = Objective.search()
          objectives.size.should == @objectives.size
          objectives.should be_eql(@objectives)
        end
      end
    end
  end
end
