prompt111='how many files: ';
numberoffiles=input(prompt111);
for numberaaa=1:numberoffiles

% Ask for the file
prompt= 'Name of file_';
filenumber=num2str(numberaaa);prompt1final=strcat(prompt,filenumber,' :');
Test1=input(prompt1final);
prompt2='Name of putput file_';
prompt2final=strcat(prompt2,filenumber,' :');
Test2=input(prompt2final,'s');
% Creates 2 variables to count the amount of rats (FirstAmountofSubjects)
% and I (AmountofI)
% I is an array of all of the IRT therefore we are counting how many arrays
% there are.
FirstAmountofSubjects=0;
AmountofI=0;
% Run through the Main Cell Array (Test1), which is basically the excel
% sheet and everytime the cell contain exactly either "I:" or "Subject:",
% we +1 to FirstAmountofSubjects and AmountofI.
for i=10:length(Test1)
if Test1{i}=="I:"
AmountofI=AmountofI+1;
end
if Test1{i}=="Subject:"
FirstAmountofSubjects=FirstAmountofSubjects+1;
end
end
% We create an array of zeros that has the same amount of element as the
% FirstAmountofSubjects that will contain all of the line number of where
% all the "Subject:" line is
FirstAlltheSubject=zeros(FirstAmountofSubjects,1);
%Create an array of all the "Ends" of each Rat's Data. The way the excel
%sheet is laid out is all of the rats' data are spread out to sections of the excel therefore there is a start and an end to each
%rat's data section. The beginning will be the I line. And the end would be
%the four lines above Subject line of next rat. For example: Rat 1 section will start from
%the "I:" of Rat 1 and four lines the "Subject:" of Rat 2


%The Reason I do 4 lines above is because after every I matrit it skips a
%line, and then the Start Date line,then the End date, and then the Subject
%line, therefore 4 lines. 
AlltheEnd=zeros(FirstAmountofSubjects,1);
%Create an array of all the line number of the "I:"
AlltheI=zeros(AmountofI,1);
%Random variables for the for loop
y=1;
what=1;
%Run through Test1 and everytime the "I:" and "Subject:" appears we add the
%line number to AlltheI and AlltheEnd-4 (4 lines above)
for i=10:length(Test1)
if Test1{i}=="I:"
AlltheI(what)=i;
what=what+1;
end
if Test1{i}=="Subject:"
AlltheEnd(y)=i-4;
FirstAlltheSubject(y)=i;
y=y+1;
end
end
% Sometimes the rat doesn't have the I matrix and therefore the matrix
% contains 0, therefore we remove all the zeroes from the AlltheEnd matrix
AlltheEnd=AlltheEnd(AlltheEnd~=0);
%Create 2 cells the length of the AlltheI matrix or the amount of rats we
%have
AlltheCells=cell(1,length(AlltheI));
AlltheBCells=cell(1,length(AlltheI));
% Create a for loop that would run the same amount of rats (If there are 9
% rats' data in the excel sheets it would run 9 times
for p=1:AmountofI
    %This part of the code runs the amount of rats -1 (it would run 8 times
    %if we use the example above)
    if p<AmountofI
        %everytime we run it we create a variable of 1 
        zigzag=1;
        % we go through the I matrix of the rat but we skip the first 2
        % lines because the first 1 lines because they are 0
        for i=AlltheI(p)+2:AlltheEnd(p)
            %What this loop do:
            %We go through the I array (contain all of the IRT arrays)
            %and the C array (The Event Code array) and each IRT concide
            %with its even code and we then we would take the IRT time if
            %it has an event code of 15 or 16 and we would place the IRT
            %time in a cell in  AlltheCells and the event code in
            %AlltheBCells
            for j=3:7
                if (isa(Test1{i-(AlltheEnd(p)-AlltheI(p))-1,j},'double')) &&(Test1{i-(AlltheEnd(p)-AlltheI(p))-1,j}== 15 || Test1{i-(AlltheEnd(p)-AlltheI(p))-1,j}== 16)
                AlltheCells{p}(zigzag,1)=Test1(i,j);
                AlltheBCells{p}(zigzag,1)=Test1(i-(AlltheEnd(p)-AlltheI(p))-1,j);
                zigzag=zigzag+1;
                end
               
               
            end
        end
     
    end
    %Basically do the same thing but with different paramenter

    if p==AmountofI
        AlltheCells{p}=Test1(AlltheI(p)+1:end,3:7);
    end
end
%Create a third cell 
newCells=cell(1,length(AlltheI));
%The orinally Test1 Cell makes all of its value a string so we have to
%convert it to double and then delete all the NaN (not a number) value
for p=1:AmountofI
    newCells{p}=str2double(string(AlltheCells{p}));
   
    newCells{p} = newCells{p}(~isnan(newCells{p}));
end
%Create arrays for the peakrate, Burstreponses, and peak time
peakrate=zeros(AmountofI,1);
Burstresponses=zeros(AmountofI,1);
peaktime=zeros(AmountofI,1);

for q=1:length(newCells)
   %newCells contain data for all the rats, we are going to go through the
   %data of each rats at a time
secondCells=cell2mat(newCells(q));
%Create a variable for the Burstreponse
Burstresponse=0;    
secondCells=sort(secondCells);
secondCells=rmmissing(secondCells);
secondCells=secondCells(secondCells~=0);
%Evertime the data (IRT time) is less than 20 we +1 to Burstreponse
for i=1 :length(secondCells)
   
    if (secondCells(i)<20)
       Burstresponse=Burstresponse+1;
    end
end
Burstresponses(q)=Burstresponse;
%Create an array of zeros the length of amount of IRT time for the rat-
%Burst reponse
nonBurst=zeros(length(secondCells)-Burstresponse,1);
x=1;
%nonBurst now contains all of the nonBurst data for the rat
for i=1:length(secondCells)
    if(secondCells(i)>20)
        nonBurst(x)=secondCells(i);
        x=x+1;
    end
end
%Find the max IRT time
maxNumber=max(nonBurst);
%Create another cell Array length of the amount of I/rat
cellA=cell(1,AmountofI);

for i=1:length(cellA)
    %Create matrix A that has the length of all the nonburst
 
   A=zeros(length(nonBurst),1);
   %This loop basically seperates all of the Non-Burst to sections of
   %between 100-200, 200-300, 300-400,etc
   for j=1:length(nonBurst)
       if(nonBurst(j)>(i+1)*100)&&(nonBurst(j)<(i+2)*100)
           A(j)=nonBurst(j);
       end
   end
   %remove all the zeros
   B=A(A~=0);
   %put the cell in CellA
   cellA(i)={B};
end
%From here 
T=zeros(length(cellA)-3,1);
for i=1:length(cellA)-3
    frequency=0;
    for j=i:i+3
        frequency=length(cellA{j})+frequency;
    end
    T(i)=frequency;
end
% To here is to find the section with the most number of data
% T is a matrix that counts the number of data each sections has
R=find(max(T));
k=0;
%we Create k to be the amount of data in the max data section and the next
%3
for i=R:R+3
    k=length(cellA{i})+k;
end
% Create an Array of amount k
%MaxEpoch contains all of the data in the most numbered section + next 3 section
maxEpoch=zeros(1,k);
k=1;
for i=R:R+3
   for j=1:length(cellA{i})
       maxEpoch(k)=cellA{i}(j);
       k=k+1;
   end
end
%We then find the peakrate annd peaktime. 
peakrate(q)=(k-1)/4;  
peaktime(q)=median(maxEpoch)/100;
end
NewSubjectsAmount=0;
for i=1:length(Test1)
if Test1{i}=="Subject:"
NewSubjectsAmount=NewSubjectsAmount+1;
end
end
RatNumbers=zeros(NewSubjectsAmount,1);
%Finding the rat number
xy=1;
for i=1:length(Test1)
if Test1{i}=="Subject:"
RatNumbers(xy)=Test1{i,2};
xy=xy+1;
end
end
LocationsoftheB=zeros(1,NewSubjectsAmount);
Bx=1;
for i=1:length(Test1)
if Test1{i}=="B:"
LocationsoftheB(Bx)=i;
Bx=Bx+1;
end
end
AlltheActive=zeros(NewSubjectsAmount,1);
AlltheInAct=zeros(NewSubjectsAmount,1);
Xc=1;
% From the B: we grab the active and inactive data
for i=1:length(Test1)
if Test1{i}=="B:"
   
AlltheActive(Xc)=(Test1{i+1,5});
AlltheInAct(Xc)=(Test1{i+1,6});
Xc=Xc+1;
end
end
%From the F: line we grab the rewards
qq=1;
Rewards=zeros(NewSubjectsAmount,1);
for i=1:length(Test1)
if Test1{i}=="F:"
Rewards(qq)=Test1{i,2};
qq=qq+1;
end
end
%We find Efficiency and modified through manipulations of the matrix of
%rewards, active, and burstreponse
Eff=zeros(NewSubjectsAmount,1);
ModEff=zeros(NewSubjectsAmount,1);
for i=1:NewSubjectsAmount
    Eff(i)=Rewards(i)/AlltheActive(i);
    ModEff(i)=Rewards(i)/(AlltheActive(i)-Burstresponses(i));
end
%output the data
Tablez=table(RatNumbers,AlltheActive,AlltheInAct,Rewards,Burstresponses,Eff,ModEff,peakrate,peaktime,'VariableNames',{'RatNumbers','Active','Inactive','Rewards','Burst','Efficiency','Modified_Efficiency','PeakRate','Peaktime'});
FileName=strcat(Test2,'_result.xlsx');
writetable(Tablez,FileName);
end
