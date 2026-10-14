class_name Date
extends RefCounted

var day: int
var month: int
var year: int

const SUNDAY: int = 0
const MONDAY: int = 1
const TUESDAY: int = 2
const WEDNESDAY: int = 3
const THURSDAY: int = 4
const FRIDAY: int = 5
const SATURDAY: int = 6


# Constructor equivalent to public Date(int m, int d, int y)
func _init(m: int, d: int, y: int) -> void:
	month = m
	day = d
	year = y


func get_day() -> int:
	return day


func get_month() -> int:
	return month


func get_year() -> int:
	return year


# Equivalent to toString()
func _to_string() -> String:
	return "%d/%d/%d" % [month, day, year]


func equals(other: Date) -> bool:
	var my_month: int = get_month()
	var other_month: int = other.get_month()
	var my_year: int = get_year()
	var other_year: int = other.get_year()
	var my_day: int = get_day()
	var other_day: int = other.get_day()

	if my_month == other_month and my_year == other_year and my_day == other_day:
		return true
	else:
		return false


func compare_to(other: Date) -> int:
	if get_year() > other.get_year():
		return 1
	elif get_year() < other.get_year():
		return -1
	elif get_month() > other.get_month():
		return 1
	elif get_month() < other.get_month():
		return -1
	elif get_day() > other.get_day():
		return 1
	elif get_day() < other.get_day():
		return -1
	else:
		return 0


func is_a_leap_year() -> bool:
	var current_year: int = get_year()

	if current_year % 100 != 0:
		if current_year % 4 == 0:
			return true
	elif current_year % 400 == 0:
		return true

	return false


func num_days_in_month() -> int:
	var current_month: int = get_month()

	if (
		current_month == 1 or
		current_month == 3 or
		current_month == 5 or
		current_month == 7 or
		current_month == 8 or
		current_month == 10 or
		current_month == 12
	):
		return 31
	elif current_month == 4 or current_month == 6 or current_month == 9 or current_month == 11:
		return 30
	elif current_month == 2:
		if is_a_leap_year():
			return 29
		else:
			return 28
	else:
		return -1


func increment_day() -> void:
	day += 1
	if get_day() > num_days_in_month():
		day = 1
		month += 1
	if month > 12:
		year += 1
		month = 1


func month_string() -> String:
	var months: Array[String] = [
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	]
	return months[get_month() - 1]


func day_string() -> String:
	var current_day: int = get_day()
	if current_day / 10 == 1:
		return "%dth" % current_day

	if current_day % 10 == 1:
		return "%dst" % current_day
	elif current_day % 10 == 2:
		return "%dnd" % current_day
	elif current_day % 10 == 3:
		return "%drd" % current_day
	return "%dth" % current_day


func fancy_date() -> String:
	return "%s, %s %s, %d" % [day_of_week_string(), month_string(), day_string(), year]


func day_of_year() -> int:
	var total: int = 0
	var const_month: int = get_month()
	for i in range(1, const_month):
		month = i
		total += num_days_in_month()
	total += day
	month = const_month
	return total


func day_of_week_int() -> int:
	var first_two: int = year / 100.0
	var century_start: int = 7 - 2 * (first_two % 4)
	if century_start == 7:
		century_start -= 1

	var last_two: int = year % 100
	var year_shift: int = last_two + int((last_two - 1) / 4.0)

	if first_two % 4 == 0 and last_two != 0:
		year_shift += 1

	var day_shift: int = day_of_year() - 1
	return (century_start + year_shift + day_shift) % 7


func day_of_week_string() -> String:
	var weekday: int = day_of_week_int()
	match weekday:
		SUNDAY:
			return "Sunday"
		MONDAY:
			return "Monday"
		TUESDAY:
			return "Tuesday"
		WEDNESDAY:
			return "Wednesday"
		THURSDAY:
			return "Thursday"
		FRIDAY:
			return "Friday"
		SATURDAY:
			return "Saturday"
	return ""