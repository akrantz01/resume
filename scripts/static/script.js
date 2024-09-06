const params = new URL(import.meta.url).searchParams;
const layout = params.get("layout");

pdfjsLib.GlobalWorkerOptions.workerSrc = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.worker.min.mjs";

const container = document.getElementById("viewerContainer");

const eventBus = new pdfjsViewer.EventBus();
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

eventBus.on("pagesinit", () => {
  viewer.currentScaleValue = "page-width";
});

const loadingTask = pdfjsLib.getDocument({
  url: `/${layout}.pdf`,
  enableXfa: true,
});
const resume = await loadingTask.promise;

viewer.setDocument(resume);
linkService.setDocument(resume, null);
