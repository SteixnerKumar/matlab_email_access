# Contents
## [matlab_email_access](https://github.com/saurabhsay/matlab_email_access/blob/master/README.md#matlab_email_access-1)
## [Softwares and tools needed](https://github.com/saurabhsay/matlab_email_access/blob/master/README.md#softwares-and-tools needed-1)
## [Notes](https://github.com/saurabhsay/matlab_email_access/blob/master/README.md#notes-1)
## [Procedure](https://github.com/saurabhsay/matlab_email_access/blob/master/README.md#procedure-1)

# matlab_email_access
Access matlab (potentially other softwares) through email. Extend their functionality and practicality some some specific cases

If you wanna check your scripts run from around the world and make some changes to it on the go without the hassel of the vpn.

The idea of this script came to me when I was travelling in different time zones and did not always have the convinience to connect to the server at work with a laptop. I thought there has to be a different solution to this specific problem as my work was time-critical since the servers at work are shared with other collegues and you don't wanna annoy everyone by hogging the server for days and in reality using it at specific times. Basically optimizing the time with the server access.

I do not claim it to be the best solution but it has definitely saved me a lot of headache and frustation over and over again.

So please read on and use it at you own convinience.
###### [Back to Contents](https://github.com/saurabhsay/matlab_email_access/blob/master/README.md#Contents)

# Softwares and tools needed
Here are the softwares combinations I used, but this technique can be used to access other softwares as well.

+ MATLAB Version: 9.3.0.713579 (R2017b)
+ Operating System: Linux 4.9.0-8-amd64 #1 SMP Debian 4.9.110-3+deb9u4 (2018-08-21) x86_64
+ Java Version: Java 1.8.0_121-b13 with Oracle Corporation Java HotSpot(TM) 64-Bit Server VM mixed mode
+ 'curl' stable version 7.63.0, used in command lines or scripts to transfer data
+ gmail (a free email service developed by Google LLC (subsidiary of Alphabet Inc.))
+ Simple Mail Transfer Protocol (SMTP), an Internet standard for email transmission. (defined by Request for Comments RFC 821, updated with Extended SMTP additions by RFC 5321)

# Notes
I use "Debian GNU/Linux 9 (stretch)", the 9th Debian with a Matlab version 9.3.0.713579. There is an issueof  incompatibility between the libstdc++ shipped with MATLAB and the libstdc++ shipped with the system. To solve it for me I used the following command before starting my matlab with or without the Java Desktop.
```shell
LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libstdc++.so.6" matlab
```
In practical terms, I will need access from matlab to the linux terminal, and I can only have it if I have initialted the above mentioned command. In case you are using the Debian 8 system with the same matlab version then this command is not necesary as they are compatible. In short, the usage of this command is not compulsary but if used will make sure that the terminal is accessible from matlab.

Another issue I ran into was the compatibility of the client-side URL transfer library with the debian 9 system and again it could be solved by pointing to the correct library path. The following command will do this.
```shell
env LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu/libcurl.so.4" curl -
```
Again, maybe depending of the system or versions of the libraries and tools this step may also not be necessary, but it will make sure that the curl script will run smoothly.

# Procedure
All the examples written below are from an example code that available in this repository.

There is an example file named 'sk_matlab_mail_access_wrapper.m', this file gives the flow of the code. How to read mail and get the parameters, maybe modify these obtained parameters. Use these parameters to run a specific keyword function and then give the output back again through mail.

In addition to the wrapper there are two more functions that have a code example to send and recieve mail via matlab. Before these examples can be used we need to set up the access so please read through this file in order to run it smoothly.

+ **Recieve email**

To recieve mail you have to access the linux terminal via matlab. There is a function that enables us to do this - `unix()`. At the termical we can use the curl snippet to access our mail server and list all the mails. This is configurable - One can list all the unread mail, all the mail, only the unread mail subject lines, ..etc. You get the idea!
```shell
curl -','u username:password --silent "https://mail.google.com/mail/feed/atom" | tr -d ''\n'' | awk -F ''<entry>'' ''{for (i=2; i<=NF; i++) {print $i}}'' | perl -pe ''s/^<title>(.*)<\/title>.*<name>(.*)<\/name>.*$/$2 - $1/''
```
The above code lists all the unread mail subject lines from a gmail mail server. One can use:
```shell
 [~,cmdout] = unix(command);
 ```
 to print the output into matlab and then search for a particular keyword with the command:
```shell
 contains(cmdout,'keyword');
 ```
 Incase the keyword matches the function you want to use you can go ahead and run the code. There is not limit as to how you can manipulate this feature. You can have different keywords for running different function in matlab with their own parameters and even keywords to stop the script in matlab or start a new one.

+ **Send email**

Today, the mail servers are advanced enough and use a standard encryption format of end-to-end TLS/SSL. There are some parameters that are attached to use this protocol. In matlab there is a function 'sendmail' that is configured for the unencrypted connection by default, hence we can use some snippet of code to add these extra required parameters for our purpose. Please make sure that you use the correct settings sepending upon the mail server desired. Here I will show an example of using 'gmail' since it is widely used and I found it quite easy to make it work. Depepnding upon the mail server you can find different server names, server authentication formats and ports. There is an online list without warranty [here](https://www.arclab.com/en/kb/email/list-of-smtp-and-pop3-servers-mailserver-list.html).

![sendmail example](https://github.com/saurabhsay/matlab_email_access/blob/master/images/mail_send.jpg)

Another step needed for this to work is to make the mail account less secure. I created another seperate mail account for the purpose of sending mails through matlab, this way I do not have to compromise on my normal mail account and I would highly suggest to do this. As an example I will post the following picture that guides you to make the mail server accessible through less secure apps, in our case Matlab. [Link here](https://support.google.com/accounts/answer/6010255?hl=en)

![mail unsecure example](https://github.com/saurabhsay/matlab_email_access/blob/master/images/mail_unsecure.jpg)

+ **mail server view**

This is an example as how your mail will look if you have been using this as me.

![mail view example](https://github.com/saurabhsay/matlab_email_access/blob/master/images/mail_display.jpg)



