import requests

import pandas as pd

class PunkAPI:

	def get_many_beers(page = 20):
		response_result = []

		for i_page in range(1, page):
			response = requests.get(f"https://api.punkapi.com/v2/beers?page={i_page}&per_page=80")
			response_result += response.json()

		return response_result
		 
	def get_random_beer():
		response = requests.get("https://api.punkapi.com/v2/beers/random")
		return response.json()[0]

if __name__ == "__main__":
	beers = PunkAPI.get_many_beers()
	beers_df = pd.DataFrame(beers)

	columns_to_select = [
		"id",
		"name", 
		"abv", 
		"ibu", 
		"target_fg", 
		"target_og", 
		"ebc", 
		"srm", 
		"ph"
	]
	beers_df = beers_df[columns_to_select]
	
	beers_df.to_csv('data/beers.csv', index = False)