% This is a general example that runs to recieve and send emails from
% matlab
% __________________________________________
% USAGE:
% sk_matlab_mail_access_wrapper();
% __________________________________________
% Input:
% Modify as required
% __________________________________________
% Output:
% Modify as required
%
% ****************************************
% author: Saurabh Kumar
% ****************************************
%

run_condition = 1;

while run_condition
    try
        command = strcat('env LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/libcurl.so.4" curl -','u username:password --silent "https://mail.google.com/mail/feed/atom" | tr -d ''\n'' | awk -F ''<entry>'' ''{for (i=2; i<=NF; i++) {print $i}}'' | perl -pe ''s/^<title>(.*)<\/title>.*<name>(.*)<\/name>.*$/$2 - $1/''' );
        [~,cmdout] = unix(command);
        if contains(cmdout,'stop') % in order to stop completely
            break;
        end
        if ~contains(cmdout,'previous_result') % stop if alreaday run (optional)
            if contains(cmdout,'keyword')
                % get parameters for the function associated with the
                % keyword
                parameter_1 = strfind(cmdout,'parameter_1');
                parameter_2 = strfind(cmdout,'parameter_2');
                % email that the code is running
                skmail = [];
                skmail.title='keyword function is running...';
                skmail.body='input parameters were accepted';
                sk_mail_send_example(skmail);
                disp('running message sent');
                keyword_function(parameter_1,parameter_2);
            end
        end
    catch
        % not runnung email in case of unaccepted input parameters
        command = strcat('env LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/libcurl.so.4" curl -','u username:password --silent "https://mail.google.com/mail/feed/atom" | tr -d ''\n'' | awk -F ''<entry>'' ''{for (i=2; i<=NF; i++) {print $i}}'' | perl -pe ''s/^<title>(.*)<\/title>.*<name>(.*)<\/name>.*$/$2 - $1/''' );
        [~,cmdout] = unix(command);
        if ~contains(cmdout,'keyword function NOT running...')
            skmail = [];
            skmail.title='keyword function NOT running...';
            skmail.body='Please check and re-enter the parameters correctly. example format : how to enter';
            sk_mail_send_example(skmail);
            disp('not running message sent');
        end
    end
end

% message after stopping
skmail = [];
skmail.title='matlab stopped execution';
skmail.body='Please log on to the server to restart the matlab execution if required';
sk_mail_send_example(skmail);
disp('matlab stopped execution');
%
%