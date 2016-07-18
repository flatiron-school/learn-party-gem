# LearnTogether

This gem is meant to be used to group Learn student batches into groups for tables, labs and projects. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'learn_together'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install learn_together

## Usage

The Learn Together gem is meant to be used from within another project, like a Rails app. The gem can take in any collection of student-like objects, along with a few specifications, and generate groups of students accordingly. 

#### What's a 'student-like object?'

The Learn Together gem can take in a collection of objects that respond to a `#completed_lesson_count_for_active_track` method *or* a collection of hashes, each of which has a key of `:completed_lesson_count_for_active_track`.

This is because the gem can generate groups based on similar progress. The gem uses the total number of completed lessons for a given student's active track as a metric with which to measure progress and thereby sort students. 

#### These student-like objects sound great! Where can I get some?

You can hit this Learn API endpoint for your batch to retrieve a JSON payload describing Learn students. 

```bash
GET http://leanr.co.api/batches/:batch_id/users
```

The payload for each student will include an attribute, `"completed_lesson_count_for_active_track"`. You can either use this data to instantiate `Student` objects of your own, OR, you can simply `JSON.parse` the payload, and pass student-like hashes to the gem.

*Important:* If you give the gem a collection of student objects, instantiated from student class you yourself defined, then the gem will return to you groups of these student objects. If you give the gem a collection of hashes, each of which describe a student, the gem will return to you groups of these student hashes, sorted/grouped accordingly.

#### Using the Gem

Once you have your student collection, you can call the gem with a number of different arguments. 

**Student groups with n number of students, based on progress**

```ruby
LearnTogether::GroupMaker.new.run(collection: <collection of student-like objects>, groups_of: some_number, sort_type: "progress")
```

For example:

```ruby
students = Student.all # assuming you have a database full of students with the necessary .completed_lesson_for_active_track attribute

LearnTogether::GroupMaker.new.run(collection: students, groups_of: 2, sort_type: "progress")
```

returns:

```ruby
[[#<Student:0x007fc0a1344450
   @completed_lesson_count_for_active_track=1,
   @first_name=nil,
   @github_username="destany-wintheiser",
   @last_name=nil>,
  #<Student:0x007fc0a1344810
   @completed_lesson_count_for_active_track=1,
   @first_name=nil,
   @github_username="rowena-larson",
   @last_name=nil>],
 [#<Student:0x007fc0a1344608
   @completed_lesson_count_for_active_track=2, 
   @first_name=nil, @github_username="nakia", @last_name=nil>,
  #<Student:0x007fc0a1344798
   @completed_lesson_count_for_active_track=3,
   @first_name=nil,
   @github_username="fletcher-fisher",
   @last_name=nil>],
 [#<Student:0x007fc0a13446f8
   @completed_lesson_count_for_active_track=3,
   @first_name=nil,
   @github_username="francesca-bashirian",
   @last_name=nil>,
  #<Student:0x007fc0a13448b0 
   @completed_lesson_count_for_active_track=3,  
   @first_name=nil, 
   @github_username="meaghan", @last_name=nil>],
 [#<Student:0x007fc0a1344c20 
   @completed_lesson_count_for_active_track=4, 
   @first_name=nil, @github_username="keeley", 
   @last_name=nil>,
  #<Student:0x007fc0a1344478 
   @completed_lesson_count_for_active_track=4, 
   @first_name=nil, 
   @github_username="german", @last_name=nil>],
 [#<Student:0x007fc0a13447e8
   @completed_lesson_count_for_active_track=4,
   @first_name=nil,
   @github_username="eleazar-beatty",
   @last_name=nil>,
  #<Student:0x007fc0a1344950 
   @completed_lesson_count_for_active_track=4, 
   @first_name=nil, @github_username="ivy", @last_name=nil>],
 [#<Student:0x007fc0a13449f0 
   @completed_lesson_count_for_active_track=4, 
   @first_name=nil, @github_username="ernestina", 
   @last_name=nil>,
  #<Student:0x007fc0a1344bf8 
   @completed_lesson_count_for_active_track=5, 
   @first_name=nil, @github_username="erling", 
   @last_name=nil>],
 [#<Student:0x007fc0a1344a40 
   @completed_lesson_count_for_active_track=5, 
   @first_name=nil, @github_username="heloise-toy", 
   @last_name=nil>,
  #<Student:0x007fc0a13449a0
   @completed_lesson_count_for_active_track=5,
   @first_name=nil,
   @github_username="quinten-botsford",
   @last_name=nil>],
 [#<Student:0x007fc0a13444c8
   @completed_lesson_count_for_active_track=6,
   @first_name=nil,
   @github_username="janick-feeney",
   @last_name=nil>,
  #<Student:0x007fc0a13446d0
   @completed_lesson_count_for_active_track=6,
   @first_name=nil,
   @github_username="trevor-mcclure",
   @last_name=nil>],
 [#<Student:0x007fc0a1344748 
   @completed_lesson_count_for_active_track=7, 
   @first_name=nil, @github_username="maxie-price", 
   @last_name=nil>,
  #<Student:0x007fc0a1344b30
   @completed_lesson_count_for_active_track=7,
   @first_name=nil,
   @github_username="mable-luettgen",
   @last_name=nil>],
 [#<Student:0x007fc0a13449c8
   @completed_lesson_count_for_active_track=7,
   @first_name=nil,
   @github_username="jailyn-okeefe",
   @last_name=nil>,
  #<Student:0x007fc0a1344978 
   @completed_lesson_count_for_active_track=7, 
   @first_name=nil, @github_username="yvonne", 
   @last_name=nil>],
 [#<Student:0x007fc0a1344888 
   @completed_lesson_count_for_active_track=7, 
   @first_name=nil, @github_username="bobby",
   @last_name=nil>,
  #<Student:0x007fc0a13444f0 
   @completed_lesson_count_for_active_track=7, 
   @first_name=nil, @github_username="jerrold", 
   @last_name=nil>],
 [#<Student:0x007fc0a1344590 
   @completed_lesson_count_for_active_track=7, 
   @first_name=nil, @github_username="vivianne", 
   @last_name=nil>,
  #<Student:0x007fc0a1344428
   @completed_lesson_count_for_active_track=8,
   @first_name=nil,
   @github_username="jaden-wintheiser",
   @last_name=nil>],
 [#<Student:0x007fc0a1344b80 
   @completed_lesson_count_for_active_track=8, 
   @first_name=nil, @github_username="obie", @last_name=nil>,
  #<Student:0x007fc0a1344860 
   @completed_lesson_count_for_active_track=8, 
   @first_name=nil, @github_username="sydnie", 
   @last_name=nil>],
 [#<Student:0x007fc0a1344770
   @completed_lesson_count_for_active_track=8,
   @first_name=nil,
   @github_username="evelyn-corkery",
   @last_name=nil>,
  #<Student:0x007fc0a1344518 
   @completed_lesson_count_for_active_track=8, 
   @first_name=nil, @github_username="ashley", 
   @last_name=nil>],
 [#<Student:0x007fc0a1344900 
   @completed_lesson_count_for_active_track=9, 
   @first_name=nil, @github_username="carey", @last_name=nil>,
  #<Student:0x007fc0a1344838
   @completed_lesson_count_for_active_track=9,
   @first_name=nil,
   @github_username="rosina-carter",
   @last_name=nil>],
 [#<Student:0x007fc0a1344a18
   @completed_lesson_count_for_active_track=9,
   @first_name=nil,
   @github_username="mose-nikolaus",
   @last_name=nil>,
  #<Student:0x007fc0a1344720
   @completed_lesson_count_for_active_track=10,
   @first_name=nil,
   @github_username="aurore-feeney",
   @last_name=nil>],
 [#<Student:0x007fc0a1344928
   @completed_lesson_count_for_active_track=10,
   @first_name=nil,
   @github_username="maurice-collier",
   @last_name=nil>,
  #<Student:0x007fc0a1344b58
   @completed_lesson_count_for_active_track=10,
   @first_name=nil,
   @github_username="valentin-langworth",
   @last_name=nil>,
  #<Student:0x007fc0a13445b8 
   @completed_lesson_count_for_active_track=10, 
   @first_name=nil, @github_username="andreanne", 
   @last_name=nil>]
]
```

We can see that the return of the `#run` method is an array of arrays, in which each child array represents one group of students and contains the list of the students in that group. In this case, we assume the original student collection contained 35 students. So, `#run` returned an array of 17 arrays, each of which contains two students, except for the last one, which contains 3 students. 

**Student groups with n number of students, sorted randomly**

```ruby
LearnTogether::GroupMaker.new.run(collection: <collection of student-like objects>, groups_of: some_number, sort_type: "random")
```

For example:

```ruby
students = Student.all # assuming you have a database full of students with the necessary .completed_lesson_for_active_track attribute

LearnTogether::GroupMaker.new.run(collection: students, groups_of: 3, sort_type: "random")
```

**Students into n number of groups**

```ruby
LearnTogether::GroupMaker.new.run(collection: <collection of student-like objects>, number_of_groups: 3)
```

This will return an array of three smaller arrays, each of which contains the appropriate number of students. 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

