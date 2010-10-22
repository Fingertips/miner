class MainWindowController < NSWindowController
  def self.controller
    alloc.initWithWindowNibName('MainWindow')
  end

  def self.isSelectorExcludedFromWebScript(selector)
    !%w{ installGem: isGemInstalled:version: }.include?(selector.to_s)
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
    respondsToSelector('isGemInstalled:version:')
  end

  def windowDidLoad
    @webView.customUserAgent = 'MinerApp'
    @webView.frameLoadDelegate = self
    @webView.windowScriptObject.setValue(self, forKey:'MinerApp')
    
    request = NSURLRequest.requestWithURL(NSURL.URLWithString('http://miner.local'))
    @webView.mainFrame.loadRequest(request)
  end

  def isGemInstalled(name, version:version)
    # TODO RubyGems (on osx) is so broken, it does not search in the home folder, so using the API is pointless...
    #dep = Gem::Dependency.new(name, version)
    #!Gem.source_index.search(dep).empty?

    File.exist?(File.join(userGemPath, "gems", "#{name}-#{version}"))
  end

  # TODO Just using $?.success? isn't really enough, because RubyGems can
  # install a gem and still return that it wasn't a success. For example,
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
