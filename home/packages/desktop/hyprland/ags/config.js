import { Media } from "./Media.js"

const backlightFile='/sys/class/backlight/amdgpu_bl1/brightness'
const batCapFile='/sys/class/power_supply/BAT0/capacity'
const batStatFile='/sys/class/power_supply/BAT0/status'
let charge = Variable('10')
let status = Variable('Charging')
let batIcon = Variable('battery-level-'+(Math.round(charge.value/10)*10)+'-symbolic')


let date = Variable('', {
	  poll: [1000, 'date "+%H:%M:%S  %_A, %B %d"'],
	})


let brightness = Variable(Utils.readFile(backlightFile)/255)

let volume = Variable(Math.round(Utils.execAsync(['pactl', 'get-sink-volume', '@DEFAULT_SINK@'])))

function buttonExec(script) {
  Utils.execAsync([
    'bash', '-c', script
  ]);
}

function brightnessUpd(value) {
  value = value.toString()
  Utils.execAsync(['brightnessctl','-q','s',value+'%'])
}

function volUpd(value) {
  value = value.toString()
  Utils.execAsync(['pactl','s',value+'%'])
}


Utils.monitorFile(backlightFile, () => {
  brightness.setValue(Utils.readFile(backlightFile)/255)
})

Utils.subprocess(
  ['fswatch', '/sys/class/power_supply/BAT0/energy_now'],
  (output) => batFunc(),
)
batFunc()

function batFunc() {
    charge.setValue(Utils.readFile(batCapFile).replace(/^\s+|\s+$/g, ''))
    status.setValue(Utils.readFile(batStatFile).replace(/^\s+|\s+$/g, ''))
    let chargePercent = Math.round(charge.value/10)*10
    if (status.value == 'Charging') {
      batIcon.setValue('battery-level-'+chargePercent+'-charging-symbolic'),
      print('charging!')
    }
    else {
      batIcon.setValue('battery-level-'+chargePercent+'-symbolic'),
      print('noChargin')
    }
}

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

    const volumeSlider = Widget.Box({
      vertical:false,
      homogeneous: false,
      children: [
	Widget.Icon({
	  icon: 'volume',
	}),
	Widget.Slider({
	  on_change: self => volUpd(self.value*100)
	  min: 0,
	  max: 1,
	  draw_value: false,
	  value: volume.bind()
	}),
      })
    const brightnessSlider = Widget.Box({
      vertical: false,
      homogeneous: false,
      children: [
	Widget.Icon({
	  icon: 'brightness',
	}),
	Widget.Slider({
	  on_change: self => brightnessUpd(self.value*100),
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
      volumeSlider,
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


