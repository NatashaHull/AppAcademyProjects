exports.Router = function(request, response, fs) {
  if (request.url === '/') {
    fs.readFile('public/index.html', function(err, data) {
      if (err) throw err;
      response.writeHead(200, {'Content-Type': 'text/html'});
      response.end(data);
    });
  } else {
    fs.readFile('public'+request.url, function(err, data) {
      if (err) {
        response.writeHead(404, {'Content-Type': 'text/html'});
        response.end('File Not Found');
      }
      else {
        response.writeHead(200, {'Content-Type': 'text/html'});
        response.end(data);
      }
    });
  }
}