require 'spec_helper'

describe ObjectivesController do

  render_views

  describe "GET 'new'" do
    
    it "正常パターン" do
      get 'new'
      response.should be_success
      response.should have_selector("input[type=text]#objective_name", :content => "")
      response.should have_selector("textarea#objective_description", :content => "")
      response.should have_selector("input[type=text]#objective_order", :content => "")
    end
  end

end
