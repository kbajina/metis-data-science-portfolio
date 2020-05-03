#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 10 09:34:00 2019

@author: kbajina
"""
########################
#### Python Imports ####
########################
import pandas as pd
import numpy as np
import pickle

import streamlit as st
from PIL import Image

import plotly.graph_objects as go
from ipywidgets import interactive, HBox, VBox

from statsmodels.tsa.statespace.sarimax import SARIMAX

## Initialize App
logo = Image.open("""backup_files/images/Walmart_logo_blue.png""")

st.image(logo, width=500)
st.title('Regional Retail Clusters Forecasting')

##############################
#### Import Pickled Files ####
##############################

directory = '/Users/kbajina/Documents/DATA SCIENCE/METIS/Metis-Data-Science-Portfolio/retail-sales-forecasting'

## Train & Test DataFrames
pkl_file = open(directory + '/pickled_files/cluster_1_train.pkl', 'rb')
cluster_1_train = pickle.load(pkl_file)
pkl_file.close()

pkl_file = open(directory + '/pickled_files/cluster_1_test.pkl', 'rb')
cluster_1_test = pickle.load(pkl_file)
pkl_file.close()

pkl_file = open(directory + '/pickled_files/cluster_2_train.pkl', 'rb')
cluster_2_train = pickle.load(pkl_file)
pkl_file.close()

pkl_file = open(directory + '/pickled_files/cluster_2_test.pkl', 'rb')
cluster_2_test = pickle.load(pkl_file)
pkl_file.close()


## Holiday Date Mappings
pkl_file = open(directory + '/backup_files/train_holidays.pkl', 'rb')
train_holidays = pickle.load(pkl_file)
pkl_file.close()

pkl_file = open(directory + '/pickled_files/test_holidays.pkl', 'rb')
test_holidays = pickle.load(pkl_file)
pkl_file.close()

pkl_file = open(directory + '/pickled_files/test_plus_future_holidays.pkl', 'rb')
test_plus_future_holidays = pickle.load(pkl_file)
pkl_file.close()

## Cluster 1 Model
pkl_file = open(directory + '/pickled_files/cluster_1_sarimax.pkl', 'rb')
clust1_model = pickle.load(pkl_file)
pkl_file.close()

## Cluster 2 Model 1
pkl_file = open(directory + '/pickled_files/cluster_2_sarimax_1.pkl', 'rb')
clust2_model1 = pickle.load(pkl_file)
pkl_file.close()

## Cluster 2 Model 2
pkl_file = open(directory + '/pickled_files/cluster_2_sarimax_1.pkl', 'rb')
clust2_model2 = pickle.load(pkl_file)
pkl_file.close()


###########################
#### Cluster 1 - Model ####
###########################
st.markdown('---')
st.markdown('## **Regional Cluster 1 - Forecast:**')
st.markdown("""**Cluster Characteristics:**
            - Lowest average regional temperature: ($49^oF$)
            - Low Avg. Consumer Price Index (CPI): $133$
            - Highest Sales Cluster
            - Highest Regional Population
            """)

clust1_model_steps = st.slider('Forecast Range (Weeks):', 1, 51, 12, key='slider1')

clust1_model_pred = np.exp(clust1_model.predict(start=cluster_1_test.index[0], end=cluster_1_test.index[0] + clust1_model_steps,
                                       exog=test_plus_future_holidays[:clust1_model_steps+1],
                                       dynamic=True, plot_insample=False))

clust_1_model_ci = np.exp(clust1_model.get_forecast(steps=clust1_model_steps+1,
                                                    exog=test_plus_future_holidays[:clust1_model_steps+1])\
                                .conf_int(alpha=0.05))


fig = go.Figure()
## Actual Sales
fig.add_trace(go.Scatter(x=cluster_1_train.index, y=cluster_1_train.iloc[:,0],
    fill=None,
    name='Actuals',
    mode='lines',
    line_color='green',
    ))
## Lower Confidence Interval Limit
fig.add_trace(go.Scatter(x=clust1_model_pred.index, y=clust_1_model_ci.iloc[:,0],
    fill=None,
    name='Lower Limit (95% CI)',
    mode='lines',
    opacity=0.5,
    line_color='#C7ADFF',
    ))
## Upper Confidence Interval Limit
fig.add_trace(go.Scatter(x=clust1_model_pred.index, y=clust_1_model_ci.iloc[:,1],
    fill='tonexty', # fill area between trace1 and trace2
    name='Upper Limit (95% CI)',
    mode='lines',
    opacity=0.5,
    fillcolor='#F4EEFF',
    line_color='#967BD0'))
## Forecasted Sales
fig.add_trace(go.Scatter(x=clust1_model_pred.index.insert(0, cluster_1_train.index[-1]),
                         y=np.insert(clust1_model_pred.tolist(), 0, cluster_1_train.iloc[:,0][-1]),
    fill=None,
    name='Forecast',
    mode='lines',
    line_color='#5B22D6',
    ))
## Update plot features
fig.update_layout(
    autosize=False,
    xaxis=go.layout.XAxis(title_text='Time Series',
                            rangeselector=dict(
                                buttons=list([
                                  dict(count=14,
                                         label="2w",
                                         step="day",
                                         stepmode="backward"),
                                    dict(count=1,
                                         label="1m",
                                         step="month",
                                         stepmode="backward"),
                                    dict(count=6,
                                         label="6m",
                                         step="month",
                                         stepmode="backward"),
                                    dict(count=1,
                                         label="YTD",
                                         step="year",
                                         stepmode="todate"),
                                    dict(count=1,
                                         label="1y",
                                         step="year",
                                         stepmode="backward"),
                                    dict(step="all")
                                ])
                            ),
                            rangeslider=dict(
                                visible=True
                            ),
                            type="date"
                        ),
    yaxis=go.layout.YAxis(title_text='Sales ($)')
    )
st.plotly_chart(fig)


############################
#### Cluster 2 - Models ####
############################
st.markdown('---')
st.markdown('## **Regional Cluster 2 - Forecast:**')
st.markdown("""**Cluster Characteristics:**
- Highest Avg. Regional Temperature: ($67.5^oF$)
- Lowest Avg. Consumer Price Index (CPI): $128$
- Lowest Sales Cluster
- Highest Level of Unemployment: $10.5\%$
""")

clust2_model1_steps = st.slider('Forecast Range (Weeks):', 1, 51, 12, key='slider2')

clust2_model1_pred = np.exp(clust2_model1.predict(start=cluster_2_test.index[0], end=cluster_2_test.index[0] + clust2_model1_steps,
                                       exog=test_plus_future_holidays[:clust2_model1_steps+1],
                                       dynamic=True, plot_insample=False))

clust_2_model1_ci = np.exp(clust2_model1.get_forecast(steps=clust2_model1_steps+1,
                                                    exog=test_plus_future_holidays[:clust2_model1_steps+1])\
                                .conf_int(alpha=0.05))


fig2 = go.Figure()
## Actual Sales
fig2.add_trace(go.Scatter(x=cluster_2_train.index, y=cluster_2_train.iloc[:,0],
    fill=None,
    name='Actuals',
    mode='lines',
    line_color='green',
    ))
## Lower Confidence Interval Limit
fig2.add_trace(go.Scatter(x=clust2_model1_pred.index, y=clust_2_model1_ci.iloc[:,0],
    fill=None,
    name='Lower Limit (95% CI)',
    mode='lines',
    opacity=0.5,
    line_color='#C7ADFF',
    ))
## Upper Confidence Interval Limit
fig2.add_trace(go.Scatter(x=clust2_model1_pred.index, y=clust_2_model1_ci.iloc[:,1],
    fill='tonexty', # fill area between trace1 and trace2
    name='Upper Limit (95% CI)',
    mode='lines',
    opacity=0.5,
    fillcolor='#F4EEFF',
    line_color='#967BD0'))
## Forecasted Sales
fig2.add_trace(go.Scatter(x=clust2_model1_pred.index.insert(0, cluster_2_train.index[-1]),
                         y=np.insert(clust2_model1_pred.tolist(), 0, cluster_2_train.iloc[:,0][-1]),
    fill=None,
    name='Forecast',
    mode='lines',
    line_color='#5B22D6',
    ))
## Update plot features
fig2.update_layout(
    autosize=False,
    xaxis=go.layout.XAxis(title_text='Time Series',
                            rangeselector=dict(
                                buttons=list([
                                  dict(count=14,
                                         label="2w",
                                         step="day",
                                         stepmode="backward"),
                                    dict(count=1,
                                         label="1m",
                                         step="month",
                                         stepmode="backward"),
                                    dict(count=6,
                                         label="6m",
                                         step="month",
                                         stepmode="backward"),
                                    dict(count=1,
                                         label="YTD",
                                         step="year",
                                         stepmode="todate"),
                                    dict(count=1,
                                         label="1y",
                                         step="year",
                                         stepmode="backward"),
                                    dict(step="all")
                                ])
                            ),
                            rangeslider=dict(
                                visible=True
                            ),
                            type="date"
                        ),
    yaxis=go.layout.YAxis(title_text='Sales ($)')
    )
st.plotly_chart(fig2)
