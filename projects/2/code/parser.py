import sys
import xml.etree.ElementTree as ET

#
# tree = ET.parse('country_data.xml')
# root = tree.getroot()


def heading(str):
    print('-'*60)
    print("** %s:" % (str,))
    print('-'*60, '\n')

SHOW_CMD = True
def print_cmd(cmd):
    if SHOW_CMD:
        print(cmd.decode('utf-8'))

def print_rows(rows):
    for row in rows:
        print(row)

#------------------------------------------------------------
# show_menu
#------------------------------------------------------------

# 2. Show user
# 3. New user
# ---
# 4. Show friends
# 5. Add friend
# ---
# 6. Show messages
# 7. Post message

def show_menu():
    menu = '''

--------------------------------------------------
1. List users


Choose (1, 0 to quit): '''

    try:
        choice = int(input( menu ))
    except ValueError:
        print("\n\n* Invalid choice. Choose again.")
        show_menu()
    else:
        if choice == 0:
            print('Done.')
            cur.close()
            conn.close()
        elif choice in range(1,1+7):
            print()
            actions[choice]()
            show_menu()
        else:
            print("\n\n* Invalid choice (%s). Choose again." % choice)
            show_menu()
    finally:
        if cur != None:
            cur.close()
        if conn != None:
            conn.close()

#------------------------------------------------------------
# list_users
#------------------------------------------------------------

def list_users_menu():
    heading('List Users:')
    list_users()

def list_users():
    tmpl = '''
        SELECT *
          FROM Users as u;
    '''
    cmd = cur.mogrify(tmpl)
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    print_rows(rows)
    print()
    for row in rows:
        id, first, last, email = row
        print("%s. %s, %s (%s)" % (id, last, first, email))

#-----------------------------------------------------------------
# show_user
#-----------------------------------------------------------------

def show_user_menu():
    heading("Show User(s):")
    name = input('User name: ')
    show_user(name)

def show_user(name):
    tmpl = '''
        SELECT *
          FROM Users as u
         -- ILIKE is a case insensitive LIKE
         WHERE (first_name ILIKE %s ) or (last_name ILIKE %s );
    '''
    cmd = cur.mogrify(tmpl, ('%'+name+'%', '%'+name+'%'))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    print_rows(rows)
    print()
    for row in rows:
        id, first, last, email = row
        print("%s. %s, %s (%s)" % (id, last, first, email))


def show_user_by_id(id):
    pass

#-----------------------------------------------------------------
# new_user
#-----------------------------------------------------------------

def new_user_menu():
    heading("new_user")
    fname = input('First name: ')
    lname = input('Last name: ')
    email = input('Email: ')
    new_user(first_name=fname, last_name=lname, email=email)

def new_user(first_name, last_name, email):
    tmpl = '''
        INSERT INTO Users (first_name,last_name,email)
                   VALUES (%s,%s,%s);
    '''
    cmd = cur.mogrify(tmpl, (first_name,last_name,email))
    print_cmd(cmd)
    cur.execute(cmd)
    list_users()

#-----------------------------------------------------------------
# show_friends
#-----------------------------------------------------------------

def show_friends_menu():
    heading("Show friends")
    uid = input("User id: ")
    show_friends(uid)

def show_friends(uid):
    tmpl = '''
        SELECT *
          FROM Users as u
         WHERE u.uid IN (SELECT f.uid_2
                           FROM Friends as f
                          WHERE f.uid_1=%s);
    '''
    cmd = cur.mogrify(tmpl, uid)
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    print_rows(rows)
    print()
    for row in rows:
        id, first, last, email = row
        print("%s. %s, %s (%s)" % (id, last, first, email))

#-----------------------------------------------------------------
# add_friend
#-----------------------------------------------------------------

def add_friend_menu():
    print("add_friend")
    uid_1 = input("Uid_1: ")
    uid_2 = input("Uid_2: ")
    add_friend(uid_1, uid_2)

def add_friend(uid_1,uid_2):
    tmpl = '''
        INSERT INTO Friends(uid_1,uid_2)
                     VALUES(%s,%s);
    '''
    cmd = cur.mogrify(tmpl, (uid_1,uid_2))
    print_cmd(cmd)
    cur.execute(cmd)

    tmpl = '''
        INSERT INTO Friends(uid_1,uid_2)
                     VALUES(%s,%s);
    '''
    cmd = cur.mogrify(tmpl, (uid_2,uid_1))
    print_cmd(cmd)
    cur.execute(cmd)

#-----------------------------------------------------------------
# show messages
#-----------------------------------------------------------------

def show_messages_menu():
    heading("show_messages")
    uid = input("User id: ")
    show_messages(uid)

def show_messages(uid):
    tmpl = '''
        SELECT *
          FROM Messages as m
         WHERE m.posted_to = %s or m.posted_by = %s;
    '''
    cmd = cur.mogrify(tmpl, ( uid, uid))
    print_cmd(cmd)
    cur.execute(cmd)
    rows = cur.fetchall()
    print_rows(rows)
    print()
    for row in rows:
        id, p_to, p_by, message, date = row
        print("%s. %s <-- %s | %s (%s)" % (id, p_to, p_by, message, date))



#-----------------------------------------------------------------
# post message
#-----------------------------------------------------------------

def post_message_menu():
    heading("post_message")
    posted_by = input('Posted by: ')
    posted_to = input("Posted to: ")
    message = input('Message: ')
    post_message(posted_by=posted_by, posted_to=posted_to, message=message)

def post_message(posted_by, posted_to, message):
    tmpl = '''
        INSERT INTO Messages(posted_by,posted_to,message)
                      VALUES(%s,%s,%s);
    '''
    cmd = cur.mogrify(tmpl, (posted_by,posted_to,message))
    print_cmd(cmd)
    cur.execute(cmd)


# We leverage the fact that in Python functions are first class
# objects and build a dictionary of functions numerically indexed

actions = { 1:list_users_menu,    2:show_user_menu,   3:new_user_menu,
            4:show_friends_menu,  5:add_friend_menu,
            6:show_messages_menu, 7:post_message_menu }


if __name__ == '__main__':
    try:
        # default database and user
        db, user, password, host = 'a5_socnet', 'itlab17', 'itlab', '/var/run/postgresql/'
        # you may have to adjust the user
        # python a4-socnet-sraja.py a4_socnet postgres
        if len(sys.argv) >= 2:
            db = sys.argv[1]
        if len(sys.argv) >= 3:
            user = sys.argv[2]
        # by assigning to conn and cur here they become
        # global variables.  Hence they are not passed
        # into the various SQL interface functions
        conn = psycopg2.connect(database=db, user=user, password=password, host=host)
        conn.autocommit = True
        cur = conn.cursor()
        show_menu()
    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))
