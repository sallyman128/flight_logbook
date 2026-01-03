require "rails_helper"

describe "User" do
  describe "validations" do
    subject(:user) { build(:user) }

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
end
