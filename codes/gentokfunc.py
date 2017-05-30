## Load Required Modules
import numpy as np
from sklearn.model_selection import train_test_split, LeaveOneOut, KFold
from sklearn.metrics import precision_recall_curve, roc_curve, average_precision_score
from sklearn.metrics import auc, roc_auc_score, average_precision_score, accuracy_score
from sklearn.multiclass import OneVsOneClassifier

## Accuracy Scores from the Classification
def class_onestep_accu(X_train, y_train, X_test, y_test, clmod, multi=False):
    """

    Store accuracy score from one-step classification method.

    Input: design matrix for code training, X_train,
           response vector for code training, y_train,
           design matrix for code test, X_test,
           response vector for code training, y_test,
           a classification model, clmod,
           multi-class classification or not, multi = False (default),
    Output: accuracy score, accuracy

    """
    ## Use OneVsOne Classifier for Multi Class Classification
    if multi:
        clmod = OneVsOneClassifier(clmod)

    ## Fit Model and export accuracy score
    clmod.fit(X_train,y_train) ## Fit Model on Training Data
    predy = clmod.predict(X_test)  # predicted Y (for test y)
    accuracy = accuracy_score(y_test,predy) # calculate accurary score
    return accuracy

## AUC scores from Classification (Multi-Class Classification not Applicable)
def class_onestep_auc(X_train, y_train, X_test, y_test, clmod):
    """

    Store ROC curve, PR curve and AUC measures from one-step classification method.

    Input: design matrix for code training, X_train,
           response vector for code training, y_train,
           design matrix for code test, X_test,
           response vector for code training, y_test,
           a classification model, clmod
    Output: false positive rate, modfpr,
            true positive rate, modtpr,
            area under ROC curve, modauc,
            precision, modprec,
            recall, modrec,
            average precision (area under PR curve), modprauc

    """
    clmod.fit(X_train,y_train) ## Fit Model on Training Data

    proby = clmod.predict_proba(X_test)[:,1]  # predicted Y (for test y)
    modfpr, modtpr, _  = roc_curve(y_test, proby) #ROC Curve
    modrocauc = auc(modfpr, modtpr) # Area Under Curve (AUC) for ROC
    modprec, modrec, _ = precision_recall_curve(y_test, proby) #PR Curve
    modprauc = auc(modrec, modprec) ## Average Precision from PR Curve

    return modfpr, modtpr, modrocauc, modprec, modrec, modprauc

## Oneshot Classification Result
def class_oneshot(X, y, clmod, testsize = .2, randomstate=2342, score_method = 'AUC'):
    """
    Store test measures from one-shot classification methods.

    Input: design matrix, X,
           response vector, y,
           a classification model, clmod,
           size of test set, testsize,
           random number to define train-test split, randomstate,
           score definition (Accuracy, AUC), score_method = 'AUC' (default)
    Output: If score_method='Accuracy': Accuracy score
            If score_method='AUC': false positive rate, modfpr,
                                   true positive rate, modtpr,
                                   area under ROC curve, modrocauc,
                                   precision, modprec,
                                   recall, modrec,
                                   average precision (area under PR curve), modprauc
    """
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=testsize, random_state=randomstate) ## Train-Test Split

    if score_method == 'Accuracy':
        modaccu = class_onestep_accu(X_train, y_train, X_test, y_test, clmod) ## Conduct one_step classification
        return modaccu

    if score_method == 'AUC':
        modfpr, modtpr, modrocauc, modprec, modrec, modprauc = class_onestep_auc(X_train, y_train, X_test, y_test, clmod) ## Conduct one_step classification
        return modfpr, modtpr, modrocauc, modprec, modrec, modprauc

## Validation of Classification Result
def class_validation(X, y, clmod, score_method = 'Accuracy', val_method = 'KFold', multi = False, k = 5, testsize = 0.5, simuN=1, startrand = 3423):

    """

    Simulate and store scores from validation of classification.

    Input: design matrix, X,
           response vector, y,
           a classification model, clmod,
           score definition (Accuracy, AUC, ROC-AUC or PR-AUC), score_method = 'Accuracy' (default),
           validation method (KFold, LeaveOneOut, HoldOut), val_method = 'KFold' (default),
           multi-class classification or not (only for accuracy score), multi = False (default),
           k for K-fold, k = 5 (default),
           simulation random-number for K-fold and HoldOut, startrand = 3423 (default)
           test-set size in proportion for HoldOut, testsize = 0.5 (default),
           simulation number for HoldOut, simuN = 1 (default),
    Output: If score_method='Accuracy': Mean Accuracy
            If score_method='AUC': Mean area under curve for ROC,
                                   Mean area under curve for Precision-Recall (Average Precision)

    """

    if score_method == 'Accuracy':

        ## Prepare Bag of Result Values ##
        modaccu = np.array([])

        ## Conduct Validations ##
        if val_method == 'KFold': ## If K-fold cross validation
            kf = KFold(n_splits = k, random_state = startrand)
            for train_index, test_index in kf.split(X):
                X_train, X_test = X[train_index], X[test_index]
                y_train, y_test = y[train_index], y[test_index]
                ## Conduct one_step classification
                modaccu_temp = class_onestep_accu(X_train, y_train, X_test, y_test, clmod, multi)
                ## Append Accuracy
                modaccu = np.append(modaccu,modaccu_temp)
        if val_method == 'LeaveOneOut': ## If Leave-one-out cross validation
            loo = LeaveOneOut()
            for train_index, test_index in loo.split(X):
                X_train, X_test = X[train_index], X[test_index]
                y_train, y_test = y[train_index], y[test_index]
                ## Conduct one_step classification
                modaccu_temp = class_onestep_accu(X_train, y_train, X_test, y_test, clmod, multi)
                ## Append Accuracies
                modaccu = np.append(modaccu,modaccu_temp)
        if val_method == 'HoldOut': ## If --% hold-out validation
            for i in range(1, simuN+1):
                X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=testsize, random_state=i+(startrand-1))
                ## Conduct one_step classification
                modaccu_temp = class_onestep_accu(X_train, y_train, X_test, y_test, clmod, multi)
                ## Append Accuracies
                modaccu = np.append(modaccu,modaccu_temp)

        ## Return Average Score from validation ##
        return np.mean(modaccu)

    if not score_method == 'Accuracy':

        ## Prepare Bag of Result Values ##
        modrocauc = np.array([])
        modprauc = np.array([])

        ## Conduct Validations ##
        if val_method == 'KFold': ## If K-fold cross validation
            kf = KFold(n_splits = k)
            for train_index, test_index in kf.split(X):
                X_train, X_test = X[train_index], X[test_index]
                y_train, y_test = y[train_index], y[test_index]
                ## Conduct one_step classification
                _,_,modrocauc_temp,_,_,modprauc_temp = class_onestep_auc(X_train, y_train, X_test, y_test, clmod)
                ## Append AUCs
                modrocauc = np.append(modrocauc,modrocauc_temp)
                modprauc = np.append(modprauc,modprauc_temp)
        if val_method == 'LeaveOneOut': ## If leave-one-out cross validation
            print "AUC Method is NOT applicable for Leave-One-Out CV."
        if val_method == 'HoldOut': ## If --% hold out validation
            for i in range(1, simuN+1):
                X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=testsize, random_state=i+(startrand-1))
                ## Conduct one_step classification
                _,_,modrocauc_temp,_,_,modprauc_temp = class_onestep_auc(X_train, y_train, X_test, y_test, clmod)
                ## Append AUCs
                modrocauc = np.append(modrocauc,modrocauc_temp)
                modprauc = np.append(modprauc,modprauc_temp)

        ## Return Average Scores from validation ##
        if score_method == 'AUC':
            return np.mean(modrocauc), np.mean(modprauc)
        if score_method == 'ROC-AUC':
            return np.mean(modrocauc)
        if score_method == 'PR-AUC':
            return np.mean(modprauc)

def class_optparam(X, y, clmod, params, score_method = 'Accuracy', val_method = 'KFold', multi = False, k = 5, testsize = 0.5, simuN=1, startrand = 3423):

    """

    Simulate and store scores from validation of classification.

    Input: design matrix, X,
           response vector, y,
           a classification model, clmod,
           Set of tuning parameters in dict format (up to two parameters), params
           score definition (Accuracy, ROC-AUC or PR-AUC), score_method = 'Accuracy' (default),
           validation method (KFold, LeaveOneOut, HoldOut), val_method = 'KFold' (default),
           multi-class classification or not (only for accuracy score), multi = False (default),
           k for K-fold, k = 5 (default),
           test-set size in proportion for HoldOut, testsize = 0.5 (default),
           simulation number for HoldOut, simuN = 1 (default),
           simulation random-number for HoldOut, startrand = 3423 (default)
    Output: If one tuning parameter: optimal parameter value, best_param,
                                     the highest score, best_score,
                                     tested parameter values, values1,
                                     tested score values, score
            If two tuning parameters: optimal parameter values, best_param,
                                      the highest score, best_score,
                                      tested 1st parameter values, values1,
                                      tested 2nd parameter values, values2
                                      matrix of tested score values (rows=1st, cols=2nd), score_mat

    """

    ## Prepare score storage ##
    score = np.array([])

    ## Setting parameter values for simulation ##
    if len(params) == 1: # only one parameter to tune
        [(name1, values1)] = params.items()
    if len(params) == 2: # two parameters to tunue
        (name1, values1), (name2, values2) = params.items()
        values1_original = values1; values2_original = values2
        # replicate 2nd parameter values for # of 1st parameter values times
        values2_all = np.array([])
        for i in range(1, len(values1)+1):
            values2_all = np.append(values2_all, values2)
        # repeat each 1st paramete value for # of 2nd parameter values times
        values1 = np.repeat(values1, len(values2))
        # replace 2nd parameter values with new values
        values2 = values2_all

    ## Simulate Score Values with different parameter values ##
    for i in range(0, len(values1)):

        # define classification models with specified parameter values
        value1 = values1[i] # 1st parameter value
        if len(params) == 1: # only one parameter
            clmod_temp = clmod.set_params(**{name1: value1})
        if len(params) == 2: # two parameters
            value2 = values2[i] # 2nd parameter value
            clmod_temp = clmod.set_params(**{name1: value1, name2: value2})

        # conduct classification and export score (unique score required. "AUC" score_method not applicable)
        if score_method == 'AUC': ## If AUC score method set
            print "AUC option is NOT applicable. Use ROC-AUC or PR-AUC."
        score_temp = class_validation(X, y, clmod_temp, score_method = score_method, val_method = val_method, multi = multi, k = k, testsize = testsize, simuN=simuN, startrand = startrand)
        score = np.append(score, score_temp)

    ## Extract best score and corresponding parameter values ##
    best_score = np.max(score) # best score
    values1 = np.array(values1)
    best_param1 = values1[score == best_score].tolist() # best 1st parameter values
    if len(params) == 2:
        values2 = np.array(values2)
        best_param2 = values2[score == best_score].tolist() # best 2nd parameter values

    ## Return results ##
    if len(params) == 1:
        best_param = {name1: best_param1}
        return best_param, best_score, values1, score
    if len(params) == 2:
        best_param = {name1: best_param1, name2: best_param2}
        # Create the score matrix with rows (y-axis) representing values1,
        # columns (x-axis) representing values 2.
        score_mat = np.array([]).reshape((0,len(values2_original)))
        for k in values1_original:
            score_mat = np.vstack((score_mat, score[values1 == k]))
        return best_param, best_score, values1_original, values2_original, score_mat

## Some Class in creating validation graph
# Utility function to move the midpoint of a colormap to be around the values of interest.
# From http://scikit-learn.org/stable/auto_examples/svm/plot_rbf_parameters.html
from matplotlib.colors import Normalize
class MidpointNormalize(Normalize):
    def __init__(self, vmin=None, vmax=None, midpoint=None, clip=False):
        self.midpoint = midpoint
        Normalize.__init__(self, vmin, vmax, clip)
    def __call__(self, value, clip=None):
        x, y = [self.vmin, self.midpoint, self.vmax], [0, 0.5, 1]
        return np.ma.masked_array(np.interp(value, x, y))


def class_simpred(X_all, X_train, y_train, clmod, n, startrand = 345):
    """
    Simulate and store predicted probabilities from classification methods.

    Input: All design matrix, X_all,
           training design matrix, X_train,
           training response vector, y_train,
           a classification model, clmod,
           itereation number, n
           Starting value for randomseed, startrand
    Output: set of predicted probabilities (rows=cases, columns=simulationN), probyA
    """
    probyA = np.array([]).reshape(0,X_all.shape[0])
    for i in range(n):
        np.random.RandomState(i + startrand) # Set Random Seed
        # Boot-strap Rows
        bsrow = np.random.choice(range(X_train.shape[0]),X_train.shape[0],replace=True)
        ## New Training Set
        X_new = X_train[bsrow,:]; y_new = y_train[bsrow]
        ## Fit Model on Training Data
        clmod.fit(X_new,y_new)
        # predicted all Y (for All y)
        probyA_temp = clmod.predict_proba(X_all)[:,1]
        probyA = np.vstack((probyA, probyA_temp))
    probyA = probyA.transpose()
    probyAav = np.mean(probyA, axis=1)
    return probyAav, probyA
