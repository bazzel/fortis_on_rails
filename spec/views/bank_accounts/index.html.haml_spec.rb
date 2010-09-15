require 'spec_helper'

describe "bank_accounts/index.html.haml" do
  before(:each) do
    assign(:bank_accounts, [
      stub_model(BankAccount,
        :account_number => "Account Number",
        :description => "Description"
      ),
      stub_model(BankAccount,
        :account_number => "Account Number",
        :description => "Description"
      )
    ])
  end

  it "renders a list of bank_accounts" do
    render
    rendered.should have_selector("tr>td", :content => "Account Number".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "Description".to_s, :count => 2)
  end
end
