require 'config/environment'

i = Institution.find 7
sl = i.service_levels.first
r = ReportData.new i, sl
d = Dimension.first
r.indicator_table(d.indicators.first)

