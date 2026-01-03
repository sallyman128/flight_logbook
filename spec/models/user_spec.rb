require "rails_helper"

describe "User" do
  subject(:user) { build(:user) }

  describe "validations" do
    describe "ui_mode" do
      it "allows react" do
        user.ui_mode = "react"
        expect(user).to be_valid
      end

      it "allows hotwire" do
        user.ui_mode = "hotwire"
        expect(user).to be_valid
      end

      it "does not allow invalid option" do
        user.ui_mode = "invalid_option"
        expect(user).to_not be_valid
      end

      it "does not allow nil" do
        user.ui_mode = nil
        expect(user).to_not be_valid
      end
    end
  end

  describe "#react_ui?" do
    it "returns true if the current user's ui_mode is react" do
      user.ui_mode = "react"
      expect(user).to be_react_ui
    end

    it "returns false if the current user's ui_mode is hotwire" do
      user.ui_mode = "hotwire"
      expect(user).to_not be_react_ui
    end
  end

  describe "#hotwire_ui?" do
    it "returns true if the current user's ui_mode is hotwire" do
      user.ui_mode = "hotwire"
      expect(user).to be_hotwire_ui
    end

    it "returns false if the current user's ui_mode is react" do
      user.ui_mode = "react"
      expect(user).to_not be_hotwire_ui
    end
  end
end
