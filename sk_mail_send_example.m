function sk_mail_send_example(skmail)
% This is a general function that sends email to
% a defined email address
% __________________________________________
% USAGE:
% skmail.title = 'title';
% skmail.body = 'body';
% sk_mail_send_example(skmail);
% __________________________________________
% Input:
% skmail -> general structure which has all the settings
% title   -> the title of the message
% body -> the body of the message
% attachment -> file name of the attachment(s)
% 
% __________________________________________
% Output:
% out -> the average number of listens for every participant
%
% ****************************************
% author: Saurabh Kumar
% ****************************************

%% basics
skmail.recipient = 'emailaddress';
% skmail.title = ;
% skmail.body = ;
% skmail.attachment = ;
% sendmail(recipient, title, body, attachments); 
try
    exist(skmail.attachment);
catch
    skmail.attachment = [];
end
 
%% settings
setpref('Internet', 'SMTP_Server',   'smtp.gmail.com');
setpref('Internet', 'SMTP_Username', 'username');
setpref('Internet', 'SMTP_Password', 'password');
 
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth',                'true');  % Note: 'true' as a string, not a logical value!
props.setProperty('mail.smtp.starttls.enable',     'true');  % Note: 'true' as a string, not a logical value!
props.setProperty('mail.smtp.socketFactory.port',  '465');   % Note: '465'  as a string, not a numeric value!
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');

%% send email
sendmail(skmail.recipient,skmail.title,skmail.body,skmail.attachment);

%%
end
