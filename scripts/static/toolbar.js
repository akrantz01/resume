const DEFAULT_SCALE_VALUE = "auto";
const DEFAULT_SCALE = 1.0;
const MIN_SCALE = 0.1;
const MAX_SCALE = 10.0;

const scaleSelect = document.getElementById("scaleSelect");
const customScaleOption = document.getElementById("customScaleOption");

const zoomInButton = document.getElementById("zoomIn");
const zoomOutButton = document.getElementById("zoomOut");
const downloadButton = document.getElementById("download");
const printButton = document.getElementById("print");

export class Toolbar {
  constructor(eventBus) {
    const self = this;

    scaleSelect.addEventListener("change", function() {
      if (this.value === "custom") return;
      eventBus.dispatch("scalechanged", { source: self, value: this.value });
    });
    scaleSelect.addEventListener("click", function({ target }) {
      if (this.value === self.pageScaleValue && target.tagName.toUpperCase() === "OPTION")
        this.blur();
    });
    scaleSelect.oncontextmenu = (e) => e.preventDefault();

    zoomInButton.addEventListener("click", () => eventBus.dispatch("zoomin"));
    zoomOutButton.addEventListener("click", () => eventBus.dispatch("zoomout"));
    downloadButton.addEventListener("click", () => eventBus.dispatch("download"));
    printButton.addEventListener("click", () => eventBus.dispatch("print"));

    this.reset();
  }

  reset() {
    this.pageScaleValue = DEFAULT_SCALE_VALUE;
    this.pageScale = DEFAULT_SCALE;

    this.#updateUIState();
  }

  setPageScale(scaleValue, scale) {
    this.pageScaleValue = (scaleValue || scale).toString();
    this.pageScale = scale;

    this.#updateUIState();
  }

  #updateUIState() {
    zoomOutButton.disabled = this.pageScale <= MIN_SCALE;
    zoomInButton.disabled = this.pageScale >= MAX_SCALE;

    let predefinedValueFound = false;
    for (const option of scaleSelect.options) {
      if (option.value !== this.pageScaleValue) {
        option.selected = false;
        continue;
      }

      option.selected = true;
      predefinedValueFound = true;
    }
    if (!predefinedValueFound) {
      customScaleOption.selected = true;
      customScaleOption.textContent = `${Math.round(this.pageScale * 10000) / 100}%`;
    }
  }
}
