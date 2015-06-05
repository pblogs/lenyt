# README #

# GET current_user info

### request

`/api/users/current.json`

### response

```
{
  "first_name":"Sergiu",
  "last_name":"Rosca",
  "username":"Sergiu Rosca (rmagnum2002)",
  "address":null,
  "email":"usermail@gmail.com",
  "avatar":"https://lh6.googleusercontent.com/-DUfJtXdmzqg/AAAAAAAAAAI/AAAAAAAAAG8/CbpdcyzgZ2I/photo.jpg?sz=50"
}
```

# GET user products list

### request

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


# GET product info

### request

`/api/products/:id.json`

### response

```
{
  "product":
  {
    "id":2,
    "title":"Nikon 17",
    "images":[
      {"url":"/system/assets/images/000/000/001/original/slider1.png?1433499688"},
      {"url":"/system/assets/images/000/000/002/original/slider2.png?1433499699"},
      {"url":"/system/assets/images/000/000/003/original/slider3.jpg?1433499702"},
      {"url":"/system/assets/images/000/000/004/original/slider5.jpg?1433499705"}
    ],
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
