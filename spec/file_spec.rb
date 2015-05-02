RSpec.describe PL2USB::Track do
  context "test1" do
    file = PL2USB::File.new(::File.join(::File.dirname(__FILE__), "test_files/test1.mp3"), "mp3")

    it "should know the path" do
      expect(file.path).to eql ::File.join(::File.dirname(__FILE__), "test_files/test1.mp3")
    end

    it "should exist" do
      expect(file.exist?).to be true
    end

    it "should have correct length" do
      expect(file.length).to eql 12
    end

    it "should not be lossless" do
      expect(file.lossless?).to be false
    end

    it "should have correct size" do
      expect(file.size).to eql 199850
    end

    it "should have correct kind" do
      expect(file.kind).to eql "mp3"
    end
  end

  context "test2" do
    file = PL2USB::File.new(::File.join(::File.dirname(__FILE__), "test_files/test2.m4a"), "alac")

    it "should be lossless" do
      expect(file.lossless?).to be true
    end

    it "should have correct kind" do
      expect(file.kind).to eql "alac"
    end
  end
end
