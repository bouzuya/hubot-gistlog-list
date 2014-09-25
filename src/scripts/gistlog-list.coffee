# Description
#   A Hubot script that lists gistlog
#
# Configuration:
#   HUBOT_GISTLOG_LIST_USERNAME
#
# Commands:
#   hubot gistlog list <username> - lists gistlog
#
# Author:
#   bouzuya <m@bouzuya.net>
#
module.exports = (robot) ->
  robot.respond /gistlog list(?: (\S+))?$/i, (res) ->
    user = res.match[1] ? process.env.HUBOT_GISTLOG_LIST_USERNAME
    url = "https://api.github.com/users/#{user}/gists"
    res.http(url).get() (err, _, body) ->
      return res.send(err) if err?
      gists = JSON.parse(body)
      message = gists
        .filter (gist) ->
          gist.description.match(/^\d{4}-\d{2}-\d{2}\s/)
        .map (post) ->
          "#{post.description} #{post.html_url}"
        .join '\n'
      res.send message
