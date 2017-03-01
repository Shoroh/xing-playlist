# How to use

* Run 'bundle install'
* Create database.yml with your credentials 
* Run 'rake db:create'
* Run 'rake db:migrate'
* Run 'rake db:seed'
* Run server & test via 'bundle exec guard'

# Import custom data from CSV files*

\* — Could be a relative path to csv file inside Rails.root 

### Import Users

```ruby
rake "import:users[the_task/csv/user_data.csv]"
```

### Import Songs

```ruby
rake "import:songs[the_task/csv/mp3_data.csv]"
```

### Import Playlists

```ruby
rake "import:playlists[the_task/csv/playlist_data.csv]"
```

### Import everything like a boss

```ruby
bundle exec rake db:seed
```
