require "spec_helper"

describe BankAccountsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/bank_accounts" }.should route_to(:controller => "bank_accounts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/bank_accounts/new" }.should route_to(:controller => "bank_accounts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/bank_accounts/1" }.should route_to(:controller => "bank_accounts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/bank_accounts/1/edit" }.should route_to(:controller => "bank_accounts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/bank_accounts" }.should route_to(:controller => "bank_accounts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/bank_accounts/1" }.should route_to(:controller => "bank_accounts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/bank_accounts/1" }.should route_to(:controller => "bank_accounts", :action => "destroy", :id => "1")
    end

  end
end
