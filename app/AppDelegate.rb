class AppDelegate
  def applicationDidFinishLaunching(notification)
    @mainWindowController = MainWindowController.controller
    @mainWindowController.showWindow(self)
  end
end
