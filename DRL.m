%This Code functions as an extraction of all the DRL/FR files within the
%lab and extract all the necessary data (such as RatNumbers AlltheActive
%AlltheInAct Rewards Burstresponses Eff ModEff peakrate peaktime). Some
%were already within the excel file under certain symbols while others
%needed mathematically manipulation. 

prompt= 'Name of file: ';
Test1=input(prompt);
FirstAmountofSubjects=0;
AmountofI=0;
for i=10:length(Test1)
if Test1{i}=="I:"
AmountofI=AmountofI+1;
end
if Test1{i}=="Subject:"
FirstAmountofSubjects=FirstAmountofSubjects+1;
end
end
FirstAlltheSubject=zeros(FirstAmountofSubjects,1);
AlltheEnd=zeros(FirstAmountofSubjects,1);
AlltheI=zeros(AmountofI,1);
y=1;
what=1;
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
AlltheEnd=AlltheEnd(AlltheEnd~=0);
AlltheCells=cell(1,length(AlltheI));
AlltheBCells=cell(1,length(AlltheI));
for p=1:AmountofI
    if p<AmountofI
        zigzag=1;
        for i=AlltheI(p)+2:AlltheEnd(p)
            for j=3:7
                if (isa(Test1{i-(AlltheEnd(p)-AlltheI(p))-1,j},'double')) &&(Test1{i-(AlltheEnd(p)-AlltheI(p))-1,j}== 15 || Test1{i-(AlltheEnd(p)-AlltheI(p))-1,j}== 16)
                AlltheCells{p}(zigzag,1)=Test1(i,j);
                AlltheBCells{p}(zigzag,1)=Test1(i-(AlltheEnd(p)-AlltheI(p))-1,j);
                zigzag=zigzag+1;
                end
               
               
            end
        end
     
    end

    if p==AmountofI
        AlltheCells{p}=Test1(AlltheI(p)+1:end,3:7);
    end
end
newCells=cell(1,length(AlltheI));
for p=1:AmountofI
    newCells{p}=str2double(string(AlltheCells{p}));
   
    newCells{p} = newCells{p}(~isnan(newCells{p}));
end
peakrate=zeros(AmountofI,1);
Burstresponses=zeros(AmountofI,1);
peaktime=zeros(AmountofI,1);
for q=1:length(newCells)
newfile=cell2mat(newCells(q));
Burstresponse=0;    
newfile=sort(newfile);
newfile=rmmissing(newfile);
newfile=newfile(newfile~=0);
for i=1 :length(newfile)
   
    if (newfile(i)<20)
       Burstresponse=Burstresponse+1;
    end
end
Burstresponses(q)=Burstresponse;
file2=zeros(length(newfile)-Burstresponse,1);
x=1;
for i=1:length(newfile)
    if(newfile(i)>20)
        file2(x)=newfile(i);
        x=x+1;
    end
end
maxNumber=max(file2);
cellA=cell(1,AmountofI);
for i=1:length(cellA)
   A=zeros(length(file2),1);
   for j=1:length(file2)
       if(file2(j)>(i+1)*100)&&(file2(j)<(i+2)*100)
           A(j)=file2(j);
       end
   end
   B=A(A~=0);
   cellA(i)={B};
end
T=zeros(length(cellA)-3,1);
for i=1:length(cellA)-3
    frequency=0;
    for j=i:i+3
        frequency=length(cellA{j})+frequency;
    end
    T(i)=frequency;
end
R=find(max(T));
k=0;
for i=R:R+3
    k=length(cellA{i})+k;
end
maxEpoch=zeros(1,k);
k=1;
for i=R:R+3
   for j=1:length(cellA{i})
       maxEpoch(k)=cellA{i}(j);
       k=k+1;
   end
end
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
for i=1:length(Test1)
if Test1{i}=="B:"
   
AlltheActive(Xc)=(Test1{i+1,5});
AlltheInAct(Xc)=(Test1{i+1,6});
Xc=Xc+1;
end
end

qq=1;
Rewards=zeros(NewSubjectsAmount,1);
for i=1:length(Test1)
if Test1{i}=="F:"
Rewards(qq)=Test1{i,2};
qq=qq+1;
end
end
Eff=zeros(NewSubjectsAmount,1);
ModEff=zeros(NewSubjectsAmount,1);
for i=1:NewSubjectsAmount
    Eff(i)=Rewards(i)/AlltheActive(i);
    ModEff(i)=Rewards(i)/(AlltheActive(i)-Burstresponses(i));
end
FinalCells=[RatNumbers AlltheActive AlltheInAct Rewards Burstresponses Eff ModEff peakrate peaktime];
prompt= 'Name of output file: ';
final_file=input(prompt, 's');
xlswrite(final_file,FinalCells);
