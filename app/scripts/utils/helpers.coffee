'use strict'
define [
    'underscore',
    'utils/popularityRanges'
], (_, popularityRanges)->
    # a set of helper functions
    helpers =
        # returns a font color according to topic sentiment
        calculateTopicColor: (topic)->
            fontColor = 'grey'
            sentimentScore = topic.get('sentimentScore')
            
            if sentimentScore > 60
                fontColor = 'green'
            else if sentimentScore < 40
                fontColor = 'red'
            
            fontColor

        # returns a font size from 1 to 6 according to topic volume
        calculateTopicSize: (topic)->
            # compute topic popularity in percentage to the max popularity value cached in the collection
            popularity = Math.floor (topic.get('volume') / topic.collection.popularity.max) * 100
            
            fontSize = 6
            # check in which range this topic belongs to (see utils/popularityRanges for ranges definition)
            range = _.find popularityRanges, (range, index)->
                if popularity <= range[0] and popularity >= range[1]
                    fontSize = index + 1
                    return yes

            fontSize

        # returns an url segment from a topic id by replacing special characters with dashes
        generateUrlSegment: (topic)->
            id = topic.id
            id.replace(/[^0-9a-zA-ZäöüÄÖÜ_]/g, '-') if id? and typeof id.replace is 'function'