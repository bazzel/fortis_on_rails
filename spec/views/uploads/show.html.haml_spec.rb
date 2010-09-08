require 'spec_helper'

describe "uploads/show.html.haml" do
  before(:each) do
    @upload = assign(:upload, stub_model(Upload,
      :balance_start => 1,
      :balance_end => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
  end
end
