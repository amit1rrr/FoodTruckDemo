# Food Truck Demo
Geo spatial rails app for showing food trucks in the vicinity. 
App is currently hosted [online here](https://frozen-beach-21640.herokuapp.com).

### Installation
```
>git clone https://github.com/amit1rrr/FoodTruckDemo.git
>cd FoodTruckDemo
>bundle install
>rails server
```
### Problem Statement
Create a service that tells the user what types of food trucks might be found near a specific location on a map. The data is available on DataSF: [Food Trucks](https://data.sfgov.org/Economy-and-Community/Mobile-Food-Facility-Permit/rqzj-sfat)

### Solution
#### Backend
I built a backend service which lets client query food trucks in their vicinity with different criterias. Clients can specify their own address and request food trucks only within certain distance from it. They can optionally specify food items they are interested in. They can also limit the number of results in which case we will return closest n trucks matching their criteria. 

Some example URLs:
-[https://frozen-beach-21640.herokuapp.com/food_trucks?range=2&limit=30](https://frozen-beach-21640.herokuapp.com/food_trucks?range=2&limit=30)
-[https://frozen-beach-21640.herokuapp.com/food_trucks?limit=80&street=180%20spear%20st](https://frozen-beach-21640.herokuapp.com/food_trucks?limit=80&street=180%20spear%20st)
-[https://frozen-beach-21640.herokuapp.com/food_trucks?street=900%20Branan%20street&keywords=burrito&range=2](https://frozen-beach-21640.herokuapp.com/food_trucks?street=900%20Branan%20street&keywords=burrito&range=2)

**All URL parameters and their default values:**
```
limit=10 : Return only 10 results (default 500)
keywords="Hot dogs" : Return only trucks which sells hot dogs (no default value)
street="180 Spear st" : Client's street address (blank by default)
city="Seattle" : Client's city (San Fransicso by default)
country="USA" : Client's country (USA by default)
range=2 : Returns only trucks within 2 kilometers of client's address (default 10 Km)
```

**To see the JSON reponse just append .json to food_trucks in any of the URLs above e.g.** 
-[http://localhost:3000/food_trucks.json?range=1&limit=2](http://localhost:3000/food_trucks.json?range=1&limit=2)

#### Front end
I built a minimal front end to demonstrate the capabilities of backend. It uses Google maps to display the trucks and client's location. It shows all the relevent details of any truck and directions to it from the client's location. There are no text boxes/forms on front end, one has to use url parameters to make GET requests.

#### Other RESTful request
We get PUT, DELETE etc. http methods for free as the FoodTruck model is generted with scaffolds. We can also look at specific food truck (GET /food_truck/id) and also create a new one (/food_trucks/new). All this for free thanks to scaffolds :)

## Technonology choices
**Ruby on Rails:** I am fairly experienced with it. It is easy to setup backend api and a demo front end using Rails. Powerful Gems like Geocoder and Gmaps4Rails make it easy to integrate google maps in the app. 

**Postgres with PostGIS extension on AWS RDS:** No experience. Primarily chose this as it supports spatial queries and spatial indexes. We are using a AWS RDS postgres instance. We have index on location column which make our range queries run faster. Easy to plug this into Rails with ActiveRecord.

**Heroku** for hosting. Easy and free :) 

## Future enhancement
- Add Gin or GIST index to make the keyword lookup faster. Currently we are using sql's LIKE operator which is very resource intensive. [http://stackoverflow.com/questions/1566717/postgresql-like-query-performance-variations](http://stackoverflow.com/questions/1566717/postgresql-like-query-performance-variations)
- Add caching with Memcached or Redis
- Accept timestamp and return trucks which will be available at that time.
- Currently we can refresh entire database with `rake db:seed` but we should implement delta updates to only update modified rows or add new rows without flushing the entire table.
