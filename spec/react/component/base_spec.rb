require 'spec_helper'

if opal?
RSpec.describe React::Component::Base, type: :component do
  after(:each) do
    React::API.clear_component_class_cache
  end

  it 'can be inherited to create a component class' do
    stub_const 'Foo', Class.new(React::Component::Base)
    Foo.class_eval do
      before_mount do
        @instance_data = ["working"]
      end
      def render
        @instance_data.first
      end
    end
    stub_const 'Bar', Class.new(Foo)
    Bar.class_eval do
      before_mount do
        @instance_data << "well"
      end
      def render
        @instance_data.join(" ")
      end
    end
    expect(Foo).to render_static_html("<span>working</span>")
    expect(Bar).to render_static_html("<span>working well</span>")
  end
end
end
