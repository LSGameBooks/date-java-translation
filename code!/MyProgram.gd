class_name MyProgram
extends Node


# Advances the date until it hits Saturday (day index 6)
static func working_for_the_weekend(d: Date) -> void:
	while d.day_of_week_int() != Date.SATURDAY:
		d.increment_day()


# _ready() serves as the entry point when the node runs in Godot (similar to main())
func _ready() -> void:
	main()


static func main() -> void:
	var dates: Array[Date] = [
		Date.new(7, 4, 1776),
		Date.new(12, 7, 1941),
		Date.new(12, 31, 1999),
		Date.new(1, 1, 2000),
		Date.new(2, 22, 1983)
	]

	for my_date in dates:
		print("Before: " + my_date.fancy_date())

		working_for_the_weekend(my_date)

		print("After:  " + my_date.fancy_date())
		print()
