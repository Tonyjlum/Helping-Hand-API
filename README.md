# Helping Hand API
[HelpingHandAPI](http://helpinghandapi.herokuapp.com)

The Helping Hand API was designed to serve as an active record database for my [HelpingHand](https://github.com/Tonyjlum/mod5frontend) app. It utilizes RESTful routing and and CRUD actions on certain models. All proper GET requests will be returned in a JSON format.

## Contents

- [Getting Started](#getting-started)
- [Gems](#gems)
- [Sample Calls](#sample-calls)
- [Models](#models)
- [Serializers](#serializers)
- [Controllers](#controllers)
- [Future Development](#future-development)

## Getting Started
To install the apps dependencies, use: `bundle install`.
The app runs on Ruby 2.5.3. If you run into issues with the ruby version, try changing the ruby version with the [Ruby Version Manager](https://rvm.io/rvm/install): `rvm 2.5.3`. If you do not have this particular version of ruby installed, you can run `rvm install 2.5.3`.

You can start up the server with `rails server`. To customize the port, use `rails server -p portnumber` (e.g. rails sever -p 9001).

`rails console` will open the rails console and `quit` will exit the console.

## Gems
Some ruby gems that are used in this app. A fuil list can be found in the `./Gemfile` located at the root.

**Postgresql** is the database that is used for this API.

**Faker** is used to support the seeding process with data such as name and date.

**Active-Model-Serializers** is used to return the customize JSON when a API call is made.

## Sample Calls
Once the server is started, you will have access to Users, Sponsors, Events, Donations, and Confirms. Currently, calls to the API do not have a version number, so simply `http://localhost:3000/users/1` would return the JSON for user 1.
```
{
  id: 1,
  email: tonyjlum@gmail.com,
  first_name: Tony,
  last_name: Lum,
  credit: 0,
  confirm_event_info: [
    {
      confirm: {
      id: 1,
      user_id: 1,
      event_id: 1,
      attend: false,
      created_at: 2019-03-25T19:43:01.003Z,
      updated_at: 2019-03-25T19:43:01.003Z
    },
      event: {
        id: 1,
        coordinator_id: 1,
        datetime: 2019-03-09T18:41:58.000Z,
        title: Bowling Green Clean Up,
        max_volunteers: 20,
        address: Broadway &, Whitehall St, New York, NY 10004,
        description: Park beautification project for Bowling Green in downtown Manhattan,
        lat: 40.70406,
        long: -74.01322,
        created_at: 2019-03-25T19:43:00.930Z,
        updated_at: 2019-03-25T19:43:00.930Z
      }
    },
    {
      confirm: {
        id: 21,
        user_id: 1,
        event_id: 2,
        attend: false,
        created_at: 2019-03-25T19:43:01.242Z,
        updated_at: 2019-03-25T19:43:01.242Z
      },
      event: {
        id: 2,
        coordinator_id: 1,
        datetime: 2019-03-11T17:41:40.000Z,
        title: Holy Apostles Soup Kitchen Volunteer,
        max_volunteers: 14,
        address: 296 9th Ave, New York, NY 10001,
        description: Soup kitchen that will feed 2000 new yorkers today.,
        lat: 40.75823,
        long: -73.99275,
        created_at: 2019-03-25T19:43:01.224Z,
        updated_at: 2019-03-25T19:43:01.224Z
        }
      },
      {
      confirm: {
        id: 41,
        user_id: 1,
        event_id: 4,
        attend: false,
        created_at: 2019-03-25T19:43:01.451Z,
        updated_at: 2019-03-25T19:43:01.451Z
      },
      event: {
        id: 4,
        coordinator_id: 1,
        datetime: 2019-03-08T22:40:47.000Z,
        title: Lavender Field on Governors Island,
        max_volunteers: 23,
        address: Governors IslandNew York, NY 11231,
        description: Community service: mural  painting project. Art skills not required,
        lat: 40.6895,
        long: -74.0168,
        created_at: 2019-03-25T19:43:01.448Z,
        updated_at: 2019-03-25T19:43:01.448Z
      }
    }
  ]
}
```
Depending on your port, change the `3000` accordingly. For GET requests:
- users, sponsors, and events have an index(http://localhost:3000/users) and show(http://localhost:3000/users/1) actions.
- donations and confirms only have index actions for GET requests.

## Models
There are 3 main models in this API. The Users model are the volunteers model and they have many confirms and events. The Sponsors model are the sponsors and they have many donations and events. The Event model has many donations, confirms, users and sponsors. It is the basic lifeline of the app.

## Serializers
The Serializer controls the JSON data that is returned to the GET request.

**Users** do not return the password from the account. They also return a custom function confirm_event_info.
```
def confirm_event_info
  object.confirms.map {|confirm|
    {confirm: confirm, event: confirm.event}
  }
end
```
This function returns all of the confirmations from the particular user and the event that is tied to the confirmation. It helps reduce the need for fetching for events and confirmations.

Similar to Users, **Sponsors** do not return the password. It does return all of their donations when a request is made.

Each **Event** returns all donations and confirmations associated with the event. Additionally, it returns the number of volunteers for the event and the name of the coordinator(the user that made the event).

Viewing the **Confirm** data will also return the user full name and email. This was intended to be used with a mass mailing system to alert volunteers for changes in the event such as additional donations, change in date and/or time, event cancelation, and credit confirmations.

When viewing a **Donation**, it will show the sponsors name, events title and description, current and maximum number of volunteers for the event, number of volunteers who actually attended( used for calculating credit from the sponsor), maximum amount this event will cost to the sponsor, and the events date/time.

## Controllers
The controller allows for easy RESTful routes. Most of the actions are fairly standard(index, show, create, update, destroy). These actions are not available to every controller. A more complex action is the Confirm's Update action.
```
def update
  params["attended_id"].each{ |id|
    confirm = Confirm.find(id)
    event = Event.find(confirm.event_id)
    user = User.find(confirm.user_id)

    if confirm.attend == false && event.donations.count > 1
      donations = event.donations
      total_donations = donations.map{ |d| d.amount_per_volunteer}.reduce(:+)
      user.update(credit: user.credit + total_donations)
      donations.each{ |d|
        sponsor = Sponsor.find(d.sponsor_id)
        sponsor.update(
          credit: sponsor.credit - d.amount_per_volunteer,
          total_donations: sponsor.total_donations + d.amount_per_volunteer)
      }
    end
    confirm.update(attend: true)
  }
  render json: {attended_id: params["attended_id"]}
end
```
This controller accepts an array of `attended_id` from the fetch request. This array only consist of id's of users who attended the event. The array is iterated through and the confirm, event, and user is found. It then checks if the user attended and if the event had donations. If if there are donations, they are reduced and added to the users account. The amount is also removed from the sponsor's credit. Since a event can be updated multiple times, it only attempts to add and remove credit if `confirm.attend == false`. All confirms from the array will be updated with `confirm.update(attend: true)`.

The Confirm's create action will return the confirm created and the event that it is associated with. This allows the helpinghand app to update the redux store easier.

## Future Development
There are 2 unused models that I wish to build on. The Charity model will be able to keep track of how much support they have received from donations and how many individuals have donated through the Credit Receipt model.

I would like for Sponsors to be able to calculate their total donation through a time period (e.g. annually).
