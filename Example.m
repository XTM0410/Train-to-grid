%% This file is an example to show how to use the functions, including:
%   DTP_Evaluation.m: Deployable T2G power evaluation
%   VESA_model.m: Virtual energy storage aggregation model
%   PlotResult.m: A simple plot function to show the result
%   TrainConfiguration_example.mat: The example data for functions, including rail operation data of 50 trains

%% 1, Deployable T2G power evaluation
% Example: Evaluating 5-minute deployable T2G-F power at 10:00 from example trains

% Input:
%   TrainConfiguration:1*N structure:
%       TrainPara:1*10 double
%           1 Fm        N/kg
%           2 Pm        W/kg
%           3 gamma    
%           4 a0        under m/s and unit mass
%           5 a1        under m/s and unit mass
%           6 a2        under m/s and unit mass
%           7 Bm        N/kg
%           8 m     kg
%           9 etaT
%           10 etaB
%       RoadPara:m*2 double
%           1 SpeedLimit        m/s
%           2 Length        m
%       DepartureTime       s
%       GuidancetRef 1-row list     s
%       GuidanceVRef 1-row list     m/s
%       GuidanceXRef 1-row list     m
%       GuidanceuRef 1-row list 
%       Addmissiblet:1*2 double
%           1 Start time        s
%           2 End time      s
%       Addmissiblex:1*2 double
%           1 Start position        m
%           2 End position      m
load('TrainConfiguration_example.mat');
TrainConfiguration = TrainConfiguration_example;
%   T2GSet:1*5 cell:
%       list_Trainindex: Index of trains participating in the T2G
%       delta_t: Discrete time      s
%       T_T2G: T2G deploying period     min
%       Strategy: 1,T2G-F; 2,T2G-C; 3,T2G-D
%       t_begin: T2G start time     s
T2GSet{1} = 1:50;
T2GSet{2} = 60;
T2GSet{3} = [0 5];
T2GSet{4} = 1;
T2GSet{5} = 36000;

% Output:
%   Power: Deployable T2G power     MW
%   Energy: Deployable T2G energy       MWh
%   ChangeofPower: Power change of every train      MW
[Power,Energy,ChangeofPower] = DTP_evaluation(TrainConfiguration,T2GSet);

%% 2, Virtual energy storage aggregation model
% Example: Virtual energy storage aggregation model of example trains at 10:00 for T2G-F strategy

%VESA_MODEL Virtual energy storage aggregation model
% Input:
%   ChangeofPower_MultiplePeriod:1*n cell
%           1 ChangeofPower when T2G deploying period = 0
%           2~n ChangeofPower when T2G deploying period = 1~n-1
%   T2GDeployingPeriod_MultiplePeriod:1*n double
%           1 0
%           2~n T2GDeployingPeriod     min
load('TrainConfiguration_example.mat');
TrainConfiguration = TrainConfiguration_example;
T2GSet{1} = 1:50;
T2GSet{2} = 60;
T2GSet{4} = 1;
T2GSet{5} = 36000;

T2GDeployingPeriod_MultiplePeriod = 0:15;
for T2GDeployingPeriod = T2GDeployingPeriod_MultiplePeriod
    T2GSet{3} = [0 T2GDeployingPeriod];
    [Power,Energy,ChangeofPower] = DTP_evaluation(TrainConfiguration,T2GSet);
    Power_MultiplePeriod(T2GDeployingPeriod+1) = Power;
    Energy_MultiplePeriod(T2GDeployingPeriod+1) = Energy;
    ChangeofPower_MultiplePeriod{T2GDeployingPeriod+1} = ChangeofPower;
end

% Output:
%   RTP: Rated T2G power     MW
%   RTC: Rated T2G capacity     MWh
%   TDR: T2G deployable region:2*1500 double
%           1 Deploying period time point 1~15 min     
%           2 Deploy T2G power     MW
[RTP,RTC,TDR] = VESA_model(ChangeofPower_MultiplePeriod,T2GDeployingPeriod_MultiplePeriod);

%% 3, Plot the result of 1 and 2
PlotResult(TDR,Power_MultiplePeriod,T2GDeployingPeriod_MultiplePeriod);