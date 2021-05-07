#!/usr/bin/env node

const compose = require("docker-compose");
const path = require("path");
const yargs = require("yargs");

compose.upAll(
  { cwd: path.join(__dirname), 
    log: true ,
    config: [ "docker-compose.yml","mysecondservice/docker-compose.yml" ]//@STCGoal Start two services description in one shot :)


  }).then(
  () => {
    console.log('done')
  },
  (err) => {
    console.log('something went wrong:', err.message)
  }
)


