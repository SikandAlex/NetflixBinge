# Netflix Binge iOS App
iOS application to find highly rated TV shows currently available on Netflix along with how long it will take to binge watch all seasons of the show. Particularly useful during the COVID-19 pandemic!

![enter image description here](https://lh3.googleusercontent.com/xOepOBDoc-pR8DcukcDzKE8YYElcciyq2MN_Z0zePXJCkRmhWrmTYZJ76EIgQ7LET4ZZRUis-lDQYV1E7UZ8p_5hREqwWpjLvRZ-3IWHDG_9BPXdmNs8eX03-jTytld5kPUFWmbjFwE=w2400)

![enter image description here](https://lh3.googleusercontent.com/HRi1m2uUtLLfIvLUd_IxRnc1I1QSIt4vh2xIP0Lu79hB9xYKKJKRgcX-sBmRpp2GgupqPKpVImc8L5qNk-nQYie0LSR-e-z10V9ocuFUv4y_nEs-lB4zyOq38R1kkbGepRFNM1km2os=w2400)

![enter image description here](https://lh3.googleusercontent.com/84U4ZEWp_Y905RXZ5zdAlEMVWqUF5iO8JJmVEZpw6f0c28sOQAU6TZldXrhalNWb4iM3dIKkCzCj9JVjepf38UHI7Fzc-LQ2VAf4plga7TG_fYjQvSvv_2SuYcIE1gHXK8E5GP3sKBE=w2400)



## Installation

You must be using a Mac with Xcode installed. App will be distributed over TestFlight in the near future.

Clone the repo and open NetflixBinge.xcworkspace

Build and run the app on the iOS simulator or connect your iPhone and install directly to your physical device.

## APIs and External Libraries
Unofficial Netflix Global Search API [https://rapidapi.com/unogs/api/unogs](https://rapidapi.com/unogs/api/unogs)

The Movie Database API [https://developers.themoviedb.org/3](https://developers.themoviedb.org/3)

SwiftSoup [https://github.com/scinfu/SwiftSoup](https://github.com/scinfu/SwiftSoup)

SDWebImage [https://github.com/SDWebImage/SDWebImage](https://github.com/SDWebImage/SDWebImage)

## Breakdown

**Fetcher.swift** contains the networking code that talks to the various APIs

**Responses.swift** contains the structs responsible for decoding the JSON response from the API to native Swift objects

**MovieCell.swift** defines the row/cells for the TableView

**MovieTableViewController.swift** contains the code for setting up the main view and registering the cells to the table view, conforms to UITableViewDelegate and UITableViewDatasource protocols

**DetailViewController.swift** contains the code for setting up the detail view

## Meta

CS 411 Software Engineering Team

 - Alexander Sikand
 - Andres Rodriguez
 - Henry Wu
 - Leon Yu

