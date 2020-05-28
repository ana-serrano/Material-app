The folder data_Mturks contains:
  - The collected surveys (/data), each survey in a different json file
  - Projections in Lab space of the 400 BRDFs (/projections_Lab), necessary to build the training matrix.
  - Lists of attributes and names of the BRDFs (.txt files)
  - Two matlab scripts to process the data (output is the training matrix). The main script is process_Mturk.m

The folder RBF_training contains:
  - The necessary scripts to train the RBFs with a training matrix. The main script is train_RBF.m