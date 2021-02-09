import numpy as np
import pandas as pd

from joblib import dump

from xgboost import XGBRegressor
from sklearn.pipeline import Pipeline
from sklearn.impute import SimpleImputer


# Lendo os dados, e retirandos incoscistencias
df = pd.read_csv('data/beers.csv')
df.dropna(subset=['ibu'], inplace = True)

# Separando em variaveis e target
X = df.drop(['id', 'name', 'ibu'], axis = 1)
y = df['ibu']

# Criacao do Pipeline
pipeline = Pipeline(
	[
		('Simple Imputer', SimpleImputer(missing_values=np.nan, strategy='constant', fill_value=-99)), 
		('XGB Regressor', XGBRegressor(n_estimators=100, n_jobs=-1, max_depth=5, random_state=42))
	]
)

# Treinamento e persistencia do modelo
model = pipeline.fit(X, y)
dump(model, "model/model.joblib")
