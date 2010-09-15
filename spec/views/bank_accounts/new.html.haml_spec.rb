require 'spec_helper'

describe "bank_accounts/new.html.haml" do
  before(:each) do
    assign(:bank_account, stub_model(BankAccount,
      :new_record? => true,
      :account_number => "MyString",
      :description => "MyString"
    ))
  end

  it "renders new bank_account form" do
    render

    rendered.should have_selector("form", :action => bank_accounts_path, :method => "post") do |form|
      form.should have_selector("input#bank_account_account_number", :name => "bank_account[account_number]")
      form.should have_selector("input#bank_account_description", :name => "bank_account[description]")
    end
  end
end
