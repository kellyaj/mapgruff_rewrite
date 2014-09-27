namespace('DevUtils')

class DevUtils.Incidents extends Backbone.Collection

  url: "http://localhost:9292/all_seattle"

  comparator: (incident) ->
    date = new Date(incident.get('date'))
    -date.getTime()
