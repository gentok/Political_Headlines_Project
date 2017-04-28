# Political Headlines Project

## 1. Overview

  * Title: Political Headlines Project
  * Purpose: This is an ongoing project to analyze newspaper headlines in Japan.
  * Started in: April 2017 (as the course project for STA208 at UC Davis)
  * Member: Gento Kato (UC Davis) & Tzu-ping Liu (UC Davis)

## 2. Research Questions

The project potentially answers following questions (or more).

 * What are the major categories of political news headlines?
 * How are positive/negative (PN) sentiments expressed in news headlines?
 * What are the impact of political news on public opinion (e.g., prime minister approval)?

## 3. Data

 * ALL First page headlines from two major newspapers in Japan, collected from 1987 through 2015.
 * Monthly public opinion polls in Japan of the corresponding period.
 * Check more detailed descriptions from [HERE](https://github.com/gentok/Political_Headlines_Project/tree/master/data_public).

## 4. Analytical Strategy

 * Dictionary approach to extract political headlines (Tutorial from [HERE](https://github.com/gentok/Political_Headlines_Project/blob/master/notebooks/Headline%20Data%20and%20Text%20Search.ipynb))
 * Unsupervised machine learning to categorize political news.
 * Supervised machine learning to code PN sentiments
 * Time-series analysis to assess the impact of news coverage on public opinion.

## 5. Project Structure

 * *codes*: R (and Python 2.7) codes used for data construction and analysis
 * *data_public*: Data description and storage for publicly available datasets
 * *memos*: Draft ideas and memos used on the way to develop project
 * *notebooks*: Jupyter notebook files to describe data and analytical tools
