require 'spec_helper'

describe BankAccountsController do

  def mock_bank_account(stubs={})
    @mock_bank_account ||= mock_model(BankAccount, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all bank_accounts as @bank_accounts" do
      BankAccount.stub(:all) { [mock_bank_account] }
      get :index
      assigns(:bank_accounts).should eq([mock_bank_account])
    end
  end

  describe "GET show" do
    it "assigns the requested bank_account as @bank_account" do
      BankAccount.stub(:find).with("37") { mock_bank_account }
      get :show, :id => "37"
      assigns(:bank_account).should be(mock_bank_account)
    end
  end

  describe "GET new" do
    it "assigns a new bank_account as @bank_account" do
      BankAccount.stub(:new) { mock_bank_account }
      get :new
      assigns(:bank_account).should be(mock_bank_account)
    end
  end

  describe "GET edit" do
    it "assigns the requested bank_account as @bank_account" do
      BankAccount.stub(:find).with("37") { mock_bank_account }
      get :edit, :id => "37"
      assigns(:bank_account).should be(mock_bank_account)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created bank_account as @bank_account" do
        BankAccount.stub(:new).with({'these' => 'params'}) { mock_bank_account(:save => true) }
        post :create, :bank_account => {'these' => 'params'}
        assigns(:bank_account).should be(mock_bank_account)
      end

      it "redirects to the created bank_account" do
        BankAccount.stub(:new) { mock_bank_account(:save => true) }
        post :create, :bank_account => {}
        response.should redirect_to(bank_account_url(mock_bank_account))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bank_account as @bank_account" do
        BankAccount.stub(:new).with({'these' => 'params'}) { mock_bank_account(:save => false) }
        post :create, :bank_account => {'these' => 'params'}
        assigns(:bank_account).should be(mock_bank_account)
      end

      it "re-renders the 'new' template" do
        BankAccount.stub(:new) { mock_bank_account(:save => false) }
        post :create, :bank_account => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested bank_account" do
        BankAccount.should_receive(:find).with("37") { mock_bank_account }
        mock_bank_account.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :bank_account => {'these' => 'params'}
      end

      it "assigns the requested bank_account as @bank_account" do
        BankAccount.stub(:find) { mock_bank_account(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:bank_account).should be(mock_bank_account)
      end

      it "redirects to the bank_account" do
        BankAccount.stub(:find) { mock_bank_account(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(bank_account_url(mock_bank_account))
      end
    end

    describe "with invalid params" do
      it "assigns the bank_account as @bank_account" do
        BankAccount.stub(:find) { mock_bank_account(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:bank_account).should be(mock_bank_account)
      end

      it "re-renders the 'edit' template" do
        BankAccount.stub(:find) { mock_bank_account(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested bank_account" do
      BankAccount.should_receive(:find).with("37") { mock_bank_account }
      mock_bank_account.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the bank_accounts list" do
      BankAccount.stub(:find) { mock_bank_account }
      delete :destroy, :id => "1"
      response.should redirect_to(bank_accounts_url)
    end
  end

end
