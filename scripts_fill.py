import random
import hashlib
from faker import Faker

def generate_powerbi_compatible_city_country():
    # Initialize Faker with multiple locales for diverse city and country generation
    locales = ['en_US', 'en_GB', 'fr_FR', 'de_DE', 'es_ES', 'it_IT', 'nl_NL', 'pt_BR', 'ja_JP', 'zh_CN']
    fake = Faker(locales)
    
    # Generate a random city and country
    city = fake.city()
    country = fake.country()
    
    # Combine the city and country into a single string
    city_country = f"{city}, {country}"
    
    return city_country

def get_random_category():
    categories = [
        "starter",
        "main course",
        "dessert"
    ]
    
    return random.choice(categories)


cities_countries = [
    {"City": "New York", "Country": "USA"},
    {"City": "Los Angeles", "Country": "USA"},
    {"City": "London", "Country": "UK"},
    {"City": "Paris", "Country": "France"},
    {"City": "Berlin", "Country": "Germany"},
    {"City": "Tokyo", "Country": "Japan"},
    {"City": "Sydney", "Country": "Australia"},
    {"City": "Toronto", "Country": "Canada"},
    {"City": "Mumbai", "Country": "India"},
    {"City": "Beijing", "Country": "China"}
]

def get_random_city_country():
    # Select a random city-country pair
    city_country = random.choice(cities_countries)
    # Format the result as a string
    return f"{city_country['City']}, {city_country['Country']}"


from datetime import datetime, timedelta
import random

def get_random_date(start_date, end_date):
    """
    Generate a random date between start_date and end_date.
    
    Args:
    start_date (str): The start date in 'YYYY-MM-DD' format.
    end_date (str): The end date in 'YYYY-MM-DD' format.
    
    Returns:
    str: A random date in 'YYYY-MM-DD' format.
    """
    start_date = datetime.strptime(start_date, '%Y-%m-%d')
    end_date = datetime.strptime(end_date, '%Y-%m-%d')
    
    # Generate a random date between start_date and end_date
    random_date = start_date + timedelta(
        days=random.randint(0, (end_date - start_date).days)
    )
    
    return random_date.strftime('%Y-%m-%d')



def get_random_culinary_type():
    culinary_types = [
        "Italian",
        "Chinese",
        "Mexican",
        "Indian",
        "French",
        "Thai",
        "Japanese",
        "Greek",
        "Spanish",
        "American",
        "Mediterranean",
        "Vietnamese",
        "Turkish",
        "Lebanese",
        "Korean",
        "Brazilian",
        "Moroccan",
        "Caribbean",
        "Ethiopian",
        "German"
    ]
    
    return random.choice(culinary_types)



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
    return 'password ou quoi'

# Generate a random date of birth
def random_date_of_birth(start_year=1990, end_year=2010):
    year = random.randint(start_year, end_year)
    month = random.randint(1, 12)
    day = random.randint(1, 28)  # Simplification, avoiding complexity of month lengths
    return f"{year:04d}-{month:02d}-{day:02d}"

# Generate the SQL insert statements
users_sql = "INSERT INTO user (userid, username, email, DATEBIRTH, ADRESS, biography, isADMIN, PROFILEPICTURE, PASSWORD, ACCOUNTCREATION) VALUES\n"
user_entries = []


post_sql = "INSERT INTO post (IDPOST, USERID, BODY, POSTDATE, SENSIBLE) VALUES\n"
post_entries = []



recipe_sql = "INSERT INTO recipe (IDPOST, TITLE, IMAGE, DIFFICULTY, DURATION, NBPEOPLE, CATEGORY, TYPE) VALUES\n"
recipe_entries = []

comment_sql = "INSERT INTO comment(IDPOST, IDPOST_PARENT) VALUES\n"
comment_entries = []


like_sql = "INSERT INTO likes (USERID, IDPOST, LIKEDATE) VALUES\n"
like_entries = []


save_sql = "INSERT INTO saved(USERID, IDPOST, SAVEDATE) VALUES\n"
save_entries = []


post_id = 1
user_id = 1

today = '2024-06-04'

nbuser = 500
nbpostspuser = 100
nblikeuser = 1000
nbsaveduser = 100

for i in range(1, nbuser+1):
    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    username = f"{first_name.lower()}{last_name.lower()}{i}"
    email = f"{first_name.lower()}@{last_name.lower()}.net"
    date_of_birth = random_date_of_birth()
    location = get_random_city_country()
    biography = random.choice(bios)
    profile_picture = f"{username}.png"
    password = generate_password()
    account_creation = get_random_date(date_of_birth,today)
    user_entries.append(f"('{user_id}','{username}', '{email}', '{date_of_birth}', '{location}', '{biography}', 0, '{profile_picture}', '{password}', '{account_creation}')")
    for y in range(1,nbpostspuser+1):
        post_entries.append(f"('{post_id}', '{user_id}', '{"default body"}', '{get_random_date(account_creation,today)}', '{random.randint(0,1)}')")
        rng = random.randint(1,2)
        if(rng == 1):
            title = "recipe_title" + str(post_id)
            category = get_random_category()
            types = get_random_culinary_type()
            recipe_entries.append(f"('{post_id}', '{title}', '{"default.png"}', '{random.randint(1,10)}', '{random.randint(10,50)}', '{random.randint(1,4)}', '{category}', '{types}')")
        if(rng == 2):
            comment_entries.append(f"('{post_id}', '{random.randint(1,int(nbuser*nbpostspuser*0.9))}')")
        print("added post number : " + str(post_id))
        post_id += 1
        


    list_temp = []
    for z in range(1,nblikeuser+1):

        temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))
        while(temp_id in list_temp):
            temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))

        list_temp.append(temp_id)

        like_entries.append(f"('{user_id}', '{temp_id}', '{get_random_date(account_creation,today)}')")

    list_temp = []
    for a in range(1,nbsaveduser):

        temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))
        while(temp_id in list_temp):
            temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))

        list_temp.append(temp_id)
        save_entries.append(f"('{user_id}', '{temp_id}', '{get_random_date(account_creation,today)}')")

    user_id += 1
    print("added user number : " + str(user_id))







users_sql += ",\n".join(user_entries) + ";\n\n"
post_sql += ",\n".join(post_entries) + ";\n\n"
recipe_sql += ",\n".join(recipe_entries) + ";\n\n"
comment_sql += ",\n".join(comment_entries) + ";\n\n"
like_sql += ",\n".join(like_entries) + ";\n\n"
save_sql += ",\n".join(save_entries) + ";\n\n"


filename = 'letemcook_data.sql'


with open(filename, 'w', encoding='utf-8') as file:
    # Write the SQL content to the file
    file.write(users_sql)
    file.write(post_sql)
    file.write(recipe_sql)
    file.write(comment_sql)
    file.write(like_sql)
    file.write(save_sql)







