import { Toolbar } from "./toolbar.js";

const params = new URL(import.meta.url).searchParams;
const layout = params.get("layout");

pdfjsLib.GlobalWorkerOptions.workerSrc = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.worker.min.mjs";

const container = document.getElementById("viewerContainer");

const eventBus = new pdfjsViewer.EventBus();
const toolbar = new Toolbar(eventBus);
const { signal } = new AbortController();

const linkService = new pdfjsViewer.PDFLinkService({
  eventBus,
  externalLinkTarget: pdfjsViewer.LinkTarget.BLANK,
});

const viewer = new pdfjsViewer.PDFSinglePageViewer({
  container,
  eventBus,
  linkService,
});
linkService.setViewer(viewer);

eventBus.on("zoomin", () => viewer.updateScale({ steps: 1 }), { signal });
eventBus.on("zoomout", () => viewer.updateScale({ steps: -1 }), { signal });
eventBus.on("scalechanged", (event) => (viewer.currentScaleValue = event.value), { signal });
eventBus.on("scalechanging", (event) => toolbar.setPageScale(event.presetValue, event.scale), { signal });

const loadingTask = pdfjsLib.getDocument({
  url: `/${layout}.pdf`,
  enableXfa: true,
});
const resume = await loadingTask.promise;

viewer.setDocument(resume);
linkService.setDocument(resume, null);

eventBus.on("download", () => {
  const a = document.createElement("a");
  a.href = `/${layout}.pdf`;
  a.target = "_parent";
  if ("download" in a) a.download = "alex-krantz-resume.pdf";

  (document.body || document.documentElement).appendChild(a);
  a.click();
  a.remove();
}, { signal });
