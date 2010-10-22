class MainWindowController < NSWindowController
  def self.controller
    alloc.initWithWindowNibName('MainWindow')
  end

  def self.isSelectorExcludedFromWebScript(selector)
    selector != :"installGem:"
  end

  # TODO MacRuby bug: Returning a pretty name results in a segfault.
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

    #request = NSURLRequest.requestWithURL(NSBundle.mainBundle.URLForResource('index', withExtension:'html'))
    request = NSURLRequest.requestWithURL(NSURL.URLWithString('http://miner.local'))
    @webView.mainFrame.loadRequest(request)
  end

  def webView(webView, didFinishLoadForFrame:frame)
    webView.windowScriptObject.setValue(self, forKey:'MinerApp')
  end

  # TODO Just using $?.success? isn't really enough, because RubyGems can
  # install a gem and still return that it was not a success. For example,
  # if YARD fails to generate docs.
  def installGem(name)
    Dispatch::Queue.concurrent(:default).async do
      NSLog("Install gem `#{name}' to gem path `#{userGemPath}'")
      NSLog(`gem install #{name} --install-dir=#{userGemPath}`)
      performSelectorOnMainThread('finishedInstallingGem:', withObject: [name, $?.success?], waitUntilDone: true)
    end
  end

  def finishedInstallingGem(args)
    name, success = args
    @webView.windowScriptObject.evaluateWebScript("finishedInstallingGem('#{name}', #{success});")
  end

  def userGemPath
    @userGemPath ||= File.join(NSHomeDirectory(), ".gem/ruby/1.8")
  end
end
