#!/usr/bin/env node

const compose = require("docker-compose");
const path = require("path");
const yargs = require("yargs");

compose.upAll(
  { cwd: path.join(__dirname), 
    log: true

  }).then(
  () => {
    console.log('done')
  },
  (err) => {
    console.log('something went wrong:', err.message)
  }
)


compose.exec('node', 'npm install', { cwd: path.join(__dirname) })

compose.down(
  { cwd: path.join(__dirname), 
    log: true

  }).then(
  () => {
    console.log('done')
  },
  (err) => {
    console.log('something went wrong:', err.message)
  }
)
