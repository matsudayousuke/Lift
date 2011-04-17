  require 'spec_helper'

  describe Objective do

    before(:each) do
      @objective = Factory(:objective)
    end

	describe "必須項目チェック" do
		it "名前が未入力の場合" do
		  @objective.name = ""
		  @objective.should_not be_valid
		end

		it "上記以外の場合(＝正常パターン)" do
		  @objective.should be_valid
		end
    end

	describe "桁数チェック" do
		it "名前がmaxlength+1の場合" do
		  @objective.name = "a" * 101
		  @objective.should_not be_valid
		end

		it "上記以外の場合(＝正常パターン)" do
		  @objective.name = "a" * 100
		  @objective.should be_valid
		end
    end
  end
