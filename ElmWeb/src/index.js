import './main.css';
import { Elm } from './Main.elm';
import * as serviceWorker from './serviceWorker';
import { startAudioRecording, stopAudioRecording } from './recHelper.js';


var app = Elm.Main.init({
  node: document.getElementById('root')
});

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();


app.ports.startRecording.subscribe(function(message) {
    startRecording();
});

/*app.ports.helloWorld.subscribe(function(message) {
    console.log("app.ports.helloWorld");
    testFunc();
});*/

app.ports.stopRecording.subscribe(function(message) {
    stopRecording();
});
