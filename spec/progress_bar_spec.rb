RSpec.describe PL2USB::ProgressBar do

  context "with default values" do
    progress_bar = PL2USB::ProgressBar.new()
    it "should not be verbose" do
      expect(progress_bar.verbose).to be false
    end

    it "should not be debug" do
      expect(progress_bar.debug).to be false
    end
  end

  context "when verbose is off and debug is off" do
    progress_bar = PL2USB::ProgressBar.new(:verbose=>false)
    it "should not be verbose" do
      expect(progress_bar.verbose).to be false
    end

    it "should not log" do
      expect(progress_bar.log "str").to be false
    end

    it "should not debug_log" do
      expect(progress_bar.debug_log "debug").to be false
    end
  end

  context "when verbose is on and debug is off" do
    progress_bar = PL2USB::ProgressBar.new(:verbose=>true)
    it "should be verbose" do
      expect(progress_bar.verbose).to be true
    end

    it "should log" do
      expect(progress_bar.log "log").to be true
    end

    it "should not debug_log" do
      expect(progress_bar.debug_log "debug").to be false
    end
  end

  context "when verbose is on and debug is on" do
    progress_bar = PL2USB::ProgressBar.new(:verbose=>true, :debug=>true)
    it "should be verbose" do
      expect(progress_bar.verbose).to be true
    end

    it "should log" do
      expect(progress_bar.log "log").to be true
    end

    it "should debug_log" do
      expect(progress_bar.debug_log "debug").to be true
    end
  end

  context "when verbose is off and debug is on" do
    progress_bar = PL2USB::ProgressBar.new(:verbose=>false, :debug=>true)
    it "should not be verbose" do
      expect(progress_bar.verbose).to be false
    end

    it "should not log" do
      expect(progress_bar.log "str").to be false
    end

    it "should not debug_log" do
      expect(progress_bar.debug_log "debug").to be false
    end
  end

end
