Airport
=======

### Makers Academy Week 3 - Test

This test was set by Enrique Comba Riepenhausen
[@ecomba](http://twitter.com/ecomba) and Alex Peattie
[@alexpeattie](https://twitter.com/alexpeattie) whilst learning to code at
[Makers Academy](http://www.makersacademy.com). The aim was to build an
object oriented model of airports and planes in Ruby.

I wrote this code alone using RSpec for TDD. I started by writing the CRC
cards (shown below). The primary aim of this test was to write clean, simple,
readable code. I think the closest I came to this aim was in my Airport class:

```ruby
def clear_to_land?
has_space_in_hanger? and has_sunny_weather_and_no_bomb_scare?
end
```

#### Class Weather

| Responsibilities            | Collaborators |
| :-------------------------- | :------------ |
| can be sunny or stormy      | Airport       |                   
| can switch state at random  |               |

#### Class Plane

| Responsibilities                                    | Collaborators |
| :-------------------------------------------------- | :------------ |
| can land at an Airport, if clear to land            | Airport       |
| can take off from an Airport, if clear to take off  |               |

#### Class Airport

| Responsibilities                             | Collaborators |
| :------------------------------------------- | :------------ |
| has a maximum capacity of Planes             | Plane         |
| has a collection of Planes                   | Weather       |
| has its own Weather                          |               |
| can have a bomb scare                        |               |
| can call off a bomb scare                    |               |
| can be clear for take offs and landings      |               |
| (i.e. has space, not stormy, no bomb scare)  |               |
