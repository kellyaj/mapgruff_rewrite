namespace('Chicago')

class Chicago.Incidents extends Backbone.Collection
  url: "http://198.58.110.111/all_chicago"

  model: Chicago.Incident
