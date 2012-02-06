require 'jquery_on_rails'
require 'rails'

class JQueryOnRails::Railtie < Rails::Railtie

  config.action_view.javascript_expansions[:defaults] = %w(jquery rails)
  
  initializer "jquery_on_rails.action_view_helpers", :after => "prototype-rails.initialize" do
    ActiveSupport.on_load(:action_view) do
      # Include our helpers that override everything.
			require 'jquery_on_rails/helpers/jquery_helper'
			ActionView::Helpers::JavaScriptHelper.send :include, JQueryOnRails::Helpers::JQueryHelper
			ActionView::Helpers.send :include, JQueryOnRails::Helpers::JQueryHelper
			ActionView::Base.send :include, JQueryOnRails::Helpers::JQueryHelper
		end
  end
end
