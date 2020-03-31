# Netflix Binge iOS App
iOS application to find highly rated TV shows currently available on Netflix along with how long it will take to binge watch all seasons of the show. Particularly useful during the COVID-19 pandemic!

![](https://lh3.googleusercontent.com/9qkIdMgN2X8LA2kn9IoAax_wubYb8RafgB82NaXbnlTwQDKA8O9gli43IaGG0oIJgPhkOIThBF17-xnm7b3VJIgoEruQKH-BbJOxc7e4-k6Jdp7Ge56AAb9MyqKAzla4_5FEcoFmO-4=w480)

Login                      |  Browse
:-------------------------:|:-------------------------:
![](https://lh3.googleusercontent.com/ZUIoNBZWgMxhW1dKOT1yaNqRP22o6fKYku6IMyKjGIUKm2tMuoT52JJMcR1l2hViU0B9uG7AspFElPFMgXfXeX1GReGGDEyqOT5GEalqJfyDRWACxDB9MltwuiGNXXlGde1uCl8Zfoo=w240)  |  ![](https://lh3.googleusercontent.com/qgphAsE2njk2Ja2hiXpMfRGJ9obuIJQECd2qoKYtF0IO7cnsDncTBnakDefDTuCNH-pyE4Tm-0_kK83iWVP3HVzLFhjoSH97KtfjP60xilMN3W88E7jlX4J90j-NiJ_Px137myzQ1fo=w240)






## Installation

You must be using a Mac with Xcode installed. App will be distributed over TestFlight in the near future.

Clone the repo and open NetflixBinge.xcworkspace

Build and run the app on the iOS simulator or connect your iPhone and install directly to your physical device.

**Download GoogleServive-Info.plist from Firebase Console and add to your project or it will not work!**

## APIs and External Libraries
Unofficial Netflix Global Search API [https://rapidapi.com/unogs/api/unogs](https://rapidapi.com/unogs/api/unogs)

The Movie Database API [https://developers.themoviedb.org/3](https://developers.themoviedb.org/3)

SwiftSoup [https://github.com/scinfu/SwiftSoup](https://github.com/scinfu/SwiftSoup)

SDWebImage [https://github.com/SDWebImage/SDWebImage](https://github.com/SDWebImage/SDWebImage)

LGButton [https://github.com/loregr/LGButton](https://github.com/loregr/LGButton)

Dribble Inspiration [https://dribbble.com/shots/9017531-Movie-app-collection/attachments/1141603?mode=media](https://dribbble.com/shots/9017531-Movie-app-collection/attachments/1141603?mode=media)

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

