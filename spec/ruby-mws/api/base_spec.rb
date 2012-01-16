require 'spec_helper'

describe MWS::API::Base do
  class FakeApi < MWS::API::Base
    def self.test_params
      {
        :verb    => :get,
        :uri     => '/FakeApi/2011-01-01',
        :version => '2011-01-01'
      }
    end

    def_request [:list_fake_objects, :list_fake_objects_by_next_token], self.test_params
  end

  before :all do
    @api = FakeApi.new(mws_object.connection)
  end

  context "def_request" do
    it "should generate methods for each request defined" do
      @api.respond_to?(:list_fake_objects).should be_true
      @api.respond_to?(:list_fake_objects_by_next_token).should be_true
    end

    it "should store request options as a class variable" do
      FakeApi.class_variable_get('@@list_fake_objects_options').should be
      FakeApi.class_variable_get('@@list_fake_objects_by_next_token_options').should be
      FakeApi.class_variable_get('@@list_fake_objects_options').should == FakeApi.test_params
    end
  end

  context "methods generated by def_request" do
    it "should call send_request with the right params" do
      @api.should_receive(:send_request).
        with(:list_fake_objects, {}, FakeApi.test_params).
        and_raise(TestWorksError)
      lambda{ @api.list_fake_objects }.should raise_error TestWorksError
    end
  end
  
end