// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"
// import './index.css';
// import 'bootstrap/dist/css/bootstrap.css';
// import 'bootstrap/dist/css/bootstrap-theme.css';

import React from 'react';
import ReactDOM from 'react-dom';

import SortableSimple from './components/index';
import MusiqNavbar from './components/Navbar';
import TrackSearch from './components/TrackSearch';

function ready(channel, state) {
  let group_show = document.getElementById('groupshow');
  // let tracksearchbar = document.getElementById('tracksearchbar');
  // console.log(state)
  ReactDOM.render(<SortableSimple state={state} channel={channel}/>, group_show);
  // ReactDOM.render(<TrackSearch />, tracksearchbar);
}

function start() {

  let navbar = document.getElementById('navbar');
  ReactDOM.render(<MusiqNavbar />, navbar);

  let tracksearchbar = document.getElementById('tracksearchbar');
  ReactDOM.render(<TrackSearch />, tracksearchbar);

  if ($('body').data('page') != "GroupView/show"){
    return;
  }
    let group = socket.channel("group:" + window.group_id, {});
    group.join()
        .receive("ok", state0 => {
            console.log("Joined successfully", state0);
            ready(group, state0);
        })
        .receive("error", resp => {console.log("Unable to join", resp);});
}

$(start);
