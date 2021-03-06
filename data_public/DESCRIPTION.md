# Political Headlines Data Description

All datasets below are generated by using <code>polhead_RMeCab_170427.R</code> and <code>polhead_subsetRMeCab_170427.R</code> stored in <code>codes</code> directory.

## 1. Headline Data <br>

Each Dataset includes the list of newspaper headlines from Nov 1987 to Mar 2015. They are first page headlines from two major newspapers in Japan, Asahi and Yomiuri. Each dataset is consists of subset of headlines that are related to certain political actor / topic in Japan.

### 1.1 Datasets
 * <code>alldata_traincode.csv</code> [*Private*] includes ALL first page newspaper headlines from Nov 1987 through Mar 2015. It includes training code variable <code>codeN</code> for the negative headlines. The original datasets are <code>alldate_170420.csv</code> [*Private*] and <code>codedall_170509.csv</code> [*Public*].

 * <code>cabinetdata_traincode.csv</code> [*Public*] includes all first page newspaper headlines that are related to cabinet or prime minister in Japan, including <code>codeN</code> for training variable of negative headlines. The major searched terms are "首相" (Prime Minister), "内閣" (cabinet), "閣僚" (cabinet ministers), and so on. The full list of words used for the extraction is given as follows: <code>"首相", "官邸", "内閣", "政権", "政府", "閣僚","法相", "法務相", "外務相", "外相", "財務相", "財相","文科相", "厚労相", "農水相", "農相", "経産相", "国交相", "環境相", "防衛相", "長官", "大蔵相", "蔵相", "厚生相", "厚相", "運輸相", "労働相", "労相", "建設相", "文部相", "文相", "厚生相", "自治相"</code>. The original datasets are <code>cabinetdata.csv</code> [*Public*] and <code>codeddata_170509.csv</code> [*Public*].<br>

 * <code>ldpdata_traincode.csv</code> [*Public*] includes all first page newspaper headlines that are related to liberal democratic party (LDP) in Japan, including <code>codeN</code> for training variable of negative headlines. The major searched terms are "自民" (Liberal Democratic), "自公" (Abbreviation for LDP and Komei-to), and so on. The full list of words used for the extraction is given as follows: <code>"自民", "自民党", "自公", "自社さ", "自公保", "総裁", "幹事長", "政調会長"</code>. The original datasets are <code>ldpdata.csv</code> [*Public*] and <code>codeddata_170509.csv</code> [*Public*]. <br>

 * <code>politicsdata_traincode.csv</code> [*Public*] includes all first page newspaper headlines that are related to general politics, including <code>codeN</code> for training variable of negative headlines. The major searched terms are "政治" (politics), "国会" (The National Diet), "選挙" (election) and so on. The full list of words used for the extraction is given as follows: <code>"民主主義", "国会", "衆議院", "衆院", "参議院", "参院", "選挙", "地方選", "政治", "法", "党", "政党", "与党", "野党", "新党", "党首", "連立", "代議士", "議員", "知事", "市長", "都議", "県議", "市議", "町議", "村議", "市町村", "自治体"</code>. The original datasets are <code>politicsdata.csv</code> [*Public*] and <code>codeddata_170509.csv</code> [*Public*]. <br>

### 1.2 Variables

Each Dataset comes with following variables:

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
   * <code>cabinet</code>: The dummy variable for cabinet / prime minister related headline.
   * <code>ldp</code>: The dummy variable for Liberal Democratic Party related headline.
   * <code>politics</code>: The dummy variable for general politics related headline.
   * <code>**codeN**</code>: Manually coded negative sentiment (in terms of Prime Minister) of headlines. *1 means negative, 0 means non-negative.*


## 2. Word Appearance Matrix Data

 The following datasets are used to machine-learn the contents of newspaper headlines. **Rows represent headlines and columns represent words.**

 NOTE: Text matrix datasets are VERY large files, so they are **not uploaded to GitHub**. Ask authors if you are interested in looking inside of data.

 ### 2.1 Datasets

 Each word appearnce matrix data has **identical row number as <code>id_all</code> variable** in corresponding headline data.

  * <code>allWrdMat10.csv.gz</code> [*Private*] is a word appearance matrix data that corresponds to <code>alldata_traincode.csv</code>  [*Private*]. It includes 99151 rows (headlines) and 8655 columns (terms). Only the terms appeared 10 times or more are included. In addition, <code>allBigram20t.rds</code> [*Private*] includes all bi-grams of terms that are appeared 20 times or more. This data is transposed, that means, rows represent bigrams (19531 bigrams), and columns represent headlines. <br>

  * <code>cabinetWrdMat10.csv</code> [*Public*] is a word appearance matrix data that corresponds to <code>cabinetdata_traincode.csv</code> [*Public*]. It includes 17176 rows (headlines) and 2427  columns (terms). Only the terms appeared 10 times or more are included. Full set of terms are seen in <code>cabinetWrdMat.csv</code> [*Private*], with 10069 terms.<br>

  * <code>ldpWrdMat10.csv</code> [*Public*] is a word appearance matrix data that corresponds to <code>ldpdata_traincode.csv</code> [*Public*]. It includes 4766 rows (headlines) and 979 columns (terms). Only the terms appeared 10 times or more are included. Full set of terms are seen in <code>ldpWrdMat.csv</code> [*Private*], with 4844 terms.<br>

  * <code>politicsWrdMat.csv</code>  [*Public*] is a word appearance matrix data that corresponds to <code>politicsdata_traincode.csv</code>  [*Public*]. It includes 16156 rows (headlines) and 2361 columns (terms). Only the terms appeared 10 times or more are included. Full set of terms are seen in <code>politicsWrdMat.csv</code> [*Private*], with 10354 terms.

 ### 2.2 Variables

 **Each column represents word** (i.e., noun, adjective, verb, ...). The value indicates **the frequency of word appearance**. The value often takes 1 or 0, but not necessarily. ***If the same word appears twice (or more) in one headline, then the value takes 2 or more.*** You need to recode the variable if you want to use these variables as dummy word appearnce in headline.

 The dataset includes ALL words (except for signs (e.g., parentheses, dots, ...) and other meaningless terms) that **are appeared at least 10 times** (or once) in whole data. It may be inefficient to include all those variables in the analysis. We can set some threshold of minimum or maximum frequency of word appearance to shrink dataset.
