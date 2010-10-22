if (navigator.userAgent == 'MinerApp') {
  console.log('Add install gem observers.');
  $$('button').each(function(button) {
    button.observe('click', function(event) {
      // TODO: make installing async so we can inform the user we're installing and don't freeze the UI.
      button.innerHTML = 'Installing&hellip;';
      var name = this.readAttribute('data-gem-name');
      if (MinerApp.installGem_(name)) {
        button.innerHTML = 'Installed';
      } else {
        button.innerHTML = 'Failed';
      }
    });
  });
}
