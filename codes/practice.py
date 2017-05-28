import numpy as np

a = np.array([2,2,2,1,1,2,0])
np.unique(a)

values1 = np.array([1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3])
values2 = np.array([1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8,1,2,3,4,5,6,7,8])
score = np.array([1,2,3,4,5,6,7,8,9,10,15,13,2,3,4,5,3,2,1,10,15,20,32,8])
score_mat = np.array([]).reshape((0,len(np.unique(values2))))
score_mat.shape

for k in np.unique(values1):
    score_mat = np.vstack((score_mat, score[values1 == k]))
score_mat
