require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'dummy_controller'

describe JQueryOnRails::Helpers::JQueryUiHelper do
  before(:each) do
    @t = DummyController.new.tap do |c|
      c.request = ActionDispatch::Request.new Rack::MockRequest.env_for('/dummy')
    end.view_context
    @t.extend JQueryOnRails::Helpers::JQueryUiHelper
  end
  describe '#visual_effect' do
    it "renames effects" do
      @t.visual_effect(:fade,'blah').should == %(jQuery("#blah").fadeOut();)
      @t.visual_effect(:appear,'blah').should == %(jQuery("#blah").fadeIn();)
    end
    it "automatically rewrites effects that need a mode option" do
      @t.visual_effect(:blind_down,'blah').should ==
        %(jQuery("#blah").show('blind',{direction:'vertical'});)
      @t.visual_effect(:blind_up,'blah').should ==
        %(jQuery("#blah").hide('blind',{direction:'vertical'});)
      @t.visual_effect(:blind_right,'blah').should ==
        %(jQuery("#blah").show('blind',{direction:'horizontal'});)
      @t.visual_effect(:blind_left,'blah').should ==
        %(jQuery("#blah").hide('blind',{direction:'horizontal'});)
      @t.visual_effect(:blind_up,'blah',:direction=>:horizontal).should ==
        %(jQuery("#blah").hide('blind',{direction:'horizontal'});)
      @t.visual_effect(:blind_right,'blah',:direction=>:vertical).should ==
        %(jQuery("#blah").show('blind',{direction:'vertical'});)
    end
    it "uses jQuery UI toggle effects" do
      @t.visual_effect(:toggle_slide,'blah').should == %(jQuery("#blah").toggle('slide',{direction:'vertical'});)
      @t.visual_effect(:toggle_blind,'blah').should == %(jQuery("#blah").toggle('blind',{direction:'vertical'});)
      @t.visual_effect(:toggle_blind,'blah',:direction=>:horizontal).should == %(jQuery("#blah").toggle('blind',{direction:'horizontal'});)
    end
    it "rewrites :toggle_appear" do
      @t.visual_effect(:toggle_appear,'blah').should == 
        "(function(state){ return (function() { state=!state; return jQuery(\"#blah\")['fade'+(state?'In':'Out')](); })(); })(jQuery(\"#blah\").css('visiblity')!='hidden');"
    end
  end
end