# Retail-demand-forcasting
A data science project focused on the retail industry. This projects demonstrates the end to end capabilities of IBM Watson Studio, from data collection to model deployment and usage 

## Prerequisites 

1. Create an IBM Cloud account: https://ibm.biz/ingrammicro

2. Once you have created your account, you will see your dashboard. Search for the following services and create them: 
   * Machine Learning 
   * Watson Studio 
   * IBM Cognos Dashboard Embedded  

3. Lauch Watson Studio and create a project
  
  
## Data Collection and Prepartion  

1. Upload the demand.csv file to the project by going to the left hand and clicking the 'Find and add data' tab 

2. Let's move on to data preparation, for that click on Add project, and add data refinery flow. 

3. Do the following to prepare the dataset for modelling: 
   * Click on operation on the left - Select the Column "Item". Select Replace Substring and replace the strings with the following numbers TShirt - 1, Formal Shirts - 2, Jeans - 3 (We will only be working with 3 items for this lab) 
   
   * Click on Date column > Convert Column > select date
   * Click on Item column  > Convert Column > select integer 
   * Click on Store column  > Convert Column > select integer 

4. Save the flow and Run it as a job, this will create a new file: demand.csv_shaped.csv 


## Data Visualization - Data Exploration 

1. Click on Add project, and add dashabords. 

2. Enter a name for the dashboard > Click Create > Select free form

