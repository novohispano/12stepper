require 'spec_helper'

describe "Work a Step" do

  it "pulls up the correct worksheet" do
    login
    select("1",:from=> "work-a-step")
    expect(page).to have_content("Step 1")
  end

end
