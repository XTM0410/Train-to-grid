# Train-to-grid
## Overview
Train-to-grid is a repository dedicated to the reproduction and analysis of the train-to-grid (T2G) potential of electrified railways. The T2G is a novel approach to enhancing power systems by leveraging electrified railway networks as a flexible load resource, as discussed in the paper titled "Exploring train-to-grid potential of electrified railways".
## Repository Structure
* `DTP_evaluation.m`: Function to evaluate T2G potential based on the rail operation data.<br>
* `VESA_model.m`: Function to generate virtual energy storage aggregation model from the T2G potential.<br>
* `PlotResult.m`: Function to plot the results.<br>
* `Example.m`: Script to demonstrate how to use the functions.<br>
* `TrainConfiguration_example.mat`: The example input file for the functions.<br>
## Usage
The T2G potential of the example input file can be obtained by running the `Example.m` script. The script will demonstrate how to use the functions to calculate the result and plot a figure. The script also demonstrate data structure of the input file. Users can modify and replace the input on demand.
