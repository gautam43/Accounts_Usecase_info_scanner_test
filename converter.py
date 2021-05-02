import pandas as pd

df=pd.read_csv("output.txt", header = None)

df.columns = ['State', 'BillNo', 'TaxAmt']

df.to_csv('output.csv', index = None )



