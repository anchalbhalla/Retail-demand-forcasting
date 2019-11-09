# Retail-demand-forcasting
A data science project focused on the retail industry. This projects demonstrates the end to end capabilities of IBM Watson Studio, from data collection to model deployment and usage 

## Prerequisites 

1. Create an IBM Cloud account: https://ibm.biz/ingrammicro

2. Once you have created your account, you will see your dashboard. Search for the following services and create them: 
   * Machine Learning [take note of the credentials especially the api key and ML instance id]
   * Watson Studio 
   * IBM Cognos Dashboard Embedded  

3. Lauch Watson Studio and create a project
  
  
## Data Collection and Prepartion  

1. Upload the demand.csv file to the project by going to the left hand and clicking the 'Find and add data' tab 

2. Let's move on to data preparation, for that click on Add project, and add data refinery flow. 

3. Do the following to prepare the dataset for modelling: 
   * Click on operation on the left - Select the Column "Item". Select Replace Substring and replace the strings with the following numbers TShirt - 1, Formal Shirts - 2, Jeans - 3, Formal Trousers - 4, Blazers - 5, Jackets - 6, Shoes - 7, Heels - 8, Scarves - 9, Hats - 10 (We will only be working with the first 3 items for this lab) 
   
   * Click on Date column > Convert Column > select date
   * Click on Item column  > Convert Column > select integer 
   * Click on Store column  > Convert Column > select integer 

4. Save the flow and Run it as a job, this will create a new file: demand.csv_shaped.csv 


## Data Visualization - Data Exploration 

1. Click on Add project, and add dashabords. 

2. Enter a name for the dashboard > Click Create > Select free form 

3. Select the data source to be demand.csv 

4. Select the item and sales attibutes and drag and drop them onto the canvas and you will get the following results: 
![alt text](https://github.com/anchalbhalla/Retail-demand-forcasting/tree/master/images/dashboard.png)


## Modelling - SPSS 

1. Click on Add project, and add modeler flows. 

2. Enter a name for the SPSS flow > Click from file > Select the .str file 

3. Replace the data input node if the flow gives an error while running and select the demand.csv_shaped.csv file

4. Run the flow 

5. Save all the three time series model in the following manner: 
![alt text](https://github.com/anchalbhalla/Retail-demand-forcasting/tree/master/images/saving-time-series.png)
6. Go back to the project and will see all 3 models under Watson machine learning models. 

7. Go to each one of them and deploy them by clicking on add service 

8. You can now test them by going to the test tab under the models. Make note of the scoring URLS in the implementation tab


## Shiny Application Developement - R Studio 

1. Go back to the project and click on launch IDE to open up the R studio on cloud 

2. Click on upload and upload the app file (shiny R app) 

3. Enter the api key from the machine leanring service at the start

4. Enter the ML instance id where specified and copy paste the scoring URLS in the three places as mentioned 

5. You will get the following shiny app:
![alt text](https://github.com/anchalbhalla/Retail-demand-forcasting/tree/master/images/app.png)
