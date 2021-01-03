# Projecte_Automatica
## TO DO
  - Make the final results (and show them when RUN pressed)
  - Finish PID
  - Compute the app.CLVariables remain inside the "updateController" public function.
  - "app.mlapp" to delete
# To run
  - To run the project, for now it works with the following configuration.
  
## 1. Simulation Tab
  - Choose between:
    - Closed loop. A new controller can be added and all of them are saved into files or an existent controller can be chosen. Every time a controller is selected a new window is opened with it's values to check.
    - Open loop (test: CR{30}, basal{0.24})
  - Glycemia units mg/dL (mmol/L not implemented yet)
  
## 2. Scenario Tab
  - Patients list (test: 60_1, 60_12, 60_14)
  - From the table:
    - BG (test: 5)
    - Meal intake (test: [30 40 25])
    - Meal time (test: [7 13 20])
    - Simulation time (test: 1440)
    
## 3. Press RUN

    
