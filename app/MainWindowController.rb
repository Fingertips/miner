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
    puts "Install gem `#{name}' to gem path `#{userGemPath}'"
    puts `gem install #{name} --install-dir=#{userGemPath}`
    $?.success?
  end

  def userGemPath
    @userGemPath ||= File.expand_path("~/.gem/ruby/1.8")
  end

  # TODO For now we assume the user has the rights to install a gem, so this isn't used yet.
  #def needsRootPrivilege?
    ## TODO un-lame this by using rubygems API
    #@needsRootPrivilege ||= begin
      #env = `gem env`
      #path = File.join(env.match(/INSTALLATION DIRECTORY:\s?(.+?)\n/)[1], 'gems')
      #!File.File.grpowned?(path)
    #end
  #end
end
