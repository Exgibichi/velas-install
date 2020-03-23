const data = require("./down.json");
const fs = require("fs");
const https = require("https");

const newName = "velasblockchain";

const downDir = __dirname + "/";

const download = (uri, filename, callback) => {
  const [dir] = filename.split("/");
  if (!fs.existsSync(downDir + dir)) {
    fs.mkdirSync(downDir + dir);
  }
  const file = fs.createWriteStream(filename);
  https.get(uri, response => {
    response.pipe(file).on("close", function() {
      callback(filename);
    });
  });
};

const filtered = data.filter(d => d.version === "v2.7.2");
const urls = filtered.map(d =>
  d.files
    .filter(f => f.downloadUrl.indexOf("windows") === -1)
    .map(f => f.downloadUrl)
);

const setNewName = url => {
  const parts = url.split("/");
  const name = parts[6].replace("parity", newName);
  return (
    parts[5]
      .split("-")
      .filter(p => ["gnu", "apple", "unknown"].indexOf(p) === -1)
      .join("-") +
    "/" +
    name
  );
};

urls
  .filter(url => url.length)
  .forEach(url =>
    url.map(u =>
      download(u, setNewName(u), filename =>
        console.log(u, " downloaded to: ", filename)
      )
    )
  );
