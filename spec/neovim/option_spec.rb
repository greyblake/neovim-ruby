require "helper"

module Neovim
  RSpec.describe Option, :remote do
    shared_context "getters and setters" do
      it "reads an option" do
        option = Option.new(option_name, scope, @client)
        expect(option.value).to be(false)
      end

      it "sets an option" do
        option = Option.new(option_name, scope, @client)
        option.value = false
        expect(option.value).to be(false)
        expect(Option.new(option_name, scope, @client).value).to be(false)
      end

      it "raises an exception on invalid arguments" do
        option = Option.new(option_name, scope, @client)
        expect {
          option.value = "what"
        }.to raise_error(Neovim::RPC::Error, /boolean/i)
      end
    end

    describe "globally scoped" do
      let(:scope) { Scope::Global.new }
      let(:option_name) { "hlsearch" }
      include_context "getters and setters"
    end

    describe "buffer scoped" do
      let(:buffer) { Buffer.new(2, @client) }
      let(:scope) { Scope::Buffer.new(buffer) }
      let(:option_name) { "expandtab" }
      include_context "getters and setters"
    end

    describe "window scoped" do
      let(:window) { Window.new(1, @client) }
      let(:scope) { Scope::Window.new(window) }
      let(:option_name) { "list" }
      include_context "getters and setters"
    end
  end
end
