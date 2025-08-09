import os
import re
import pandas as pd

def extract_files(basedir, output_file):
    """
    Extract BUSCO summary statistics from multiple folders.

    Parameters:
    - basedir: str, path to the directory containing BUSCO output folders
    - output_file: str, path to the output TSV file
    """
    results = []

    for folder in os.listdir(basedir):
        folder_path = os.path.join(basedir, folder)

        if os.path.isdir(folder_path):
            for file in os.listdir(folder_path):
                if file.startswith("short_summary") and file.endswith(".txt"):
                    file_path = os.path.join(folder_path, file)
                    with open(file_path, "r") as extract:
                        for line in extract:
                            if line.startswith("#"):
                                continue
                            if "C:" in line and "S:" in line:
                                match = re.search(
                                    r"C:(?P<C>[\d\.]+)%\[S:(?P<S>[\d\.]+)%,D:(?P<D>[\d\.]+)%\],F:(?P<F>[\d\.]+)%,M:(?P<M>[\d\.]+)%,n:(?P<n>\d+)",
                                    line,
                                )
                                if match:
                                    row = match.groupdict()
                                    row["folder"] = folder
                                    results.append(row)

    df = pd.DataFrame(results)
    df.to_csv(output_file, sep="\t", index=False)

if __name__ == "__main__":
    basedir = "/shared/team/WGS/QC/all_contigs_ref/busco_output"
    output_file = "extracted_files.tsv"
    extract_files(basedir, output_file)
