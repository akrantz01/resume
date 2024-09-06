const params = new URL(import.meta.url).searchParams;
const layout = params.get("layout");

pdfjsLib.GlobalWorkerOptions.workerSrc = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/4.6.82/pdf.worker.min.mjs";

const container = document.getElementById("container");

const eventBus = new pdfjsViewer.EventBus();
const linkService = new pdfjsViewer.PDFLinkService({
  eventBus,
  externalLinkTarget: pdfjsViewer.LinkTarget.BLANK,
});
const findController = new pdfjsViewer.PDFFindController({ eventBus, linkService });

const viewer = new pdfjsViewer.PDFSinglePageViewer({
  container,
  eventBus,
  linkService,
  findController,
});
linkService.setViewer(viewer);

eventBus.on("pagesinit", () => {
  viewer.currentScaleValue = "page-fit";
});

const loadingTask = pdfjsLib.getDocument({
  url: `/${layout}.pdf`,
  enableXfa: true,
});
const resume = await loadingTask.promise;

viewer.setDocument(resume);
linkService.setDocument(resume, null);
