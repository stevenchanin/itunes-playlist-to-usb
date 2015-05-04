RSpec.describe PL2USB::ProgressBar do

  context "when verbose is off" do
    progress_bar = PL2USB::ProgressBar.new(:verbose=>false)
    it "should not be verbose" do
      expect(progress_bar.verbose).to be false
    end

    it "should not log" do
      expect(progress_bar.log "str").to be false
    end
  end

  context "when verbose is on" do
    progress_bar = PL2USB::ProgressBar.new(:verbose=>true)
    it "should be verbose" do
      expect(progress_bar.verbose).to be true
    end

    it "should log" do
      expect(progress_bar.log "str").to be true
    end
  end

end
