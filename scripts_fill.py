import random
import hashlib

# List of sample first names and last names
first_names = ["John", "Jane", "Alex", "Emily", "Chris", "Katie", "Michael", "Sarah", "David", "Laura"]
last_names = ["Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Martinez", "Hernandez"]

# Random biographies
bios = [
    "Loves cooking and experimenting with new recipes.",
    "Avid foodie and home chef.",
    "Enjoys baking and sharing treats with friends.",
    "Passionate about healthy eating and fitness.",
    "Culinary school graduate with a love for gourmet meals.",
    "Amateur chef with a knack for BBQ.",
    "Always looking for the next great recipe.",
    "Enjoys making meals for family and friends.",
    "Food blogger and recipe developer.",
    "Loves trying out new kitchen gadgets and techniques."
]

# Generate a random password (hashed for security)
def generate_password():
    password = ''.join(random.choices('abcdefghijklmnopqrstuvwxyz0123456789', k=10))
    return hashlib.sha256(password.encode()).hexdigest()

# Generate a random date of birth
def random_date_of_birth(start_year=1990, end_year=2010):
    year = random.randint(start_year, end_year)
    month = random.randint(1, 12)
    day = random.randint(1, 28)  # Simplification, avoiding complexity of month lengths
    return f"{year:04d}-{month:02d}-{day:02d}"

# Generate the SQL insert statements
users_sql = "INSERT INTO user (username, email, DATEBIRTH, ADRESS, biography, isADMIN, PROFILEPICTURE, PASSWORD) VALUES\n"
user_entries = []

//CREATE TABLE `user` (
  `USERNAME` char(50) DEFAULT NULL,
  `USERID` int(2) NOT NULL,
  `EMAIL` char(50) DEFAULT NULL,
  `PASSWORD` char(50) DEFAULT NULL,
  `ACCOUNTCREATION` date DEFAULT current_timestamp(),
  `PROFILEPICTURE` char(50) DEFAULT 'default.png',
  `BIOGRAPHY` text DEFAULT NULL,
  `DATEBIRTH` date DEFAULT NULL,
  `ADRESS` char(50) DEFAULT NULL,
  `ISADMIN` tinyint(1) DEFAULT 0
)


for i in range(1, 101):
    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    username = f"{first_name.lower()}{last_name.lower()}{i}"
    email = f"{first_name.lower()}@{last_name.lower()}.net"
    date_of_birth = random_date_of_birth()
    location = f"City{random.randint(1, 100)}"
    biography = random.choice(bios)
    profile_picture = f"{username}.png"
    password = generate_password()
    user_entries.append(f"('{username}', '{email}', '{date_of_birth}', '{location}', '{biography}', 0, '{profile_picture}', '{password}')")

users_sql += ",\n".join(user_entries) + ";\n\n"





print(users_sql)