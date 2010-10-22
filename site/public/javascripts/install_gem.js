// Only do this on the target app
if (navigator.userAgent == 'MinerApp') {
  // Create the callback function that will be triggered after a gem is installed.
  finishedInstallingGem = function(name, success) {
    var button = $$('button[data-gem-name='+name+']').first();
    if (success) {
      button.innerHTML = 'Installed';
    } else {
      button.innerHTML = 'Failed';
    }
    button.removeAttribute('disabled');
  }

  $$('button').each(function(button) {
    // Check if the gem is already installed and update the caption accordingly
    var name = button.readAttribute('data-gem-name');
    var version = button.readAttribute('data-gem-version');
    var installed = MinerApp.isGemInstalled_version_(name, version);
    if (installed) {
      button.innerHTML = 'Installed';
    }

    // Now show the button
    button.show();

    // On a click event install the gem
    button.observe('click', function(event) {
      // TODO: make installing async so we can inform the user we're installing and don't freeze the UI.
      button.innerHTML = 'Installing&hellip;';
      button.writeAttribute('disabled', 'disabled');
      var name = this.readAttribute('data-gem-name');
      MinerApp.installGem_(name);
    });
  });
}
