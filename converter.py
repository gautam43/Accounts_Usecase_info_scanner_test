import pandas as pd

df=pd.read_csv("/var/lib/jenkins/workspace/Extractor-Runquery/output.txt", header = None)

df.columns = ['State', 'BillNo', 'TaxAmt']

df.to_csv('output.csv', index = None )



