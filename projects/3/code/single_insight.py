#####################################################################
# Jonathan Dyer
# CS1699: Privacy in the Electronic Society
# Project 3
# 22 April 2018
#
# File:     single_insight.py
# Usage:    python3 single_insight.py
#           Ensure the file database_setup.py has been run first.
# Purpose:  This script utilizes the database generated from
#           Netflix data to find out how many people gave the
#           movie 'Dinosaur Planet' a rating of 1 star.
#
#           Tested using Python 3.5.2
#####################################################################
import os,csv
import sqlite3

# connect to the database
conn = sqlite3.connect('netflix.db')
c = conn.cursor()

with conn:
    ex = """SELECT count(*)
              FROM all_rankings
             WHERE MovieID='1' AND rating='1'"""
    c.execute(ex)

print(c.fetchone()[0])

conn.close()
