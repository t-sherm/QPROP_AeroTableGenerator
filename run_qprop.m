function [run_results] = run_qprop(propfile,motorfile,outputfile,Setpoint)
                          
inputs =   {'Velocity'
            'RPM'
            'Voltage'
            'dBeta'
            'Thrust'
            'Torque'
            'Current'
            'Pele'};

SetpointString = [];
for n=1:numel(inputs)
    if isempty(Setpoint.(inputs{n}))==1
        SetpointString = [SetpointString ' 0'];
    else    
        if length(Setpoint.(inputs{n})) > 1
            SetpointString = [SetpointString ' ' num2str(Setpoint.(inputs{n})(1)) ',' num2str(Setpoint.(inputs{n})(2)) ',' num2str(Setpoint.(inputs{n})(3))];
            multirun = true;
        else
            SetpointString = [SetpointString ' ' num2str(Setpoint.(inputs{n}))];
        end
        
    end
end

%% Run Qprop
% Run parameters definition order: 
% vel  rpm volt dbeta thrust torque amps pele

commandstring = ['qprop\qprop.exe ' ...
                 propfile ' '...
                 motorfile ' '...
                 SetpointString ' > ' ...
                 outputfile '.dat'];
             
system(commandstring);

% Convert output to table
f = fopen([outputfile '.dat']);
header = textscan(f, '%s',20,'HeaderLines',16);
header_string_array = string(header{1}');
run_results = readtable([outputfile '.dat'],'NumHeaderLines',17);
run_results.Properties.VariableNames = header_string_array(2:end);

