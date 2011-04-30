require 'spec_helper'

describe Tag do

  describe "#objectives" do

    before do
      @objectives = Array.new
      @objective_tags = Array.new
    end

    describe "抽出ロジックテスト" do

      before do
        @tag = Factory(:tag)
      end

      context "該当する目標が一つもいない場合" do
        it {@tag.should have(0).objectives}
      end

      context "該当する目標が1つ存在する場合" do

        before do
          objective = Factory(:objective)
          @objective_tags << Factory(:objective_tag, :tag => @tag, :objective => objective)
        end

        it do
          Tag.find(@tag.id).should have(@objective_tags.size).objectives
        end
      end

      context "該当する目標が複数存在する場合" do

        before do
          2.times {@objectives << Factory(:objective)}
          @objectives.size.times do |i|
            @objective_tags << Factory(:objective_tag,
              :tag => @tag,
              :objective => @objectives[i])
          end
        end

        it do
          Tag.find(@tag.id).should have(@objective_tags.size).objectives
        end

        context "他のタグのレコードも存在する場合" do
          before do
            @other_tag = Factory(:tag)
            @objectives_of_other_tag = Array.new
            3.times {@objectives_of_other_tag << Factory(:objective)}
            @objectives_of_other_tag.size.times do |i|
              Factory(:objective_tag,
                :tag => @other_tag,
                :objective => @objectives_of_other_tag[i])
            end
          end

          it "自身の目標のタグのみが取得できている" do
            Tag.find(@tag.id).should have(@objective_tags.size).objectives
            Tag.find(@other_tag.id).should have(@objectives_of_other_tag.size).objectives
          end
        end
      end
    end
  end
end
