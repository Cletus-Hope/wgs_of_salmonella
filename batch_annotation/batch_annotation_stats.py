import pandas as pd
import sys
import glob
import os

maindir = sys.argv[1]
allfiles = glob.glob('%s/*/*.tsv' % maindir)

# Sort files based on their base names
allfiles.sort(key=lambda x: os.path.splitext(os.path.basename(x))[0])

maindf = []

for file_ in allfiles:
    bname = os.path.splitext(os.path.basename(file_))[0]
    print(bname)

    df = pd.read_csv(file_, sep='\t')
    featurecounts = df['ftype'].value_counts()
    print(featurecounts)
    
    res = pd.DataFrame(featurecounts)
    res.columns = [bname]  # Correctly set the column name to the sample ID
    maindf.append(res)

out = pd.concat(maindf, axis=1)
out.to_csv('prokka_summary.csv')

