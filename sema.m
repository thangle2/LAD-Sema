
name='section 4 1.28.xlsx';
[~,sheet_name]=xlsfinfo(name);
for k=1:numel(sheet_name)
  [number,txt,data{k}]=xlsread(name,sheet_name{k});
end
Sheetnames=sheetnames(name);
Sheetnames=Sheetnames(1:length(Sheetnames)-1);
Marker=zeros(length(sheet_name)-1,8);
for z=1:length(sheet_name)-1
    A=data{z};
    for i=1:length(data{z})-1
        if (string((A(i)))=="Positive ") && (string(A(i+1))=="Category")
            Marker(z,1)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Marker 3 ") && (string(A(i+1))=="Category")
            Marker(z,2)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Marker 5 ") && (string(A(i+1))=="Category")
            Marker(z,3)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Marker 6 ") && (string(A(i+1))=="Category")
            Marker(z,4)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Marker 8 ") && (string(A(i+1))=="Category")
            Marker(z,5)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Marker 9 ") && (string(A(i+1))=="Category")
            Marker(z,6)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Marker 10 ") && (string(A(i+1))=="Category")
            Marker(z,7)=str2double(string(A(i+4,2)));
        end
        if (string((A(i)))=="Planimetry ") && (string(A(i+1))=="Category")
            Marker(z,8)=str2double(string(A(i+2,2)));
        end
        
         
            
    end
    
end

Marker=[Sheetnames Marker];
T=array2table(Marker,'VariableNames',{'Rat Number','Positive','Marker 3','Marker 5','Marker 6','Marker 8','Marker 9','Marker 10','Volume'});
writetable(T,name,'Sheet',numel(sheet_name))
