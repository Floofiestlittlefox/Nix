import { Media } from "./Media.js"

const backlightFile='/sys/class/backlight/amdgpu_bl1/brightness'
const batCapFile='/sys/class/power_supply/BAT0/capacity'
const batStatFile='/sys/class/power_supply/BAT0/status'
//let charge = Utils.readFile(batCapFile)
let charge = Variable(Utils.readFile(batCapFile).replace(/^\s+|\s+$/g, ''))
let batIcon = Variable('battery-level-'+(Math.round(charge.value/10)*10)+'-symbolic')


let date = Variable('', {
	  poll: [1000, 'date "+%H:%M:%S  %_A, %B %d"'],
	})


let brightness = Variable(Utils.readFile(backlightFile)/255)

function buttonExec(script) {
  Utils.execAsync([
    'bash', '-c', script
  ]);
}

function brightnessUpd(value) {
  value = value.toString()
  Utils.execAsync(['brightnessctl','-q','s',value])
}

Utils.monitorFile(backlightFile, () => {
  brightness.setValue(Utils.readFile(backlightFile)/255)
})


Utils.monitorFile(batCapFile, () => {
  charge.setValue(Utils.readFile(batCapFile))
  const status = Utils.readFile(batStatFile)
  let chargePercent = Math.round(charge.value/10)*10
  if (status == 'charging') {
    batIcon.setValue('battery-level-'+chargePercent+'-charging-symbolic')
  }
  else {
    batIcon.setValue('battery-level-'+chargePercent+'-symbolic')
  }
})

const myCalendar = Widget.Window({
  name: 'calendar',
  anchor: ['top'],
  visible: false,
  margins: [4, 0],
  child: Widget.Box ({
    spacing: 8,
    homogeneous: true,
    vertical: false,
    children: [
      Widget.Calendar(),
      Media(),
    ]
  })

})


	

      const timeButton = Widget.ToggleButton({
	child: Widget.Label({ label: date.bind() }),
	onToggled: () => myCalendar.visible = !myCalendar.visible,
      })

    const centerBox = Widget.Box({
      spacing: 8,
      vertical: false,
      children: [
	timeButton,
      ]
    })
	
	

	const controlCenterButton = Widget.ToggleButton({
	  child: Widget.Box({
	    spacing: 4,
	    homogeneous: false,
	    children: [
		Widget.Icon({
		   icon: batIcon.bind(),
		 }),
		Widget.Label({
		   label: charge.bind(),
		   vpack: "center"
		 }),
	    ]
	}),
	onToggled: () => controlCenter.visible = !controlCenter.visible
      })
      const keyboardButton = Widget.Button({
	child: Widget.Icon('keyboard'),
	onPrimaryClick: () => buttonExec('kill -34 $(pidof wvkbd-mobintl)')
      })

    const rightBox = Widget.Box({
      spacing: 8,
      hpack: "end",
      vertical: false,
      homogeneous: false,
      children: [
	keyboardButton,
	controlCenterButton,
      ]
    })


  const barBox = Widget.CenterBox({
    spacing: 8,
    vertical: false,
    homogeneous: false,
    centerWidget: centerBox,
    endWidget: rightBox,
  })


const myBar = Widget.Window({
  name: 'bar',
  anchor: ['top', 'left', 'right'],
  exclusivity: "exclusive",
  child: barBox,
})


    const brightnessSlider = Widget.Box({
      vertical: false,
      homogeneous: false,
      children: [
	Widget.Icon({
	  icon: 'brightness',
	}),
	Widget.Slider({
	  on_change: self => brightnessUpd(self.value*255),
	  min: 0,
	  max: 1,
	  hexpand: true,
	  draw_value: false,
	  value: brightness.bind()
	}),
      ]
    })

  const controlBox = Widget.Box({
    spacing: 8,
    vertical: true,
    css: 'min-width: 200px;',
    homogeneous: false,
    children: [
      brightnessSlider,
    ]
  })

const controlCenter = Widget.Window({
  name: 'control',
  anchor: ['right', 'top'],
  visible: false,
  margins: [4,6],
  child: controlBox,
})

App.config({
  style: "./style.css",
  windows : [
    myBar,
  ]
})


