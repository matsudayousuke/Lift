require 'spec_helper'

describe Result do

  describe "登録テスト" do
    
    before do
      @result = Result.new
    end

    describe "桁数チェック" do

      context "4001文字以上の場合" do
        it "エラーとなる" do
          @result.body = "a" * 4001
          @result.should_not be_valid
        end
      end

      context "4000文字以下の場合" do
        it "エラーが発生しない" do
          @result.body = "a" * 4000
          @result.should_not be_valid
        end
      end

    end

    describe "目標の関連づけチェック" do

      before do
        @objective = Factory(:objective)
        @result.objective = @objective
        @result.save
      end

      it "目標が正しく関連づけられている" do
        result = Result.find(@result.id)
        result.objective.should == @objective
      end

    end

  end

end
