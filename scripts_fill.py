import random
from datetime import datetime, timedelta

def get_random_category():
    categories = {
        "starter" : 10,
        "main course" : 55,
        "dessert" : 45
    }

    elem = list(categories.keys())
    weights = list(categories.values())
    
    return random.choices(elem, weights=weights,k = 1)[0]


cities_countries = {
    ("New York", "USA"): 8419000,
    ("Los Angeles", "USA"): 3980000,
    ("Chicago", "USA"): 2716000,
    ("Houston", "USA"): 2328000,
    ("Phoenix", "USA"): 1690000,
    ("Philadelphia", "USA"): 1584000,
    ("San Antonio", "USA"): 1547000,
    ("San Diego", "USA"): 1424000,
    ("Dallas", "USA"): 1340000,
    ("San Jose", "USA"): 1035000,
    ("London", "UK"): 8982000,
    ("Manchester", "UK"): 553230,
    ("Birmingham", "UK"): 1140000,
    ("Glasgow", "UK"): 635640,
    ("Liverpool", "UK"): 494814,
    ("Paris", "France"): 2148000,
    ("Marseille", "France"): 861635,
    ("Lyon", "France"): 513275,
    ("Toulouse", "France"): 471941,
    ("Nice", "France"): 342295,
    ("Berlin", "Germany"): 3645000,
    ("Hamburg", "Germany"): 1841000,
    ("Munich", "Germany"): 1472000,
    ("Cologne", "Germany"): 1086000,
    ("Frankfurt", "Germany"): 753056,
    ("Tokyo", "Japan"): 13929000,
    ("Osaka", "Japan"): 2750000,
    ("Nagoya", "Japan"): 2296000,
    ("Sapporo", "Japan"): 1952000,
    ("Fukuoka", "Japan"): 1620000,
    ("Sydney", "Australia"): 5312000,
    ("Melbourne", "Australia"): 5078000,
    ("Brisbane", "Australia"): 2514000,
    ("Perth", "Australia"): 2059000,
    ("Adelaide", "Australia"): 1345000,
    ("Toronto", "Canada"): 2930000,
    ("Vancouver", "Canada"): 675218,
    ("Montreal", "Canada"): 1780000,
    ("Calgary", "Canada"): 1239000,
    ("Ottawa", "Canada"): 994837,
    ("Mumbai", "India"): 20411000,
    ("Delhi", "India"): 31870000,
    ("Bangalore", "India"): 11847000,
    ("Hyderabad", "India"): 10090000,
    ("Chennai", "India"): 11324000,
    ("Beijing", "China"): 21540000,
    ("Shanghai", "China"): 26320000,
    ("Guangzhou", "China"): 18812000,
    ("Shenzhen", "China"): 17500000,
    ("Chengdu", "China"): 16330000
}

def get_random_city_country():
    elements = list(cities_countries.keys())
    weights = list(cities_countries.values())

    # Select a random city-country pair
    city_country = random.choices(elements, weights=weights, k=1)[0]

    # Format the result as a string
    return f"{city_country[0]}, {city_country[1]}"




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
    culinary_types = {
        "Italian" : 1,
        "Chinese" : 1,
        "Mexican" : 1,
        "Indian" : 1,
        "French" : 1,
        "Thai" : 1,
        "Japanese" : 1,
        "Greek" : 1,
        "German " : 1
    }
    weighted_culinary_types = {key: random.randint(1, 20) for key in culinary_types.keys()}


    culinary_typelist = list(weighted_culinary_types.keys())
    weights = list(weighted_culinary_types.values())
    
    # Use random.choices to select an element based on weights
    chosen_element = random.choices(culinary_typelist, weights=weights, k=1)[0]
        
    return chosen_element




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

follow_sql = "INSERT INTO follows(USERID_FOLLOWER, USERID_FOLLOWED,FOLLOWDATE) VALUES\n"
follow_entries = []


post_id = 1
user_id = 1

#LAST POST ID = 
#LAST USER ID = 501

today = '2024-06-04'

nbuser = 500
nbpostspuser = 100
nblikeuser = 1000
nbsaveduser = 100
nbmaxfollows = 300

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
        post_entries.append(f"('{post_id}', '{user_id}', '{"default body"}', '{get_random_date(account_creation,today)}', '{random.choices([0, 1], weights=[95, 5], k=1)[0]}')")
        rng = random.randint(1,2)
        if(rng == 1):
            title = "recipe_title" + str(post_id)
            category = get_random_category()
            types = get_random_culinary_type()
            recipe_entries.append(f"('{post_id}', '{title}', '{"default.png"}', '{random.randint(0,10)}', '{random.randint(10,50)}', '{random.randint(1,4)}', '{category}', '{types}')")
        if(rng == 2):
            comment_entries.append(f"('{post_id}', '{random.randint(1,int(nbuser*nbpostspuser*0.9))}')")
        print("added post number : " + str(post_id))
        post_id += 1
        


    list_temp = []
    for z in range(1,random.randint(1,nblikeuser+1)):

        temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))
        while(temp_id in list_temp):
            temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))

        list_temp.append(temp_id)

        like_entries.append(f"('{user_id}', '{temp_id}', '{get_random_date(account_creation,today)}')")

    list_temp = []
    for a in range(1,random.randint(1,nbsaveduser)):

        temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))
        while(temp_id in list_temp):
            temp_id = random.randint(1,int(nbuser*nbpostspuser*0.9))

        list_temp.append(temp_id)
        save_entries.append(f"('{user_id}', '{temp_id}', '{get_random_date(account_creation,today)}')")

    

    list_temp = []
    for b in range (1,random.randint(1,nbmaxfollows)):
        temp_id = random.randint(1,nbuser)
        while(temp_id in list_temp):
            temp_id = random.randint(1,int(nbuser))
        list_temp.append(temp_id)
        follow_entries.append(f"('{user_id}', '{temp_id}', '{get_random_date(account_creation,today)}')")


    user_id += 1
    print("added user number : " + str(user_id))







users_sql += ",\n".join(user_entries) + ";\n\n"
post_sql += ",\n".join(post_entries) + ";\n\n"
recipe_sql += ",\n".join(recipe_entries) + ";\n\n"
comment_sql += ",\n".join(comment_entries) + ";\n\n"
like_sql += ",\n".join(like_entries) + ";\n\n"
save_sql += ",\n".join(save_entries) + ";\n\n"
follow_sql += ",\n".join(follow_entries) + ";\n\n"


filename = 'letemcook_data.sql'


with open(filename, 'w', encoding='utf-8') as file:
    # Write the SQL content to the file
    file.write(users_sql)
    file.write(post_sql)
    file.write(recipe_sql)
    file.write(comment_sql)
    file.write(like_sql)
    file.write(save_sql)
    file.write(follow_sql)







