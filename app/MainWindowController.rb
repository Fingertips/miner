class MainWindowController < NSWindowController
  URL = NSURL.URLWithString('http://minerapp.com')

  def self.controller
    alloc.initWithWindowNibName('MainWindow')
  end

  def self.isSelectorExcludedFromWebScript(selector)
    !%w{ installGem: isGemInstalled:version: }.include?(selector.to_s)
  end

  attr_accessor :webView

  def windowWillLoad
    NSUserDefaults.standardUserDefaults.registerDefaults('WebKitDeveloperExtras' => true)

    # workaround for MacRuby JIT bug
    respondsToSelector('installGem:')
    respondsToSelector('isGemInstalled:version:')
  end

  def windowDidLoad
    window.delegate = self

    @webView.customUserAgent = 'MinerApp'
    @webView.frameLoadDelegate = self
    @webView.windowScriptObject.setValue(self, forKey:'MinerApp')
    @webView.mainFrame.loadRequest(NSURLRequest.requestWithURL(URL))
  end

  def windowWillClose(notification)
    NSApp.terminate(self)
  end

  def isGemInstalled(name, version:version)
    File.exist?(File.join(userGemPath, "gems", "#{name}-#{version}"))
  end

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
