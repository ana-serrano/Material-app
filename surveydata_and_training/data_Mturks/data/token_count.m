list = dir('*.json');
for i=1:length(list)
    tokens{i} = list(i).name(1:end-5);
end
xlswrite('tokens.xls',tokens',1);  