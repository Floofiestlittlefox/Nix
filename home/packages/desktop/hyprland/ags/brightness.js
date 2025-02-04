class BrightnessService extends Service {
  static {
    Service.register(
      this,
      {
	'screen-changed':['float'],
      },
      {
	'screen-value': ['float','rw'],
      },
    );
  }
  #interface = Utils.exec("sh -c 'ls -w1 /sys/class/backlight/ | head -1'");

  #screenValue = 1;
  #max = Number(Utils.exec('brightnessctl max'));

  get exportValue() {
    return this.#screenValue;
  }

  set exportValue(percent) {
    if (percent < 0)
      percent = 0;
    
    if (percent > 1)
      percent = 1;

    Utils.execAsync('brightnessctl -q set ${percent * 100}%');
  }


  constructor() {
    super();

    const brightness = '/sys/class/backlight/${this.#interface}/brightness';
    Utils.monitorFile(brightness, () => this.#onChange());

    this.#onChange();
  }

  #onChange() {
    this.#screenValue = Number(Utils.exec('brightnessctl get')) / this.#max;

    this.emit('changed');
    this.notify('screen-value')

    this.emit('screen-changed', this.#screenValue);
  }

  connect(event = 'screen-changed', callback) {
    return super.connect(event, callback);
  }
}

const service = new BrightnessService;

export default service;
