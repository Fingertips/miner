class AppDelegate
  def applicationDidFinishLaunching(notification)
    @mainWindowController = MainWindowController.controller
    @mainWindowController.window
  end
end
