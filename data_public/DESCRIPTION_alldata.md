<text align="center">
 <h1> Exploring and Predicting Characteristics of Japanese Newspaper Headlines </h1>
<h2> <i>STA208 Final Project (Spring 2017)</i> </h2>
 <h3> <i>Tzu-ping Liu and Gento Kato</i> </h3>
</text>

[<p  style="text-align:right"> <i>Back to Summary Notebook</i> </p>](../notebooks/Project_Summary_STA208.ipynb)

<text align="center">
<h1> <i>Section II</i> </h1>
<h1> Data of Japanese Newspaper Headlines </h1> 
</text>

## 1. Raw Headline Text Data <br>

The dataset includes the full texts of newspaper headlines from Nov 1987 to Mar 2015. They are (almost) ALL first page headlines from two major newspapers in Japan, Yomiuri Shimbun and The Asahi Shimbun.

Raw texts are extracted using [*Yomidas Rekishikan*](http://www.yomiuri.co.jp/database/rekishikan/) for *Yomiuri Shimbun* and [*Kikuzo II Visual*](https://database.asahi.com/index.shtml) for *The Asahi Shimbun*. Headlines with general names such as "Today's news" or "Today's column" are eliminated from the dataset, since it involves no information regarding to the topical content of the article.

### 1.1 Dataset
 * [<code>alldate_170420.csv</code>](https://github.com/UCDSTA208/208-final-project-liu_and_kato/blob/master/data/alldate_170420.csv) is the original dataset that includes ALL first page newspaper headlines from Nov 1987 through Mar 2015.<br><br>
 * [<code>alldate_traincode.csv</code>](https://github.com/UCDSTA208/208-final-project-liu_and_kato/blob/master/data/alldata_traincode_170510.csv) additionaly includes training code variable <code>codeN</code> for the negative sentiment appeared on randomly sampled 1000 headlines. Following files are used to construct the data:
   * Random sampling of headlines by [<code>polhead_allCodingSample_170509.R</code>](../codes/polhead_allCodingSample_170509.R).
   * Handcoded negative sentiments in  [<code>codedall_170509.csv</code>](../data_public/codedall_170509.csv).
   * The creation of new dataset by [<code>polhead_allCoded_170510.R</code>](../codes/polhead_allCoded_170510.R).

### 1.2 Variables

The [<code>alldate_traincode.csv</code>](https://github.com/UCDSTA208/208-final-project-liu_and_kato/blob/master/data/alldata_traincode_170510.csv) dataset comes with following variables:

   * <code>**id_all**</code>: Global headline id (each headline has a unique ID)
   * <code>id_inpaper</code>: With-in paper headline id (each headline in the same newspaper has a unique ID)
   * <code>id_original</code>: Headline ID from original dataset (can be ignored)
   * <code>year</code>: Year of headline
   * <code>month</code>: Month of headline
   * <code>date</code>: Day of headline
   * <code>**ymonth**</code>: Year-month of headline
   * <code>**Headline**</code>: The raw texts of headline
   * <code>**paper**</code>: Character string for the newspaper. "A" indicates Asahi, "Y" indicates Yomiuri.
   * <code>**wcount**</code>: Word count for each article attached with headline
   * <code>Asahi</code>: Dummy for Asahi newspaper. 1 for headlines from Asahi.
   * <code>Yomiuri</code>: Dummy for Yomiuri newspaper. 1 for headlines from Yomiuri.
   * <code>jijistartdate</code>: The date when *jiji monthly poll* start to collect the data in each month.
   * <code>**jijiymonth**</code>: Year-month according to *jiji monthly poll*. The month is considered to start when *jiji monthly poll* starts to collect its data (jijistartdate) in current month, and ends at the day before *jiji monthly poll* starts to collect data for next month.
   * <code>**codeN**</code>: Manually coded negative sentiment appeared on randomly sampled 1000 headlines. *1 means negative, 0 means non-negative, and NA means not-sampled*.


## 2. Word Appearance Matrix Data

 ### 2.1 Dataset

 The matrix of word appearance frequency, [<code>allWrdMat10.csv.gz</code>](https://github.com/UCDSTA208/208-final-project-liu_and_kato/blob/master/data/allWrdMat10.csv.gz) is created by using <code>Headline</code> variable in [<code>alldate_traincode.csv</code>](https://github.com/UCDSTA208/208-final-project-liu_and_kato/blob/master/data/alldata_traincode_170510.csv).

 We conduct isomorphic analysis of Japanese texts by <code>MeCab</code> (Japanese isomorphic analysis software), and extract nouns, adjectives and verbs that appeared **more than 10 times** in the dataset by [<code>polhead_allWrdMat_170509.R</code>](../codes/polhead_allWrdMat_170509.R).

 In the exported data, **rows represent headlines and columns represent words.** It includes 99151 rows (headlines) and 8655 columns (words). The word appearnce matrix data has **identical row number as <code>id_all</code> variable** in [<code>alldate_traincode.csv</code>](https://github.com/UCDSTA208/208-final-project-liu_and_kato/blob/master/data/alldata_traincode_170510.csv).

 NOTE: Original Text matrix datasets are VERY large files, so we use gzip method to compress csv file.

<!---
  In addition, <code>allBigram20t.rds</code> [*Private*] includes all bi-grams of terms that are appeared 20 times or more. This data is transposed, that means, rows represent bigrams (19531 bigrams), and columns represent headlines. <br>
--->

 ### 2.2 Variables

 **Each column represents word** (i.e., noun, adjective, verb). The value indicates **the frequency of word appearance**. The value often takes 1 or 0, but not necessarily. ***If the same word appears twice (or more) in one headline, then the value takes 2 or more.*** You need to recode the variable if you want to use these variables as dummy word appearnce in headline.

 The dataset includes ALL nouns, adjectives, and verbs that **are appeared at least 10 times** in whole data. Note that it may be inefficient to include all those variables in the analysis.
