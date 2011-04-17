  require 'spec_helper'

  describe Objective do

    before(:each) do
      @attr = { :name => "目標１", :description => "まずをこれを会得する" }
    end

	describe "必須項目チェック" do
		it "名前が未入力の場合" do
		  objective = Objective.new(@attr.merge(:name => ""))
		  objective.should_not be_valid
		end

		it "上記以外の場合(＝正常パターン)" do
		  Objective.create!(@attr)
		end
    end

	describe "桁数チェック" do
		it "名前がmaxlength+1の場合" do
		  objective = Objective.new(@attr.merge(:name => "a" * 101))
		  objective.should_not be_valid
		end

		it "上記以外の場合(＝正常パターン)" do
		  objective = Objective.new(@attr.merge(:name => "a" * 100))
		  objective.should be_valid
		end
    end
  end
