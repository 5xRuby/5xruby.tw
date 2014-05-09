require "spec_helper"

describe ContactMailer do
  describe "enquire" do
    let(:mail) { ContactMailer.enquire }

    it "renders the headers" do
      mail.subject.should eq("Enquire")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
