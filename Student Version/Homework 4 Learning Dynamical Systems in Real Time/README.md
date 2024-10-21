# Homework 4 Learning Dynamical Systems in Real Time 
Recursive least squares (RLS) is an adaptive filtering algorithm used to update model parameters in real-time, minimizing the sum of squared errors between predicted and actual values. It efficiently adjusts coefficients with each new data point, making it suitable for systems where the model needs to be continuously refined, such as in control systems and signal processing. In this exercise, we will study a method to update the model's parameter estimates obtain with system identification in real-time.

![image](https://github.com/user-attachments/assets/fcdb6dc7-ab9f-438d-93a6-bea2cc23ec33)


## Learning Goals
- Learn about least-squares estimation
- Learn about Recursive least-squares (RLS) estimation

## Setup
Open the MATLAB Live Script [Homework 4 Learning Dynamical Systems in Real Time.mlx](https://github.com/cescongroup/Learning-based-control-with-MATLAB-and-Simulink/blob/main/Student%20Version/Homework%204%20Learning%20Dynamical%20Systems%20in%20Real%20Time/Homework%204%20Learning%20Dynamical%20Systems%20in%20Real%20Time.mlx) and run each section as directed. Modify [rlsmodel.mdl](https://github.com/cescongroup/Learning-based-control-with-MATLAB-and-Simulink/blob/main/Student%20Version/Homework%204%20Learning%20Dynamical%20Systems%20in%20Real%20Time/rlsmodel.mdl) and [rlsupdate.m](https://github.com/cescongroup/Learning-based-control-with-MATLAB-and-Simulink/blob/main/Student%20Version/Homework%204%20Learning%20Dynamical%20Systems%20in%20Real%20Time/rlsupdate.m) as directed for the tasks.

