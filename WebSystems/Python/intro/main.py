import math
#variables
first_name = 'Byrone'

# print(f"Hello {first_name}")

is_student = True

#if-statement

# if is_student:
    # print("You are a student")
# else:
    # print("You are not a student")

#type-casting

name = "Byrone Kingsly"
age = 20
gpa = 3.2

#type-cast from float to int

gpa = int(gpa)

# print(gpa)

#checkin type of variable
# print(type(name))

# Prompting input values and displaying the value

# names = input("What is your name? ")

# print(f"Hello, {names}")

# Area of a rectangle from user input exercise
#
# length = int(input("Length of rectangle: "))
#
# width = int(input("Width of rectangle: "))
#
# print(f"Area of rectangle: {length * width}cm")

# Incrementing and decrementing
friends = 0
# incrementing
friends+= 1

# decrementing
friends-= 1

# Circumference of a circle

# radius = float(input("Enter Radius of circle: "))

# circumference = 2 * math.pi * radius
#
# print(f"Circumference of circle of radius {radius} is : {circumference}")

# Area of a circle

# radius = float(input("Enter Radius of circle: "))
#
# area = math.pi * math.pow(radius, 2)
#
# print(f"Area of circle of radius {radius} is {area}: ")


# Hypotenuse of a right-angled triangle


height = float(input("Enter  height : "))

base = float(input("Enter  base : "))

hypotenuse = math.sqrt(math.pow(base,2)+math.pow(height,2))

print(f"The hypotenuse of right-angled triangle of base {base} and height {height} is {hypotenuse}")
