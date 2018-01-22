# README

This is a simple web app for searching Flickr for photographs.

It will only return Flickr's "photograph" type, which excludes .gif images, videos, and screenshots.

This app utilizes Flickr's API, and targets their endpoints with REST calls (primarily GET).

It is designed to be as streamlined as possible, utilizing a single page workflow for landing, searching and sorting.  This should provide a very user friendly workflow.

# MVC

Controller: Home Controller

This app follows the "thin" controller methodology, keeping most logic in the models.

The home controller will load a history of searches, as well as render searches.  This is performed by new calls to the home controller as opposed to AJAX requests.

Model: Search

Attributes 
* created_at: date/timestamp for creation of Search.
* terms: string for the search string sent to Flickr.
* count: how many times has this search been ran.

Methods
* Search#get_photos: perform the search on flickr.  JSON repsonse requested, and parsed.
* Search#build_image_urls: Builds the image urls for each of the returned images.