# Generalized Term Similarity for Feature Selection in Text Classification Using Quadratic Programming

## Abstract

This program is designed to perform the feature selection for text classification. This method deals with document-term matrix typed data set.

This software is a Matlab implementation of proposed method. The original version of this program was written by Hyunki Lim.

### [Paper]
Hyunki Lim and Dae-Won Kim, [Generalized Term Similarity for Feature Selection in Text Classification Using Quadratic Programming]()
Entropy, 2020

## License

This program is available for download for non-commercial use, licensed under the GNU General Public License, which is allows its use for research purposes or other free software projects but does not allow its incorporation into any type of commerical software.

## Sample Input and Output

It will return the index of input features in orders of importance of the terms. This code can executed under Matlab command window.

### [Usage]:

   `>> idx = fs_prop( data, label, opt );`

### [Description]

   data – a matrix that is composed of document-terms \
   label – a matrix represents topic/category of each document is assigned to \
   opt – similarity option that provides ‘ig’, ‘chi’, and ‘mi’ that correspond to information gain, chi squares, and mutual information, respectively
