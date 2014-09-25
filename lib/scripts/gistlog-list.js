// Description
//   A Hubot script that lists gistlog
//
// Configuration:
//   HUBOT_GISTLOG_LIST_USERNAME
//
// Commands:
//   hubot gistlog list <username> - lists gistlog
//
// Author:
//   bouzuya <m@bouzuya.net>
//
module.exports = function(robot) {
  return robot.respond(/gistlog list(?: (\S+))?$/i, function(res) {
    var url, user, _ref;
    user = (_ref = res.match[1]) != null ? _ref : process.env.HUBOT_GISTLOG_LIST_USERNAME;
    url = "https://api.github.com/users/" + user + "/gists";
    return res.http(url).get()(function(err, _, body) {
      var gists, message;
      if (err != null) {
        return res.send(err);
      }
      gists = JSON.parse(body);
      message = gists.filter(function(gist) {
        return gist.description.match(/^\d{4}-\d{2}-\d{2}\s/);
      }).map(function(post) {
        return "" + post.description + " " + post.html_url;
      }).join('\n');
      return res.send(message);
    });
  });
};
