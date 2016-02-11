# Description:
#   Dad points tally
#
# Commands:
#   dad joke [points - optional]- Give dad points award to the previous responder
#   hubot dad score [name]  - Show the dad points tally
#   hubot dad score reset [name] - Turn [name] back into a non-dad
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

      if user.dadScore >= Number.MAX_SAFE_INTEGER
        msg.reply "ERROR: DAD OVERFLOW FOR #{name}"
        user.dadScore = 0

      msg.reply "#{name} now has a Dad score of #{user.dadScore}."
    else
      msg.reply "#{name}? Not a dad I know about!"

  robot.respond /dad score reset @?([\w .\-]+)$/i, (msg) ->
    name = msg.match[1].trim()
    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      user.dadScore = 0
      msg.send "Ok, forgetting all the bad jokes of #{name}."

  robot.respond /dad score @?([\w .\-]+)$/i, (msg) ->
    name = msg.match[1].trim()
    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      user.dadScore = user.dadScore or 0
      msg.send "#{name} has a Dad score of #{user.dadScore}."

  robot.hear /.*$/i, (msg) ->
    latestMessages[msg.envelope.room] = msg
