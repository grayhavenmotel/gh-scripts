import fest.graph

# Connect to Graph API & get page
graph = fest.graph.GraphAPI.from_credentials(
    app_id='<app_id>',
    app_secret='<app_secret>')
page = graph.get_page('<page_id_or_alias>')

# Get upcoming events
upcoming = page.get_events(time_filter='upcoming')

# Iterate over all events
for event in page.iter_events():
    print(event)