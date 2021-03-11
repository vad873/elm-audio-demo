var preview = document.getElementById("preview");
var recording = document.getElementById("recording");
var startButton = document.getElementById("startButton");
var stopButton = document.getElementById("stopButton");
var downloadButton = document.getElementById("downloadButton");

var recordingTimeMS = 20000;
var videoStream;
var videoRecorder;

function log(msg) {
  console.log(msg);
}

function wait(delayInMS) {
  return new Promise(resolve => setTimeout(resolve, delayInMS));
}

function startRecording(stream, lengthInMS) {
  videoStream = stream;
  let recorder = new MediaRecorder(stream);
  videoRecorder = recorder;
  let data = [];

  recorder.ondataavailable = event => data.push(event.data);
  recorder.start();
  log(recorder.state + " for " + (lengthInMS/1000) + " seconds...");

  let stopped = new Promise((resolve, reject) => {
    recorder.onstop = resolve;
    recorder.onerror = event => reject(event.name);
  });

  let recorded = wait(lengthInMS).then(
    () => recorder.state == "recording" && recorder.stop()
  );

  return Promise.all([
    stopped,
    recorded
  ])
  .then(() => data);
}

export function stopVideoRecording() {
  log("stopping video recording");
  videoStream.getTracks().forEach(track => track.stop());
  videoRecorder.stop()
}

export function startVideoRecording() {
  preview = document.getElementById("preview");
  recording = document.getElementById("recording");
  startButton = document.getElementById("startButton");
  stopButton = document.getElementById("stopButton");
  downloadButton = document.getElementById("downloadButton");

  navigator.mediaDevices.getUserMedia({
    video: true,
    audio: true
  }).then(stream => {
    preview.srcObject = stream;
    preview.captureStream = preview.captureStream || preview.mozCaptureStream;
    var promise = new Promise(resolve => preview.onplaying = resolve);
    return promise;
  })
  .then(() => startRecording(preview.captureStream(), recordingTimeMS))
  .then (recordedChunks => {
    let recordedBlob = new Blob(recordedChunks, { type: "video/webm" });
    recording.src = URL.createObjectURL(recordedBlob);

    var link = document.createElement('a');
    var filename = new Date().toISOString();
    link.href = recording.src;
  	link.download = filename+".webm"; //download forces the browser to donwload the file using the  filename
  	link.innerHTML = "Save to disk filename";

    var videoRecordingsDiv = document.getElementById("video-recordings");
    videoRecordingsDiv.appendChild(link);
    videoRecordingsDiv.appendChild(document.createElement('br'))

    log("Successfully recorded " + recordedBlob.size + " bytes of " +
        recordedBlob.type + " " + recording.src +  " media.");
  })
  .catch(log);
}
