import os,csv
import sqlite3

conn = sqlite3.connect('netflix.db')
c = conn.cursor()

# first create the table for movie titles and IDs
with open('../data/movie_titles.txt', 'r') as inputFile:
    inputReader = csv.reader(inputFile, delimiter=',')

    with conn:
        ex = """CREATE TABLE movie_titles (
                MovieID integer,
                year integer,
                title text
                )"""
        c.execute(ex)

    with conn:
        # now add all movies
        for row in inputReader:
            movieID = int(row[0])
            year = int(row[1])
            title = ' '.join(row[2:])

            print('Now processing ', movieID, year, title)

            c.execute("INSERT INTO movie_titles VALUES(:movieID, :year, :title)", {'movieID': movieID, 'year': year, 'title': title})


# now a second table for all ratings
ex = """CREATE TABLE all_rankings (
        MovieID integer,
        UserID integer,
        RateDate DATETIME,
        rating integer
        )"""
c.execute(ex)
conn.commit()

# loop through each file in the current working directory
for csvFilename in os.listdir('../data/training_set'):
    if not csvFilename.endswith('.csv'):
        continue        #skip non-csv files

    print('Processing ' + csvFilename + '...')
    m_id = int(csvFilename[3:-4])


    # Read in the CSV file
    with open("../data/training_set/%s" % csvFilename, 'r') as inputFile:
        inputReader = csv.reader(inputFile, delimiter=',')
        next(inputReader)

        with conn:
            # Process line by line
            for row in inputReader:
                userID, rating, date = int(row[0]), int(row[1]), row[2]
                c.execute("INSERT INTO all_rankings VALUES (:movieID, :userID, :rankdate, :rate)", {'movieID': m_id, 'userID': userID, 'rankdate': date, 'rate': rating})


conn.close()
