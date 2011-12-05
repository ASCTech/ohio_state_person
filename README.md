# ohio_state_person

[Gem page](https://rubygems.org/gems/ohio_state_person)


## Description

This is an extraction of the common user model code in our Rails apps.


## Synopsis

```ruby
class Student < ActiveRecord::Base
  is_a_buckeye
end
```


## Features

It validates the format and uniqueness of ```name_n``` and ```emplid```.

It sets the ```id``` of new records to ```emplid.to_i```, and validates that the ```id``` is always ```emplid.to_i```.

It adds a class method: ```search```, which searches by ```emplid```, ```name_n```, ```last_name, first_name```, ```first_name last_name```, or just ```last_name```, depending on whether the search term looks like an emplid, name_n, etc.

It adds an instance method: ```email```, which is just ```"#{name_n}@osu.edu"```.


## Usage

Just call ```is_a_buckeye``` from the class level in your model.  This mixin expects ```emplid```, ```name_n```, ```first_name```, and ```last_name``` to be attributes of the model in question.
