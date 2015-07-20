require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) { { first_name: "Jessica",
                            last_name: "Edwards",
                            email: "jessica@eml.cc",
                            password: "jessica",
                            password_confirmation: "jessica" } }

  context "relationships" do
    it { should have_many(:todo_lists) }
  end

  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email (case insensitive)" do
      user.email = "JESSICA@EML.CC"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email to look like an email" do
      user.email = "jessica"
      expect(user).to_not be_valid
    end
  end

  describe "#downcase_email" do
    it "makes the email attribute lowercase" do
      user = User.new(valid_attributes.merge(email: "JESSICA@EML.CC"))
      expect { user.downcase_email }
        .to change { user.email }
        .from("JESSICA@EML.CC")
        .to("jessica@eml.cc")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "JESSICA@EML.CC"
      expect(user.save).to be true
      expect(user.email).to eq("jessica@eml.cc")
    end
  end

  describe "#generate_password_reset_token!" do
    let(:user) { create(:user) }

    it "changes the password_reset_token attribute" do
      expect { user.generate_password_reset_token! }
        .to change { user.password_reset_token }
    end

    it "calls SecureRandom.urlsafe_base64 to generate the password_reset_token" do
      expect(SecureRandom).to receive(:urlsafe_base64)
      user.generate_password_reset_token!
    end
  end
  
end
