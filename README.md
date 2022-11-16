# Eat and Educate
>

![ruby-image]

A rails back-end REST API. Eat and Educate allows a front-end app to find recipes from a country, and combine them with informative videos and images from that country. Also implements secure registration so users can favorite recipes. Created in a five day sprint.

Created with Rails 5.2.8

Reach out to me on [Linkedin](https://www.linkedin.com/in/gavin-carew-6476748a/) or  [Github](https://github.com/gjcarew) 

## <a name="contents"></a> Table of contents
- [Database setup](#database-setup)
- [Endpoints](#endpoints)
  - [Get recipes from a country](#get-recipes)
  - [Get learning resources from a country](#get-resources)
  - [Register a new user](#register)
  - [User login](#login)
  - [User logout](#logout)
  - [Add a new favorite recipe](#new-favorite)
  - [Get a user's favorites](#favorites)
  - [Delete a user's favorites](#delete-favorite)

## <a name="database-setup"></a>Database Setup

Fork and clone the project, then install the required gems with `bundle`. 

```sh
bundle install
```

Reset and seed the database: 

```sh
rake db:{drop,create,migrate,seed}
```
You will need to create API keys to run this back-end server. You will need the following keys: 
- [Edamam](https://www.edamam.com/)
- [Youtube Data API](https://developers.google.com/youtube/v3)
- [Unsplash](https://unsplash.com/documentation#creating-a-developer-account)
- [Geoapify Places](https://apidocs.geoapify.com/playground/places/)

Once you have your keys, set up your environment with 
```sh
bundle exec figaro install
```
 Then add your keys to `config/application.yml`:
```ruby
RECIPE_KEY: <YOUR_EDAMAM_KEY>

VIDEO_KEY: <YOUR_YOUTUBE_KEY>

IMAGE_KEY: <YOUR_UNSPLASH_KEY>

PLACES_KEY: <YOUR_PLACES_KEY>
```
Start a rails server, and you're ready to query 
```sh
rails s
```

# <a name="endpoints"></a>Endpoints

## <a name="get-recipes"></a> GET /api/v1/recipes
[Back to top](#contents)

Gets recipes from a single country.

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **country** | Optional - specify a country       | query   | String        |

   *If no country parameter is included, recipes for a random country will be returned* 

**Sample response (status 200)**
 ```json
 {
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/611/611..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "THAI COCONUT CREMES",
                "url": "https://food52.com/recipes/37220-thai-coconut-cremes",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/8cd/8c..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Sriracha",
                "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/web-img/cb5..."
            }
        }
    ]
 }
 ```
---
 ## <a name="get-resources"></a>GET /api/v1/learning_resources
 [Back to top](#contents)

Gets learning resources from a single country.

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **country** | Optional       | query   | String        |


**Sample response (status 200)**
 ```json
{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "time lapse photography of flying hot air balloon",
                    "url": "https://images.unsplash.com/photo-154..."
                },
                {
                    "alt_tag": "aerial view of city at daytime",
                    "url": "https://images.unsplash.com/photo-157..."
                }
            ]
        }
    }
 }
 ```
---
 ## POST <a name="register"></a>/api/v1/users
 [Back to top](#contents)

Register a new user. For this endpoint, all parameters are required.

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **name** | User name       | body   | String        |
   | **email** | User email must be unique  | body   | String        |
   | **password** | Secure password required       | body   | String        |
   | **password_confirmation** | Must match password    | body   | String        |


**Sample response (status 201)**
 ```json
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "name": "Athena Dao",
            "email": "athenadao@bestgirlever.com",
            "api_key": "58ec6581e4ce87b5b154332c7bbd6b1c"
        }
    }
}
 ```
---
 ## POST <a name="login"></a>/api/v1/sessions
 [Back to top](#contents)

User login. For this endpoint, all parameters are required.

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **email** | User email  | body   | String        |
   | **password** | User password      | body   | String        |

**Sample response (status 201)**
 ```json
{
    "data": {
        "id": "3",
        "type": "user",
        "attributes": {
            "name": "Athena Dao",
            "email": "athenadao@bestgirlever.com",
            "api_key": "58ec6581e4ce87b5b154332c7bbd6b1c"
        }
    }
}
 ```
 ---
  ## <a name="logout"></a>DELETE /api/v1/sessions
 [Back to top](#contents)

Logs a user out/ ends their session.

A successful response will return return a `204 No Content` status code.

---

 ## <a name="new-favorite"></a>POST /api/v1/favorites
 [Back to top](#contents)

Add a new favorite recipe. For this endpoint, all parameters are required.

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **country** | Country of origin | body   | String        |
   | **recipe_link** | Link to recipe  | body   | String        |
   | **recipe_title** | Secure password required       | body   | String        |
   | **api_key** | Must match a user's API key    | body   | String        |


**Sample response (status 201)**
 ```json

{
    "success": "Favorite added successfully"
}

 ```
---
 ## <a name="favorites"></a>GET /api/v1/favorites
 [Back to top](#contents)

Get a user's favorites

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **api_key** | Must match a user's API key    | query   | String        |

**Sample response (status 200)**
 ```json
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "recipe title",
                "recipe_link": "recipe url",
                "country": "Benin",
                "created_at": "2022-11-15T17:44:49.306Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "another_url",
                "recipe_link": "some_url",
                "country": "France",
                "created_at": "2022-11-15T21:54:59.105Z"
            }
        }
    ]
}
 ```
---
 ## <a name="delete-favorite"></a>DELETE /api/v1/favorites
 [Back to top](#contents)

Delete one of the user's favorited recipes.

   | Parameter      | Description | Parameter type      | Data type |
   | ----------- | ----------- | ----------- | ----------- |
   | **api_key** | User's API key | query   | String        |
   | **id** | The primary key of the favorite to be deleted  | query   | Integer        |

A successful response will return return a `204 No Content` status code.




<!-- Markdown link & img dfn's -->
[ruby-image]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white

