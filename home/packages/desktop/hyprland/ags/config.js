import { Media } from "./Media.js"

const backlightFile='/sys/class/backlight/amdgpu_bl1/brightness'
const batCapFile='/sys/class/power_supply/BAT0/capacity'
const batStatFile='/sys/class/power_supply/BAT0/status'

let volume = Variable('')
let volIcon = Variable('')

const audio = await Service.import('audio')


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

//Utils.subprocess(
//  ['bash', '-c', 'pactl subscribe'],
//  (output) => volFunc(output.match('change')), 
//  (err) => print(err),
//)

function brightnessUpd(value) {
  value = value.toString(),
  Utils.execAsync(['brightnessctl','-q','s',value+'%'])
}

function brightnessFunc() {
    brightness.setValue(Utils.readFile(backlightFile)/255)
    brightnessIcon.setValue("display-brightness-symbolic")
  //brightnessIcon.setValue('brightness-'+(Math.round(brightness.value*2).toString().replace('0','low').replace('1','medium').replace('2','high'))+'-symbolic')
}

//function volUpd(value) {
//  value = value.toString(),
//  Utils.execAsync(['pactl','set-sink-volume', '@DEFAULT_SINK@', value+'%'])
//}


//function volFunc(i) {
//  if (i == 'change') {
//    Utils.execAsync(['bash', '-c', '$HOME/.config/ags/vol.sh'])
//      .then(
//	out => {
//	  volume.setValue(
//	    out.toString().replace(/[^0-9].*/,'')/100
//	  ); 
//	  if (out.toString().replace(/(.*)[^a-z]/, '') == 'yes') {
//	    volIcon.setValue('audio-volume-muted')
//	  }
//	  else {
//	    volIcon.setValue(
//	      'audio-volume-'+(
//		Math.ceil(volume.value*3).toString()
//		.replace('0','muted').replace('1','low').replace('2','medium').replace('3','high')
//	      )+'-symbolic'
//	    )
//	  }
//	}
//      )
//    .catch(err => print(err))
//  }
//}


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

/** @param {'speaker' | 'microphone'} type */
const VolumeSlider = (type = 'speaker') => Widget.Slider({
    hexpand: true,
    drawValue: false,
    onChange: ({ value }) => audio[type].volume = value,
    value: audio[type].bind('volume'),
})

const speakerSlider = VolumeSlider('speaker')
const micSlider = VolumeSlider('microphone')

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
	child: Widget.Icon('input-keyboard-symbolic'),
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

const speakerRevealer = Widget.Revealer({
	  revealChild: false,
	  transitionDuration: 10,
	  transition: 'slide_right',
	  child: Widget.Label({
	    
	    text: 'hello!'
	  }),
})


    const volumeSlider = Widget.Box({
      vertical:true,
      homogeneous: true,
      children: [
	Widget.Box({
      	  vertical:false,
      	  homogeneous: false,
      	  children: [
      	    Widget.Button({
	      on_clicked: () => {
		audio.speaker.is_muted = !audio.speaker.is_muted
	      },
	      child: Widget.Icon().hook(audio.speaker, self => {
		const vol = audio.speaker.volume * 100;
		const icon = [
		  [101, 'overamplified'],
		  [67, 'high'],
		  [34, 'medium'],
		  [1, 'low'],
		  [0, 'muted'],
		].find(([threshold]) => threshold <= vol)?.[1];
		if ( audio.speaker.is_muted == false ) {
		  self.icon = `audio-volume-${icon}-symbolic`;
		}
		else {
		  self.icon = `audio-volume-muted-symbolic`;
		}
	     }),
	    }),
	    speakerSlider,
	    Widget.Button({
	      on_clicked: () => speakerRevealer.revealChild = !speakerRevealer.revealChild,
	      child: Widget.Icon('keyboard')
	    }),
      	  ]
      	}),
	speakerRevealer,
	Widget.Box({
      	  vertical:false,
      	  homogeneous: false,
      	  children: [
      	    Widget.Button({
	      on_clicked: () => {
		audio.microphone.is_muted = !audio.microphone.is_muted
	      },
	      child: Widget.Icon().hook(audio.microphone, self => {
		const vol = audio.microphone.volume * 100;
		const icon = [
		  [67, 'sensitivity-high'],
		  [34, 'sensitivity-medium'],
		  [1, 'sensitivity-low'],
		  [0, 'disabled'],
		].find(([threshold]) => threshold <= vol)?.[1];
		if ( audio.microphone.is_muted == false ) {
		  self.icon = `microphone-${icon}-symbolic`;
		}
		else {
		  self.icon = `microphone-disabled-symbolic`;
		}
	     }),
	  }),
	micSlider, 
	],
      })
      ]
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


