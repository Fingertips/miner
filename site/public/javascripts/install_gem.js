if (navigator.userAgent == 'MinerApp') {
  finishedInstallingGem = function(name, success) {
    var button = $$('button[data-gem-name='+name+']').first();
    if (success) {
      button.innerHTML = 'Installed';
    } else {
      button.innerHTML = 'Failed';
    }
    button.removeAttribute('disabled');
  }

  console.log('Add install gem observers.');
  $$('button').each(function(button) {
    var name = button.readAttribute('data-gem-name');
    var version = button.readAttribute('data-gem-version');
    var installed = MinerApp.isGemInstalled_version_(name, version);
    if (installed) {
      button.innerHTML = 'Installed';
    }

    button.observe('click', function(event) {
      // TODO: make installing async so we can inform the user we're installing and don't freeze the UI.
      button.innerHTML = 'Installing&hellip;';
      button.writeAttribute('disabled', 'disabled');
      var name = this.readAttribute('data-gem-name');
      MinerApp.installGem_(name);
    });
  });
}
