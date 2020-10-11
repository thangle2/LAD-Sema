 prompt= 'Name of file: ';
Test1=input(prompt);
MSN=[];
prompt='What is the name of the outputfile: ';
x=input(prompt,'s');
water=append(x,'.xlsx');
for y=1:length(Test1)
 
if Test1{y}=="MSN:"
 
        MSN=[MSN y];
 
end

 
 
 
 
end
 
Experiment=[];
 
for i=MSN(1):length(Test1)
 
if Test1{i}=="Experiment:"
 
        Experiment=[Experiment i];
 
end
 
 
 
end
 
Autoshape=cell(1,5);
 
FSeconds=cell(1,8);
 
TSeconds=cell(1,8);
 
FinalTask=cell(1,10);
 
for i=1:length(MSN)-1
 
    if Test1{MSN(i),2}=="GNG-Autoshaping"
        Autoshape=AutoshapeFunction(Test1,Autoshape,MSN(i)-7,Experiment(i)-3);
    end
 
    if Test1{MSN(i),2}=="GNG-ReactionTime5s"
     FSeconds=Seconds(Test1,TSeconds,MSN(i)-7,Experiment(i)-3);
     
 
    end
 
    if Test1{MSN(i),2}=="GNG-ReactionTime3s"
    TSeconds=Seconds(Test1,TSeconds,MSN(i)-7,Experiment(i)-3);
       
    end
 
    if Test1{MSN(i),2}=="GNG-FinalTask"
     FinalTask=FinalTaskFunction(Test1,FinalTask,MSN(i)-7,Experiment(i)-3);
       
    end
 
   
 
end

    if Test1{MSN(length(MSN)),2}=="GNG-Autoshaping"
        Autoshape=AutoshapeFunction(Test1,Autoshape,MSN(length(MSN))-7,length(Test1));
    end
 
    if Test1{MSN(length(MSN)),2}=="GNG-ReactionTime5s"
     FSeconds=Seconds(Test1,TSeconds,MSN(length(MSN))-7,length(Test1));
     
 
    end
 
    if Test1{MSN(length(MSN)),2}=="GNG-ReactionTime3s"
    TSeconds=Seconds(Test1,TSeconds,MSN(length(MSN))-7,length(Test1));
       
    end
 
    if Test1{MSN(length(MSN)),2}=="GNG-FinalTask"
     FinalTask=FinalTaskFunction(Test1,FinalTask,MSN(length(MSN))-7,length(Test1));
       
    end
 














FinalTaskmat=cell2mat(FinalTask);
if isempty(FinalTaskmat)==0
FinalTaskTable=array2table(FinalTaskmat,'VariableNames',{'RatNumbers','Go Trials','Go Rewards','Go Omissions','Pretrials','Premature Response','No go Omossions','No-Go Rewards','No-Go Trials','Inactive'});
writetable(FinalTaskTable,water,'Sheet','FinalTask');
end
TSecondsMat=cell2mat(TSeconds);
if isempty(TSecondsMat)==0
TSecondsTable=array2table(TSecondsMat,'VariableNames',{'RatNumbers','Trials','Responses/Reward','Omissions','All Lever Pressed','Number of pretrials','Number of premature responses','Inactive lever pressed'});
writetable(TSecondsTable,water,'Sheet','Three Seconds');
end
FSecondsMat=cell2mat(FSeconds);
if isempty(FSecondsMat)==0
FSecondsTable=array2table(FSecondsMat,'VariableNames',{'RatNumbers','Trials','Responses/Reward','Omissions','All Lever Pressed','Number of pretrials','Number of premature responses','Inactive lever pressed'});
writetable(FSecondsTable,water,'Sheet','Five Seconds');
end
AutoShapeMat=cell2mat(Autoshape);
if isempty(AutoShapeMat)==0
AutoShapeTable=array2table(AutoShapeMat,'VariableNames',{'RatNumbers','Trials','Responses','All active hole lever pressed','Inactive hole lever pressed'});
writetable(AutoShapeTable,water,'Sheet','Autoshape');
end
function endresult= AutoshapeFunction(Test1,Autoshape,x,y)
for i=x:y
    if Test1{i}=="Subject:"
        Autoshape{1}=[Autoshape{1};Test1{i,2}];
    end
end
for i=x:y
    if Test1{i}=="A:"
        Autoshape{2}=[Autoshape{2};Test1{i,2}];
    end
    if Test1{i}=="B:"
        Autoshape{3}=[Autoshape{3};Test1{i,2}];
    end
    if Test1{i}=="D:"
        Autoshape{4}=[Autoshape{4};Test1{i,2}];
    end
    if Test1{i}=="J:"
        Autoshape{5}=[Autoshape{5};Test1{i,2}];
    end
   
end
endresult=Autoshape;
end
function endresult= FinalTaskFunction(Test1,array,x,y)
for i=x:y
    if Test1{i}=="Subject:"
        array{1}=[array{1};Test1{i,2}];
    end
end
for i=x:y
    if Test1{i}=="A:"
          array{2}=[array{2};Test1{i,2}];
    end
    if Test1{i}=="B:"
         array{3}=[array{3};Test1{i,2}];
    end
    if Test1{i}=="C:"
         array{4}=[array{4};Test1{i,2}];
    end
    if Test1{i}=="E:"
         array{5}=[array{5};Test1{i,2}];
    end
    if Test1{i}=="F:"
         array{6}=[array{6};Test1{i,2}];
    end
    if Test1{i}=="H:"
         array{7}=[array{7};Test1{i,2}];
    end
    if Test1{i}=="G:"
         array{8}=[array{8};Test1{i,2}];
    end
    if Test1{i}=="I:"
         array{9}=[array{9};Test1{i,2}];
    end
    if Test1{i}=="J:"
         array{10}=[array{10};Test1{i,2}];
    end
   
end
endresult=array;
end
 
function endresult=Seconds(Test1,array,x,y)
for i=x:y
    if Test1{i}=="Subject:"
        array{1}=[array{1};Test1{i,2}];
    end
end
for i=x:y
    if Test1{i}=="A:"
          array{2}=[array{2};Test1{i,2}];
    end
    if Test1{i}=="B:"
         array{3}=[array{3};Test1{i,2}];
    end
    if Test1{i}=="C:"
         array{4}=[array{4};Test1{i,2}];
    end
    if Test1{i}=="D:"
         array{5}=[array{5};Test1{i,2}];
    end
    if Test1{i}=="E:"
         array{6}=[array{6};Test1{i,2}];
    end
    if Test1{i}=="F:"
         array{7}=[array{7};Test1{i,2}];
    end
    if Test1{i}=="J:"
         array{8}=[array{8};Test1{i,2}];
    end
end
endresult=array;
end
