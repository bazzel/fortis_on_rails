require 'spec_helper'

describe "bank_accounts/edit.html.haml" do
  before(:each) do
    @bank_account = assign(:bank_account, stub_model(BankAccount,
      :new_record? => false,
      :account_number => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit bank_account form" do
    render

    rendered.should have_selector("form", :action => bank_account_path(@bank_account), :method => "post") do |form|
      form.should have_selector("input#bank_account_account_number", :name => "bank_account[account_number]")
      form.should have_selector("input#bank_account_description", :name => "bank_account[description]")
    end
  end
end
