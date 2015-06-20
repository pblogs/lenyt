# API DOCS #

# User resource

## current_user info [:GET]
`/api/users/current.json`

### response

```
{
  "first_name":"John",
  "last_name":"Doe",
  "username":"John Doe (johndoe)",
  "address":null,
  "email":"johndoe@gmail.com",
  "avatar":"https://lh6.googleusercontent.com/-DUfJtXdmzqg/CbpdcydfgzgSZ2I/photo.jpg?sz=50"
}
```
## user products list [:GET]
`/api/users/:id/products.json`

### response

```
  {
    "products":
    [
      {
        "id":1,
        "title":"Nikon 10",
        "image":"/assets/small-img.jpg",
        "price_per_day":20,
        "map":{"lat":44.099421,"long":-79.793701}
      },
      {
        "id":3,
        "title":"Nikon 18",
        "image":"/assets/small-img.jpg",
        "price_per_day":12,
        "map":{"lat":43.834527,"long":-79.689331}
      },
      {
        "id":4,
        "title":"Nikon 11",
        "image":"/assets/small-img.jpg",
        "price_per_day":16,
        "map":{"lat":44.138856,"long":-79.337769}
      }
      ......
    ]
  }
```
# Tag resource

## tag listings [:GET]
`/api/products/:id.json`

### response
```
{"tags":[
      {"id":1,"name":"nikon","taggings_count":123},
      {"id":2,"name":"leica","taggings_count":10}
    ]
}
```

# Product resource

## product info [:GET]
`/api/tags.json`

### response
```
{
  "product":
  {
    "id":2,
    "title":"Nikon 17",
    "voted":true,
    "details": "Lorem Ipsum is simply dummy text of the printing and typesetting................",
    "request_sent": false,
    "images":[
      {"url":"/system/assets/images/000/000/001/original/slider1.png?1433499688"},
      {"url":"/system/assets/images/000/000/002/original/slider2.png?1433499699"},
      {"url":"/system/assets/images/000/000/003/original/slider3.jpg?1433499702"},
      {"url":"/system/assets/images/000/000/004/original/slider5.jpg?1433499705"}
    ],
    "total_value":487,
    "price_per_day":18,
    "map":{"lat":43.747289,"long":-80.079346},
    "user":
      {
        "id":1,
        "name":"testuser1",
        "avatar":"https://lh6.googleusercontent.com/-DUfJtXdmzqg/AAAAAAAAAAI/AAAAAAAAAG8/CbpdcyzgZ2I/photo.jpg?sz=50",
        "rating":{"avg":0,"count":0}
      }
    }
  }
```

# Rate resource

## create [:POST]
`/api/rate/`

### params
`{"score"=>"3", "dimension"=>"trust", "id"=>"1", "klass"=>"User"}`

### response

```
  true || false
```

# Request resource

## create [:POST]
`/api/requests`

### params

```
{
  "request"=>
  {
    "product_id"=>"1",
    "rent_from_date"=>"2015-06-09",
    "rent_to_date"=>"2015-06-30",
    "insurance"=>"1"
  }
}
```
### response
#### success
```
{
"status": "success"
}
```
#### fail
```
  {"rentee_id":["can't be blank"],"product_id":["can't be blank"],"renter_id":["can't be blank"],"amount":["can't be blank","is not a number"],"rent_from_date":["is not a date"],"rent_to_date":["is not a date"], "insurance":["can't be blank"],"errors":["You can't send request to yourself"]}
```
## request info [:GET]
`/api/requests/:id`

### success response
```
{
  "request": {
  "id": 2,
  "amount": "150",
  "rent_from_date": "2015-06-09",
  "rent_to_date": "2015-07-09",
  "insurance": "Full Deposit",
  "renter": {
    "id": 1,
    "email": "rmagnum2002@gmail.com",
    "username": "rmagnum2002"
    },
  "rentee": {
    "id": 2,
    "email": "test1@mail.com",
    "username": "testuser1"
    }
  }
}
```
### fail response
```
{
  "status": "not found"
}
```


# Conversation resource

## current user conversations [:GET]
`/api/conversations`

### response
```
{
  "conversations": [
    {
    "id": 10,
    "created_at": "2015-06-10T10:10:46.518Z",
    "participant":{
      "avatar":"/assets/default_avatar.png",
      "username":"testuser1"
    },
    "options":{"request_buttons":false},
    "request": {
      "id": 8,
      "amount": "150",
      "rent_from_date": "2015-06-09",
      "rent_to_date": "2015-07-09",
      "insurance": "Full Deposit",
      "renter": {
      "first_name": "Sergiu",
      "last_name": "Rosca",
      "username": "rmagnum2002",
      "address": null,
      "email": "rmagnum2002@gmail.com",
      "avatar": "https://lh6.googleusercontent.com/-DUfJtXdmzqg/AAAAAAAAAAI/AAAAAAAAAG8/CbpdcyzgZ2I/photo.jpg?sz=50",
        "rating": {
          "avg": 3.5,
          "count": 2
        }
      },
      "rentee": {
      "first_name": null,
      "last_name": null,
      "username": "testuser1",
      "address": null,
      "email": "test1@mail.com",
      "avatar": "/assets/default_avatar.png",
        "rating": {
          "avg": 0,
          "count": 0
        }
      },
      "product": {
        "id": 15,
        "title": "Nikon 18",
        "image": "/system/assets/images/000/000/057/thumb/slider1.png?1433860867"
      }
    },
    "messages": [
      {
        "id": 60,
        "body": "Hi, I am interested to rent this!",
        "sender_name": "testuser1",
        "sender_id": 2,
        "created_at": "2015-06-10T10:10:46.518Z"
      }
    ]
    }
  ]
}
```
## conversation info [:GET]
`/api/conversations/:id`

### success response
```
{
  "conversation": {
    "id": 10,
    "created_at": "2015-06-10T10:10:46.518Z",
    "request": {
      "id": 8,
      "amount": "150",
      "rent_from_date": "2015-06-09",
      "rent_to_date": "2015-07-09",
      "insurance": "Full Deposit",
      "renter": {
        "first_name": "Sergiu",
        "last_name": "Rosca",
        "username": "rmagnum2002",
        "address": null,
        "email": "rmagnum2002@gmail.com",
        "avatar": "https://lh6.googleusercontent.com/-DUfJtXdmzqg/AAAAAAAAAAI/AAAAAAAAAG8/CbpdcyzgZ2I/photo.jpg?sz=50",
          "rating": {
            "avg": 3.5,
            "count": 2
          }
        },
      "rentee": {
        "first_name": null,
        "last_name": null,
        "username": "testuser1",
        "address": null,
        "email": "test1@mail.com",
        "avatar": "/assets/default_avatar.png",
        "rating": {
          "avg": 0,
          "count": 0
        }
      },
      "product": {
        "id": 15,
        "title": "Nikon 18",
        "image": "/system/assets/images/000/000/057/thumb/slider1.png?1433860867"
      }
    },
    "messages": [
      {
      "id": 60,
      "body": "Hi, I am interested to rent this!",
      "sender_name": "testuser1",
      "sender_id": 2,
      "created_at": "2015-06-10T10:10:46.518Z"
      }
    ]
  }
}
```
### fail response
```
{
  "status": "not found"
}
```
