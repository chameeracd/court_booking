# README

Book Court - Simple ROR RESTfull API to book sport complex

## Setup
`git clone git@github.com:chameeracd/court_booking.git`

`cd court_booking`

`bundle install`

`rails db:reset`

## Run
`rails server`

## API's
### book :
`POST http://127.0.0.1:3000/api/v1/courts/book`

`{
"customer":1,
"court":"T001",
"time":"2022-06-12 23:59:01+00:00"
}`


### booked :
`POST http://127.0.0.1:3000/api/v1/courts/booked`

`{
"date":"022-06-12"
}`


### cancel :
`POST http://127.0.0.1:3000/api/v1/courts/cancel`

`{
"id":1
}`
