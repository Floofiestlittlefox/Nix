App.config({
  windows : [
    myBar
  ]
})

const myBar = Widget.Window({
  name: 'bar',
  anchor: ['top', 'left', 'right'],
  child: keyboardButton,
})

const keyboardButton = Widget.Button({
  child: Widget.Label('keyboard'),
  on-primary-click: () => buttonExec('kill -34 $(pidof wvkbd-mobintl)'),
})

function buttonExec(script) {
  Utils.execAsync([
    'bash', '-c', script
  ]);
}


