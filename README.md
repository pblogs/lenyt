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

# Product resource

## product info [:GET]
`/api/products/:id.json`

### response
```
{
  "product":
  {
    "id":2,
    "title":"Nikon 17",
    "voted":true,
    "details": "Lorem Ipsum is simply dummy text of the printing and typesetting................",
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
{"request"=>{"renter_id"=>"1", "rentee_id"=>"2", "amount"=>"150", "rent_from_date"=>"2015-06-09", "rent_to_date"=>"2015-06-30"}}
```
### response
```
  {"rentee_id":["can't be blank"],"product_id":["can't be blank"],"renter_id":["can't be blank"],"amount":["can't be blank","is not a number"],"rent_from_date":["is not a date"],"rent_to_date":["is not a date","is not a date"]}
```
