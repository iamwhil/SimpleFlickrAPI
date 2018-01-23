# README

This is a simple web app for searching Flickr for photographs.

It will only return Flickr's "photograph" type, which excludes .gif images, videos, and screenshots.

This app utilizes Flickr's API, and targets their endpoints with REST calls (primarily GET).

It is designed to be as streamlined as possible, utilizing a single page workflow for landing, searching and sorting.  This should provide a very user friendly workflow.

# MVC

## Controller: Home Controller

This app follows the "thin" controller methodology, keeping most logic in the models.

The home controller will load a history of searches, as well as render searches.  This is performed by calls to the home controller and re-rendered as opposed to AJAX requests.

## Model: Search

The Search model is used to store the search terms (terms) and the number of times a search has been performed (count).

has_many :search_times.  This allows us to keep record of how many time and when this search has been ran.

Attributes 
* terms: String for the search string sent to Flickr.
* count: How many times has this search been ran.

Methods
* Search#get_photos: Perform the search on flickr.  JSON repsonse requested, and parsed.

## Model: SearchTime

belongs_to :search.  SearchTimes belong to one Search

The SearchTime model tracks the time at which a search has been completed on Flickr.

Attributes
* search_id: Which search does this reference, for belongs_to relationship.
* created_at: A rails default attribute, utilized to keep track of when the search was completed.

## Views: index
* Heavy lifter, performs most of the searches, and renders out partials for the images/history and search terms history.

## Views: show
* Utilized to sort the search terms history.  This allows for the results to be updated and displayed without udpating the search count.

## Partials: history_table and images_and_history
* Utilized to render the images/history adn search terms history in the index and show views.

# Non-Conventional Notes

I opted to not utilize layouts, as I only have 2 views here.  If I had more views, in order to DRY things up I would have utilized a layout to house the html's head and script loading information.

I developed the Search model's tests before the model (TDD) as it has the most functionality that can go wrong.  I didn't see a huge need to do the same for the SearchTime as it was a very simple model with one attribute and a relation to the Search.  

Additionally I built the controller tests after the controller.  This did catch a couple bugs when I started to impliment the sort functionality!  Go Tests!!  `bin/rails test`

Lastly, as it is a very bad idea to commit a key to a repository, I've not commited my keys for flickr.  To get this to work as it should locally you'll need a [Flickr key](https://www.flickr.com/services/apps/create/apply/).