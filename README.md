# Dynamic Trees

Implement Searching in trees

# Task Background

Here are the instructions:
URL: https://random-tree.herokuapp.com/

- Create a RoR application that catches the tree
- Design search function to quickly find Child/Parent nodes

What we expect from the API

- HTTP GET /:tree_id
  - => Return the saved structure
- HTTP GET /:tree_id/parent/:id
  - => Return the list of parents IDs
- HTTP GET /:tree_id/child/:id
  - => Return the list of childs

## Deployed version

https://protected-reaches-35852.herokuapp.com/

## Prerequisite

Make sure that you install `Ruby v2.5`, `MySQL v5.7` and `Redis`

## Development

#### Clone the source

```shell
git clone https://github.com/Maghraby/growthtribe.git
```

#### Installing

Running this command will install all required gems.
```shell
cd growthtribe
bundle install
```

#### Running

```ruby
bin/rails s
```

#### Testing

```shell
rspec
```

###### Note:
Please don't forget to change database and redis configurations from `config/database.yml` and `config/redis.yml` file