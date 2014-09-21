"use strict"
define [
    'underscore',
    'utils/popularityRanges'
], (_, popularityRanges)->

    utils =
        calculateTopicColor: (topic)->
            fontColor = 'grey'
            sentimentScore = topic.get('sentimentScore')
            
            if sentimentScore > 60
                fontColor = 'green'
            else if sentimentScore < 40
                fontColor = 'red'
            
            fontColor

        calculateTopicSize: (topic)->
            popularity = Math.floor (topic.get('volume') / topic.collection.popularity.max) * 100
            
            fontSize = 6
            range = _.find popularityRanges, (range, index)->
                if popularity <= range[0] and popularity >= range[1]
                    fontSize = index + 1
                    return yes

            fontSize