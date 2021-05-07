#!/usr/bin/env node

const compose = require("docker-compose");
const path = require("path");
const yargs = require("yargs");

var config1 = { cwd: path.join(__dirname), 
  log: true //@STCGoal Start two services description in one shot :)
};
var svc2path = path.join("mysecondservice/docker-compose.yml");
console.log("svc2path: " + svc2path);
var config2 = { cwd: svc2path, 
  log: true //@STCGoal Start two services description in one shot :)
};

compose.down(
{  cwd: path.join(__dirname), 
  log: true,
  config: ["./docker-compose.yml",svc2path]
}
  ).then(
  (data) =>  {
    console.log('done');
    console.log(data);
  },
  (err) => {
    console.log('something went wrong:', err.message)
  }
)


