# IOTBEE API documentation


## Project
### Get all project
```sh
# GET /api/projects
```
Output body
```json
{
    "success": true,
    "data": [
        {
            "id": "uuid",
            "created_at": "2022-07-31T11:19:28",
            "updated_at": "2022-07-31T11:19:28",
            "key": "string",
            "name": "string",
            "updated_by": "uuid",
            "created_by": "uuid",
            "description": "string",
        },
    ]
}
```
### Create project
```sh
# POST /api/projects
```
Input body
```json
{
    "id": "uuid",
    "key": "string",
    "name": "string",
    "description": "string",
    "user_id": "uuid",
}
```
Output body
```json
{
    "success": true,
    "data": {
            "id": "uuid",
            "created_at": "2022-07-31T11:19:28",
            "updated_at": "2022-07-31T11:19:28",
            "key": "string",
            "name": "string",
            "updated_by": "uuid",
            "created_by": "uuid",
            "description": "string",
      }
}
```
### Update project
```sh
# PUT /api/projects/<old-key>
```
Input body
```json
{
    "id": "uuid",
    "key": "string",
    "name": "string",
    "created_by": "uuid",
    "description": "string",
    "user_id": "uuid"
}
```
Output body
```json
{
    "success": true,
    "data": {
            "id": "uuid",
            "created_at": "2022-07-31T11:19:28",
            "updated_at": "2022-07-31T11:19:28",
            "key": "string",
            "name": "string",
            "updated_by": "uuid",
            "created_by": "uuid",
            "description": "string",
      }
}
```

## Device
### Get all device
```sh
# GET /api/devices
```
Output body
```json
{
    "success": true,
    "data": [
        {            
            "id": "uuid",
            "project_id": "uuid",
            "key": "string",
            "name": "string",
            "description": "string",
            "json_enable": true,
            "created_at": "2022-07-31T06:40:49",
            "created_by": "uuid",
            "updated_at": "2022-07-31T06:53:23",
            "updated_by": "uuid",
            "json_variables": [
                {
                    "id": "uuid",
                    "name": "string",
                    "json_extraction": "$[0]",
                    "device_id": "uuid",
                },
            ]
        },
    ]
}
```
### Create device
```sh
# POST /api/devices
```
Input body
```json
{            
    "id": "uuid",
    "project_id": "uuid",
    "project_key": "string",
    "key": "string",
    "name": "string",
    "description": "string",
    "json_enable": true,
    "user_id": "uuid",
    "json_variables": [
        {
            "id": "uuid",
            "name": "string",
            "json_extraction": "$[0]",
            "device_id": "uuid",
        },
    ]
},
```
Output body
```
{
    "success": true,
    "data": {            
        "id": "uuid",
        "project_id": "uuid",
        "key": "string",
        "name": "string",
        "description": "string",
        "json_enable": true,
        "created_at": "2022-07-31T06:40:49",
        "created_by": "uuid",
        "updated_at": "2022-07-31T06:53:23",
        "updated_by": "uuid",
        "json_variables": [
            {
                "id": "uuid",
                "name": "string",
                "json_extraction": "$[0]",
                "device_id": "uuid",
            },
        ]
    },    
}
```
### Update device
```sh
# PUT /api/devices/<old-key>
```
Input body
```json
{
    "id": "uuid",
    "key": "string",
    "name": "string",
    "created_by": "uuid",
    "description": "string",
    "project_key": "string",
    "user_id": "uuid"
}
```
Output body
```json
{
    "success": true,
    "data": {
        "id": "uuid",
        "created_at": "2022-07-31T11:19:28",
        "updated_at": "2022-07-31T11:19:28",
        "key": "string",
        "name": "string",
        "updated_by": "uuid",
        "created_by": "uuid",
        "description": "string",
        "json_variables": [
            {
                "id": "uuid",
                "name": "string",
                "json_extraction": "$[0]",
                "device_id": "uuid",
            },
        ]
    }
}
```


## Tile-config
### Get all tile-config
```sh
# GET /api/tile-configs
```
Output body
```json
{
    "success": true,
    "data": [
        {            
            "id": "uuid",
            "name": "string",
            "tile_type": int,
            "device_id": "uuid",
            "tile_data":{
                "prefix": "uuid",
                "postfix": "string",
                "json_variable_id": "uuid",
            },
        },
    ]
}
```
### Create tile-config
```sh
# POST /api/tile-configs
```
Input body
```json
{            
    "id": "uuid",
    "name": "string",
    "tile_type": int,
    "device_id": "uuid",
    "tile_data":{
        "prefix": "uuid",
        "postfix": "string",
        "json_variable_id": "uuid",
    },
}
```
Output body
```json
{
    "success": true,
    "data": 
       {            
        "id": "uuid",
        "name": "string",
        "tile_type": int,
        "device_id": "uuid",
        "tile_data":{
            "prefix": "uuid",
            "postfix": "string",
            "json_variable_id": "uuid",
      },
}
```
### Update tile-config
```sh
# PUT /api/tile-configs
```
Input body
```json
{            
    "id": "uuid",
    "name": "string",
    "tile_type": int,
    "device_id": "uuid",
    "tile_data":{
        "prefix": "uuid",
        "postfix": "string",
        "json_variable_id": "uuid",
    },
}
```
Output body
```json
{
    "success": true,
    "data": {
        "id": "uuid",
        "name": "string",
        "tile_type": int,
        "device_id": "uuid",
        "tile_data": {
            "prefix": "uuid",
            "postfix": "string",
            "json_variable_id": "uuid",
        }
   }
}
```

