Skio client example

To run basic query please open interactive ruby console:

``irb``

and run following commands:

```
require './user.rb'
User.new('illia@geologie.com').call
```

Current result

```
{"errors":[{"extensions":{"path":"$.selectionSet.StorefrontUsers","code":"validation-failed"},"message":"field \"StorefrontUsers\" not found in type: 'query_root'"}]}
```

Expected result - 

```
{
    "data": {
        "StorefrontUsers": [
            {
                "createdAt": "2022-06-22T13:39:47.436629+00:00",
                "email": "illia@geologie.com",
                "firstName": "illia",
                "id": "b5b4eb7f-510b-4de0-a3c9-5cd27a2cbe40",
                "lastName": "kuzma",
                "phoneNumber": "+351965839799",
                "platformId": "gid://shopify/Customer/5743122481200",
                "siteId": "979d36ad-6572-4d07-8d8e-02b45e770995",
                "updatedAt": "2022-07-01T16:15:08.249006+00:00"
            }
        ]
    }
```

You can get expected result by executing next curl request - 

```
curl --location --request POST 'https://graphql.skio.com/v1/graphql' \
--header 'authorization: API a13c52c3-c3bc-41cc-956d-84350a4ce411' \
--header 'Content-Type: application/json' \
--data-raw '{"query":"query StorefrontUsers($distinct_on: [StorefrontUser_select_column!], $limit: Int, $offset: Int, $order_by: [StorefrontUser_order_by!], $where: StorefrontUser_bool_exp) {\n  StorefrontUsers(distinct_on: $distinct_on, limit: $limit, offset: $offset, order_by: $order_by, where: $where) {\n    createdAt\n    email\n    firstName\n    id\n    lastName\n    phoneNumber\n    platformId\n    siteId\n    updatedAt\n  }\n}","variables":{"where":{"email":{"_ilike":"illia@geologie.com"}}}}'
```

Purpose is to get expected result using ruby. It's not required to use
'net/http' gem, basically any solution will be good for us.
