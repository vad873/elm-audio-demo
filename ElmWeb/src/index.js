import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
import * as recHelper from './recHelper.js';
import * as recVideoHelper from './recVideoHelper.js';


var app = Elm.Main.init({
  node: document.getElementById('root')
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();

app.ports.startAudioRecording.subscribe(function(message) {
    recHelper.startAudioRecording();
});

app.ports.stopAudioRecording.subscribe(function(message) {
    recHelper.stopAudioRecording();
});

app.ports.startVideoRecording.subscribe(function(message) {
    recVideoHelper.startVideoRecording();
});

app.ports.stopVideoRecording.subscribe(function(message) {
    recVideoHelper.stopVideoRecording();
});
