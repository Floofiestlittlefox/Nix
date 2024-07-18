import { Media } from "./Media.js"

const backlightFile='/sys/class/backlight/amdgpu_bl1/brightness'
const batCapFile='/sys/class/power_supply/BAT0/capacity'
const batStatFile='/sys/class/power_supply/BAT0/status'

let volume = Variable('')
let volIcon = Variable('')
volFunc('change')


let status = Variable('')
let charge = Variable('')
let batIcon = Variable('')
batFunc()


let date = Variable('', {
	  poll: [1000, 'date "+%H:%M:%S  %_A, %B %d"'],
	})


let brightness = Variable()
let brightnessIcon = Variable('')
brightnessFunc()

Utils.monitorFile(backlightFile, () => {
  brightnessFunc()
})

Utils.subprocess(
  ['fswatch', '/sys/class/power_supply/BAT0/energy_now'],
  (output) => (batFunc())
)

Utils.subprocess(
  ['bash', '-c', 'pactl subscribe'],
  (output) => volFunc(output.match('change')), 
  (err) => print(err),
)

function brightnessUpd(value) {
  value = value.toString(),
  Utils.execAsync(['brightnessctl','-q','s',value+'%'])
}

function brightnessFunc() {
    brightness.setValue(Utils.readFile(backlightFile)/255)
    brightnessIcon.setValue('brightness-'+(Math.round(brightness.value*2).toString().replace('0','low').replace('1','medium').replace('2','high'))+'-symbolic')
}

function volUpd(value) {
  value = value.toString(),
  Utils.execAsync(['pactl','set-sink-volume', '@DEFAULT_SINK@', value+'%'])
}


function volFunc(i) {
  if (i == 'change') {
    Utils.execAsync(['bash', '-c', '$HOME/.config/ags/vol.sh'])
      .then(
	out => {
	  volume.setValue(
	    out.toString().replace(/[^0-9].*/,'')/100
	  ); 
	  if (out.toString().replace(/(.*)[^a-z]/, '') == 'yes') {
	    volIcon.setValue('volume-level-muted')
	  }
	  else {
	    volIcon.setValue(
	      'volume-level-'+(
		Math.round(volume.value*3).toString()
		.replace('0','none').replace('1','low').replace('2','medium').replace('3','high')
	      )
	    )
	  }
	}
      )
    .catch(err => print(err))
  }
}


function batFunc() {
    charge.setValue(Utils.readFile(batCapFile).replace(/^\s+|\s+$/g, ''))
    status.setValue(Utils.readFile(batStatFile).replace(/^\s+|\s+$/g, ''))
    let chargePercent = Math.floor(charge.value/10)*10
    if ( chargePercent.value == 100 ) {
      print('1'),
      batIcon.setValue('battery-level-100-charged-symbolic')
    }
    else if (status.value == 'Charging') {
      batIcon.setValue('battery-level-'+chargePercent+'-charging-symbolic')
    }
    else {
      print('3'),
      batIcon.setValue('battery-level-'+chargePercent+'-symbolic')
    }
}
//volMenuFunc()
//
//function volMenuFunc() {
//  let output = (Utils.exec('./volMenu.sh out'))
//  let input = (Utils.exec('./volMenu.sh in'))
//  const outArr = output.split(' ');
//  const inpArr = output.split(' ');
//  for ( var i = 0; i < outArr.length; i++) {
//    Utils.execAsync(['./volMenu.sh', 'name', outArr[i]])
//      .then(
//	out => 
//  }
//};


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
	onPrimaryClick: () => Utils.execAsync(['bash', '-c', 'kill -34 $(pidof wvkbd-mobintl)'])
      })
      const systemtray = await Service.import('systemtray')

      /** @param {import('types/service/systemtray').TrayItem} item */
      const SysTrayItem = item => Widget.Button({
	  child: Widget.Icon().bind('icon', item, 'icon'),
	  tooltipMarkup: item.bind('tooltip_markup'),
	  onPrimaryClick: (_, event) => item.activate(event),
	  onSecondaryClick: (_, event) => item.openMenu(event),
      });

      const sysTray = Widget.Box({
	  children: systemtray.bind('items').as(i => i.map(SysTrayItem))
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
      children: [
	Widget.Box({
      	  vertical:false,
      	  homogeneous: false,
      	  children: [
      	    Widget.Icon({
      	      icon: volIcon.bind(),
      	      css: 'font-size: 24px',
      	    }),
      	    Widget.Slider({
      	      on_change: self => volUpd((self.value)*100),
      	      min: 0,
      	      max: 1,
      	      hexpand: true,
      	      draw_value: false,
      	      value: volume.bind()
      	    }),
      	  ]
      	}),
      ],
    })

    const brightnessSlider = Widget.Box({
      vertical: false,
      homogeneous: false,
      children: [
	Widget.Icon({
	  icon: brightnessIcon.bind(),
	  css: 'font-size: 24px',
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

  const controlBox = Widget.EventBox({
    child: Widget.Box ({
      spacing: 8,
      vertical: true,
      css: 'min-width: 200px;',
      homogeneous: false,
      children: [
	brightnessSlider,
	volumeSlider,
      ]
    })
  })

const controlCenter = Widget.Window({
  name: 'control',
  layer: 'overlay',
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


