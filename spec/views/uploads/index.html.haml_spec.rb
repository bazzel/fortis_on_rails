require 'spec_helper'

describe "uploads/index.html.haml" do
  before(:each) do
    assign(:uploads, [
      stub_model(Upload,
        :balance_start => 1,
        :balance_end => 1
      ),
      stub_model(Upload,
        :balance_start => 1,
        :balance_end => 1
      )
    ])
  end

  it "renders a list of uploads" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
