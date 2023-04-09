# Godot Engine Global Search

<p align="center" dir="auto">![demo](https://imgur.com/adlDB4X.gif)</p>


A proof of concept Global Search Node with search-as-you-type functionality, powered by [Typesense](https://github.com/typesense/typesense).  
This repository contains a showcase project based on the public Typesense OpenLibrary dataset that can be found 👉 [here](https://books-search.typesense.org/).  
This project includes the following custom Control Nodes:
- ![HeaderSearchBar](./global_search/scn/header_search_bar/icon.svg) `HeaderSearchBar`, which can be used as a Call to Action in order to get the user input (consisting in a click or typing the `/` character) to spawn/activate a Search scene.  
- ![SearchBarContainer](./global_search/scn/search_bar_container/icon.svg) `SearchBarContainer`, a plug'n'play search bar containing the logic to call whatever search engine's REST APIs and map a result to a generic object, in order to list the result outside of the container itself.  
- ![SearchResultListContainer](./global_search/scn/search_result_list_container/icon.svg) `SearchResultListContainer`, a scrollable container that will show a list of result as clickable elements. Results are categorized through the `category_attribute` property which represents the attribute that each result should have, and that will be used to group each element based on the user-defined `categories`.  
- ![SearchResultCategoryContainer](./global_search/scn/search_result_category_container/icon.svg) `SearchResultCategoryContainer`, an node containing a list of result for a single category.  
- ![SearchResultContainer](./global_search/scn/search_result_container/icon.svg) `SearchResultContainer`, an node containing a single search result as a clickable object.  
- ![SearchStatsWidget](./global_search/scn/widgets/stats/icon.svg) `SearchStatsWidget`, a plug'n'play widget showing some stats about each search, including number of results, query used for the search, and the search time.  
- ![GlobalSearchContainer](./global_search/scn/global_search_container/icon.svg) `GlobalSearchContainer`, a plug'n'play scene containing all the nodes previously described.  
