require 'spec_helper'

class FakeModel < Struct.new(:name, :id)
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def errors
    { :name => ["is required"] }
  end

  def persisted?
    false
  end
end

describe ActionView::Helpers::FormHelper do

  before do
    helper.form_for(FakeModel.new, :url => "myurl", :builder => Manageable::Helpers::FormBuilder) do |f|
      @text_field = f.text_field(:name)
      @password_field = f.password_field(:name)
      @telephone_field = f.telephone_field(:name)
      @url_field = f.url_field(:name)
      @email_field = f.email_field(:name)
      @number_field = f.number_field(:name)
      @range_field = f.range_field(:name)
      @file_field = f.file_field(:name)
      @text_area = f.text_area(:name)
      @check_box = f.check_box(:name)
      @radio_button = f.radio_button(:name, "Yes")
      @button = f.button("Save")
    end
  end

  it "should print labeled text_field" do
    @text_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" size="30" type="text" /></div>'
  end

  it "should print labeled password_field" do
    @password_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" size="30" type="password" /></div>'
  end

  it "should print labeled telephone_field" do
    @telephone_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" size="30" type="tel" /></div>'
  end

  it "should print labeled url_field" do
    @url_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" size="30" type="url" /></div>'
  end

  it "should print labeled email_field" do
    @email_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" size="30" type="email" /></div>'
  end

  it "should print labeled number_field" do
    @number_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" type="number" /></div>'
  end

  it "should print labeled range_field" do
    @range_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" type="range" /></div>'
  end

  it "should print labeled file_field" do
    @file_field.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><input id="fake_model_name" name="fake_model[name]" type="file" /></div>'
  end

  it "should print labeled text_area" do
    @text_area.should == '<div class="group"><div class="fieldWithErrors"><label class="label" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div><textarea cols="40" id="fake_model_name" name="fake_model[name]" rows="20"></textarea></div>'
  end

  it "should print labeled check_box" do
    @check_box.should == '<div><input name="fake_model[name]" type="hidden" value="0" /><input class="checkbox" id="fake_model_name" name="fake_model[name]" type="checkbox" value="1" /><div class="fieldWithErrors"><label class="checkbox" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div></div>'
  end

  it "should print labeled radio_button" do
    @radio_button.should == '<div><input class="radio" id="fake_model_name_yes" name="fake_model[name]" type="radio" value="Yes" /><div class="fieldWithErrors"><label class="radio" for="fake_model_name">Name</label>&nbsp<span class="error">is required</span></div></div>'
  end

  it "should print button" do
    @button.should == '<button class="button"><img alt="Save" src="/assets/manageable/icons/tick.png" />&nbsp;Save</button>'
  end
end