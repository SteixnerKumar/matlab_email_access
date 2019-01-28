function [out] = sk_mail_read_example()
% This is a general function that sends email to
% a defined email address
% __________________________________________
% USAGE:
% sk_mail_read_example();
% __________________________________________
% Input:
% nothing specifically, but can be modified according to need.
% 
% __________________________________________
% Output:
% out -> the three parameters required (please modify the parameters as you want)
%
% ****************************************
% author: Saurabh Kumar
% ****************************************

% unix('env LD_LIBRARY_PATH='''' curl ... )
% setting the correct curl library path
command = strcat('env LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/libcurl.so.4" curl -','u username:password --silent "https://mail.google.com/mail/feed/atom" | tr -d ''\n'' | awk -F ''<entry>'' ''{for (i=2; i<=NF; i++) {print $i}}'' | perl -pe ''s/^<title>(.*)<\/title>.*<name>(.*)<\/name>.*$/$2 - $1/''' );
% command = 'curl -u username:password --silent "https://mail.google.com/mail/feed/atom" | tr -d ''\n'' | awk -F ''<entry>'' ''{for (i=2; i<=NF; i++) {print $i}}'' | perl -pe ''s/^<title>(.*)<\/title>.*<name>(.*)<\/name>.*$/$2 - $1/''';

[~,cmdout] = unix(command);

%% get the paraemters
% getting parameters from the mail subject line wxample
% parameter_1 = level
% parameter_2 = horizon
% parameter_3 = particles
command_level = strfind(cmdout,'level');
command_horizon = strfind(cmdout,'horizon');
command_particles = strfind(cmdout,'particles');
if isempty(command_level) || isempty(command_horizon) || isempty(command_particles)
    error('no command found from email');
%     skmail.title=' input parameter error';
%     skmail.body='The most likely reason is that there was a spelling mistake in the command sent OR no command';
%     sk_email(skmail);
%     disp('emailsent');
else % seperating these three parametersinto three different variables
    command_level = command_level(1);
    command_level = command_level+ 6;
    command_horizon = command_horizon(1);
    command_horizon = command_horizon + 8;
    command_particles = command_particles(1);
    command_particles = command_particles + 10;
end

% finding new line after the 'particles'
loc_new_line = find(cmdout == char(10)); % char 10 is for newline
loc_new_line = min(loc_new_line(loc_new_line>command_particles));
if isempty(loc_new_line)
    loc_new_line = length(cmdout)+1;
else
    loc_new_line = loc_new_line(1);
end

% all three parameters in the three fields of the strucure 'out'
out.level = str2double(cmdout(command_level));
out.horizon= str2double(cmdout(command_horizon));
out.particles = str2double(cmdout(command_particles:loc_new_line-1));


end