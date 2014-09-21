define [
    'underscore',
    'utils/popularityRanges'
], (_, popularityRanges)->

    utils =
        calculateWordColor: (model)->
            fontColor = 'grey'
            sentimentScore = model.get('sentimentScore')
            
            if sentimentScore > 60
                fontColor = 'green'
            else if sentimentScore < 40
                fontColor = 'red'
            
            fontColor

        calculateWordSize: (model)->
            popularity = Math.floor (model.get('volume') / model.collection.popularity.max) * 100
            
            fontSize = 6
            range = _.find popularityRanges, (range, index)->
                if popularity <= range[0] and popularity >= range[1]
                    fontSize = index + 1
                    return yes

            fontSize