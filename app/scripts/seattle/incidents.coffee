namespace('Seattle')

class Seattle.Incidents extends Backbone.Collection
  url: "http://198.58.110.111/all_seattle"

  model: Seattle.Incident

  comparator: (incident) ->
    date = new Date(incident.get('date'))
    -date.getTime()
