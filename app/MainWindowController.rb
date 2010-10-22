class MainWindowController < NSWindowController
  def self.controller
    alloc.initWithWindowNibName('MainWindow')
  end

  attr_accessor :webView

  def windowDidLoad
    @webView.customUserAgent = 'MinerApp'
  end
end
