require 'spec_helper'

describe "uploads/new.html.haml" do
  before(:each) do
    assign(:upload, stub_model(Upload,
      :new_record? => true,
      :balance_start => 1,
      :balance_end => 1
    ))
  end

  it "renders new upload form" do
    render

    rendered.should have_selector("form", :action => uploads_path, :method => "post") do |form|
      form.should have_selector("input#upload_balance_start", :name => "upload[balance_start]")
      form.should have_selector("input#upload_balance_end", :name => "upload[balance_end]")
    end
  end
end
