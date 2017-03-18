# WiFi Profile Harvesting

Author: punisherprime  
Version: 1.0

## Description

Windows stores WiFi data in profiles on the system. Given physical access you can go in and harvest this information to include the key, or password, for any stored profiles.

## Configuration

Appears to work on Windows 10 and Windows 7 workstations.
It turns out that Windows 7 needs an elevated command prompt to display the clear key or password.
Because this uses a method similar to that described in Hak5 episodes 2112, 2113, and 2114 there are CAPSLOCK blinkie lights that show you the status.  You should see the status light on the BashBunny turn green, then the CAPSLOCK light on the system or keyboard flash three times followed seconds later (at most 30 seconds) by the flashing of the CAPSLOCK three times again.

This payload includes an ability to save the data to your BashBunny and e-mail it off so you do not have to wait for those keys!

payload.txt is the BashBunny script that gives you an administrative command prompt.

d.cmd contains the start of the payload. It flashes the CAPSLOCK to let you know it is kicking off and then launches e.cmd using i.vbs. 

e.cmd contains the commands that:
     1. Creates folder structure on the BashBunny
	 2. Grabs the WiFi Profiles from the target and saves it to the BashBunny
	 3. Grabs the keys (passwords) and saves them to the BashBunny
	 4. E-mails the SSIDs and keys out
     Then it flashes the CAPSLOCK again for you so you know it is done.  
	 
Put e.cmd, d.cmd, payload.txt, and i.vbs into the SWITCH folder of your choice on the BashBunny.

SendMail.ps1 goes in the LIBRARY folder on your BashBunny. I did this so that I could reuse the code between exploits. Someone smarter than me might figure out a way to do it in one line and put it into the batch file.  SendMail.ps1 is a powershell script that kicks out the e-mail from the e.cmd batch script. You will need to replace your e-mail address and password in the SendMail.ps1 script.  If you choose to use Gmail you will need to configure Gmail to allow unsecure connections.

This payload assumes you have not changed the name of your BashBunny (it relies on the name during the execution). 


## STATUS

| LED              | Status                              |
| ---------------- | ----------------------------------- |
| RED              | The BashBunny is starting up        |
| GREEN            | The BashBunny has sent the script   |

| CAPSLOCK         | Status                              |
| ---------------- | ----------------------------------- |
| THREE BLINKS     | The payload has started.            |
| THREE BLINKS     | The payload has ended.              |
