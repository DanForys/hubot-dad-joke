# Dad Joke tally

A Hubot script that keeps a running tally of your level of punnage.

## Installation

Navigate to your Hubot instance's directory and run `npm i hubot-dad-joke --save`, and add `"hubot-dad-joke"` to the array in the `external-scripts.json` file. Then simply redeploy your bot.

## Usage

* `dad joke` - increments the previously commenting user's Dad score by 1
* `dad joke [x]` - award an arbitrary number of Dad points
* `hubot dad score [name]` - see just how funny [name] is
* `hubot dad score reset [name]` - Turn [name] back into a non-dad and reset their score to 0
