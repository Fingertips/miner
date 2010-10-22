if (navigator.userAgent == 'MinerApp') {
  finishedInstallingGem = function(name, success) {
    var button = $$('button[data-gem-name='+name+']').first();
    if (success) {
      button.innerHTML = 'Installed';
    } else {
      button.innerHTML = 'Failed';
    }
    button.disabled = false;
    button.removeClassName('disabled');
  }

  console.log('Add install gem observers.');
  $$('button').each(function(button) {
    button.observe('click', function(event) {
      // TODO: make installing async so we can inform the user we're installing and don't freeze the UI.
      button.innerHTML = 'Installing&hellip;';
      button.disabled = true;
      button.addClassName('disabled');
      var name = this.readAttribute('data-gem-name');
      MinerApp.installGem_(name);
    });
  });
}
