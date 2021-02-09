import numpy as np
import pandas as pd

from joblib import load

from xgboost import XGBRegressor
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer


# Leitura dos dados
df = pd.read_csv('data/beers.csv')

# Separacao dos dados que serao utilizadados para a previsao
X = df.drop(['id', 'name', 'ibu'], axis = 1)

# Carregamento do modelo e previsao
model = load('model/model.joblib')
y_pred = model.predict(X)

df['ibu_pred'] = y_pred
print(df.head())
