#####################################################################
# Jonathan Dyer
# CS1699: Privacy in the Electronic Society
# Project 3
# 22 April 2018
#
# File:     single_insight_DP.py
# Usage:    python3 single_insight_DP.py
#           Ensure the file database_setup.py has been run first.
# Purpose:  This script demonstrates the differentially-private
#           version of the single_insight.py script.
#
#           Tested using Python 3.5.2
#####################################################################
import os,csv
import sqlite3
import numpy as np

# connect to the database
conn = sqlite3.connect('netflix.db')
c = conn.cursor()

# execute query
with conn:
    ex = """SELECT count(*)
              FROM all_rankings
             WHERE MovieID='1' AND rating='1'"""
    c.execute(ex)

# now retrieve result and perturb with Laplace sampling
res = int(c.fetchone()[0])
eps = np.log(3)     # this is the epsilon value
scale = 1.0/eps     # this is the scale for the laplace distribution
noise = np.random.laplace(scale)
print()
print(res + noise)
print()
conn.close()
