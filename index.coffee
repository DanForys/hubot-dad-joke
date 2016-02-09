# Description:
#   Dad points tally
#
# Commands:
#   hubot dad joke [points - optional]- Give dad points award to the previous responder
#   hubot dad score [name]  - Show the dad points tally
latestMessages = {};

module.exports = (robot) ->
  robot.hear /dad joke(\s\d+)?/i, (msg) ->
    name = latestMessages[msg.envelope.room].envelope.user.name
    score = parseInt(msg.match[1]) or 1

    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      user.dadScore = user.dadScore or 0
      user.dadScore += score;
      msg.reply "#{name} now has a Dad score of #{user.dadScore}."
    else
      msg.reply "#{name}? Not a dad I know about!"

  # robot.respond /dad joke @?([\w.\-]+)(\s\d+)?$/i, (msg) ->
  #   name = msg.match[1].trim()
  #   score = parseInt(msg.match[2]) or 1
  #
  #   users = robot.brain.usersForFuzzyName(name)
  #   if users.length is 1
  #     user = users[0]
  #     user.dadScore = user.dadScore or 0
  #     user.dadScore += score;
  #     msg.send "#{name} now has a Dad score of #{user.dadScore}."
  #   else
  #     msg.send "#{name}? Not a dad I know about!"

  robot.respond /dad score @?([\w .\-]+)$/i, (msg) ->
    name = msg.match[1].trim()
    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      user.dadScore = user.dadScore or 0
      msg.send "#{name} has a Dad score of #{user.dadScore}."

  robot.hear /.*$/i, (msg) ->
    latestMessages[msg.envelope.room] = msg
