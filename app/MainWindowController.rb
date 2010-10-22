class MainWindowController < NSWindowController
  def self.controller
    alloc.initWithWindowNibName('MainWindow')
  end

  def self.isSelectorExcludedFromWebScript(selector)
    selector != :"installGem:"
  end

  # TODO Returning a pretty name results in a segfault.
  #def self.webScriptNameForSelector(selector)
    #'installGem' if selector == :'installGem:'
  #end

  attr_accessor :webView

  def windowWillLoad
    NSUserDefaults.standardUserDefaults.registerDefaults('WebKitDeveloperExtras' => true)

    # workaround for MacRuby JIT bug
    respondsToSelector('installGem:')
  end

  def windowDidLoad
    @webView.customUserAgent = 'MinerApp'
    @webView.frameLoadDelegate = self

    request = NSURLRequest.requestWithURL(NSBundle.mainBundle.URLForResource('index', withExtension:'html'))
    @webView.mainFrame.loadRequest(request)
  end

  def webView(webView, didFinishLoadForFrame:frame)
    webView.windowScriptObject.setValue(self, forKey:'MinerApp')
  end

  def installGem(name)
    puts "Install gem: #{name}"
  end
end
