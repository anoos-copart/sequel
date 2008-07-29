require File.join(File.dirname(__FILE__), 'spec_helper.rb')

unless defined?(ADO_DB)
  ADO_DB = Sequel.ado(:host => 'AZTEC', :database => 'Uno_test', :user => 'sa', :password => 'sadev')
end

context "An ADO dataset" do
  before(:each) do
    ADO_DB.create_table!(:items) { text :name }
  end
  
  specify "should not raise exceptions when working with empty datasets" do
    lambda {
      ADO_DB[:items].all
    }.should_not raise_error
  end
end

context "An MSSQL dataset" do
  before(:each) do
    ADO_DB.create_table!(:items) { text :name }
  end

  specify "should support counting" do
    ADO_DB[:items] << {:name => 'my name' }
    ADO_DB[:items].count.should == 1
  end

  specify "should support first" do
    ADO_DB[:items] << {:name => 'x' }
    ADO_DB[:items] << {:name => 'y' }
    ADO_DB[:items].first[:name].should == 'x'
  end

  specify "should support limit" do
    3.times do
      ADO_DB[:items] << {:name => 'my name' }
    end
    ADO_DB[:items].limit(2).all.size.should == 2
  end
end
