require 'spec_helper'

describe "uploads/edit.html.haml" do
  before(:each) do
    @upload = assign(:upload, stub_model(Upload,
      :new_record? => false,
      :balance_start => 1,
      :balance_end => 1
    ))
  end

  it "renders the edit upload form" do
    render

    rendered.should have_selector("form", :action => upload_path(@upload), :method => "post") do |form|
      form.should have_selector("input#upload_balance_start", :name => "upload[balance_start]")
      form.should have_selector("input#upload_balance_end", :name => "upload[balance_end]")
    end
  end
end
