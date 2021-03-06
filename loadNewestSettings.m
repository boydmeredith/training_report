function [settings, the_datenum] = loadNewestSettings(ratname,datenum_in)
settings = [];
the_datenum = [];

if nargin < 2
    datenum_in = [];
end
max_depth = 20;


exptr = 'Tyler';
files = [];
ii=0;
while isempty(files) & ii < max_depth
    fpatt = sprintf(['/Volumes/brody/RATTER/SoloData/Settings/%s/%s/'...
    'settings_*%s*'],...
    exptr, ratname, datestr(today-ii,'yymmdd'));
    files = dir(fpatt);
    ii = ii + 1;
end

if isempty(files)
    return 
end

date_list = [files.datenum];
if isempty(datenum_in)
    [the_datenum, date_ind] = max(date_list);
else
    date_list = datenum(datestr(date_list,29));
    [date_ind] = find(date_list==datenum_in);
    date_ind = date_ind(end);
end

settings = load(fullfile(files(date_ind).folder,files(date_ind).name));

