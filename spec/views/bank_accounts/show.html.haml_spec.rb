require 'spec_helper'

describe "bank_accounts/show.html.haml" do
  before(:each) do
    @bank_account = assign(:bank_account, stub_model(BankAccount,
      :account_number => "Account Number",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain("Account Number".to_s)
    rendered.should contain("Description".to_s)
  end
end
