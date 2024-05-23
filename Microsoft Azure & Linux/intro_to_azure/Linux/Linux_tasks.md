# Linux tasks

- [Linux tasks](#linux-tasks)
- [Task 2.8a: Linux - Research managing file ownership](#task-28a-linux---research-managing-file-ownership)
  - [Why is managing file ownership important?](#why-is-managing-file-ownership-important)
  - [What is the command to view file ownership?](#what-is-the-command-to-view-file-ownership)
  - [What permissions are set when a user creates a file or directory? Who does file or directory belong to?](#what-permissions-are-set-when-a-user-creates-a-file-or-directory-who-does-file-or-directory-belong-to)
  - [Why does the owner, by default, not receive X permissions when they create a file?](#why-does-the-owner-by-default-not-receive-x-permissions-when-they-create-a-file)
  - [What command is used to change the owner of a file or directory?](#what-command-is-used-to-change-the-owner-of-a-file-or-directory)
- [2.8b Research managing file ownership](#28b-research-managing-file-ownership)
  - [Does being the owner of a file mean you have full permissions on that file?](#does-being-the-owner-of-a-file-mean-you-have-full-permissions-on-that-file)
  - [If you give permissions to the User entity, what does this mean?](#if-you-give-permissions-to-the-user-entity-what-does-this-mean)
  - [If you give permissions to the Group entity, what does this mean?](#if-you-give-permissions-to-the-group-entity-what-does-this-mean)
  - [If you give permissions to the Other entity, what does this mean?](#if-you-give-permissions-to-the-other-entity-what-does-this-mean)
  - [You give the following permissions to a \[file: Use\](file: Us "‌")r permissions are read-only, Group permissions are read and write, Other permissions are read, write and execute. You are logged in as the user which is owner of the file. What permissions will you have on this file? Explain.](#you-give-the-following-permissions-to-a-file-usefile-us-r-permissions-are-read-only-group-permissions-are-read-and-write-other-permissions-are-read-write-and-execute-you-are-logged-in-as-the-user-which-is-owner-of-the-file-what-permissions-will-you-have-on-this-file-explain)
  - [Here is one line from the ls -l. Work out everything you can about permissions on this file or directory.](#here-is-one-line-from-the-ls--l-work-out-everything-you-can-about-permissions-on-this-file-or-directory)
- [Task 2.8c: Linux - Research managing file permissions using numeric values ](#task-28c-linux---research-managing-file-permissions-using-numeric-values-)
  - [What numeric values are assigned to each permission?](#what-numeric-values-are-assigned-to-each-permission)
  - [What can you with the values assign read + write permissions?](#what-can-you-with-the-values-assign-read--write-permissions)
    - [What value would assign read, write and execute permissions?](#what-value-would-assign-read-write-and-execute-permissions)
    - [What value would assign read and execute permissions?](#what-value-would-assign-read-and-execute-permissions)
    - [Often, a file or directory's mode/permissions are represented by 3 numbers. What do you think 644 would mean?](#often-a-file-or-directorys-modepermissions-are-represented-by-3-numbers-what-do-you-think-644-would-mean)
- [Task 2.8d: Linux - Research changing file permissions](#task-28d-linux---research-changing-file-permissions)
  - [What command changes file permissions?](#what-command-changes-file-permissions)
  - [To change permissions on a file what must the end user be? ](#to-change-permissions-on-a-file-what-must-the-end-user-be-)
  - [Give examples of some different ways/syntaxes to set permissions on a new file (named testfile.txt) to:](#give-examples-of-some-different-wayssyntaxes-to-set-permissions-on-a-new-file-named-testfiletxt-to)
    - [Set User to read, Group to read + write + execute, and Other to read and write only:](#set-user-to-read-group-to-read--write--execute-and-other-to-read-and-write-only)
  - [Add execute permissions (to all entities):](#add-execute-permissions-to-all-entities)
  - [Take write permissions away from Group:](#take-write-permissions-away-from-group)
- [References](#references)

# Task 2.8a: Linux - Research managing file ownership

## Why is managing file ownership important?
Managing files is very important because it is pivotal concerning fill access and therefore maintanance of security.  
* Accountability - File changes can be tracked.
* Control - Admins can control who can do what.


## What is the command to view file ownership?
The command is:
``` 
ls -l
``` 


## What permissions are set when a user creates a file or directory? Who does file or directory belong to?

By default, When new files are created the permissions given are: rw-rw-r– . The r, w, and x signify the read, write, and execute permissions.


## Why does the owner, by default, not receive X permissions when they create a file?
This is for safeguarding reasons, to ensure the file is not tampered with in a way that could pose security risks or deletion.

## What command is used to change the owner of a file or directory?
Chown is used. It stands for Change owner

``` 
#command below changes the owner of the film called program.py to morgan
chown morgan program.py
``` 

# 2.8b Research managing file ownership

rw       -rw     -r–
Owner - group -other

## Does being the owner of a file mean you have full permissions on that file? 
No, not technically, although you have all others, you do not have executable permissions by default.

## If you give permissions to the User entity, what does this mean?

The owner of the file is the **user**, this is usually the creator of the file gets  rw-rw-r–

## If you give permissions to the Group entity, what does this mean?

There is usually a **group** that consists of users. Joint ownership of a file decided the permissions given to group members. 


## If you give permissions to the Other entity, what does this mean?
A user can be related to more than group. It should be noted that you can also be niether an owner or group member, in this case you would be considered an **other**.

## You give the following permissions to a [file: Use](file: Us "‌")r permissions are read-only, Group permissions are read and write, Other permissions are read, write and execute. You are logged in as the user which is owner of the file. What permissions will you have on this file? Explain.

The file permissions will be read, write, and execute (rwx)
The  owner or **user** permission as read-only (r).
However, since you are logged in as the owner of the file, a special rule applies. 
File system permissions check your category first.
By default The owner (you) always has full control , therefore, means you can read, write, and execute the file.

## Here is one line from the ls -l. Work out everything you can about permissions on this file or directory.
Group is called staff, staff have read and execute but not write.

-rwxr-xr-- 1 tcboony staff  123 Nov 25 18:36 keeprunning.sh
- first hyphen means file
- after that rwx means read, write, execute <the first 3 letters are user
- second 3 are r - x for group (read, not write, execute) <second are group>
  last 3 are for other they have (read, not write, not execute)<third are other (everyone else)>

# Task 2.8c: Linux - Research managing file permissions using numeric values <br>
## What numeric values are assigned to each permission?

Read (r): 4 <br>
Write (w): 2 <br>
Execute (x): 1 <br>


## What can you with the values assign read + write permissions?

Read (r): 4 <br>
Write (w): 2 <br>
Therefore, to represent read and write permissions (r + w), you would add the corresponding values:

Read + Write (r + w): 4 + 2 = 6
So, the numeric value 6 represents read and write permissions in Linux.

With this permission level, you can perform the same actions as described previously:

Read (r):

View the file contents . <br>
List the contents of a directory. <br>
Access information about the file. <br>
<br>
Write (w): <br>

Modify the content of the file. <br>
Create new files within a directory. <br>
Delete or rename files within a directory (provided you have the necessary permissions). <br>



### What value would assign read, write and execute permissions?

7


### What value would assign read and execute permissions?
5

### Often, a file or directory's mode/permissions are represented by 3 numbers. What do you think 644 would mean?
6 = read and write -->user
4 = read Group
4 = read other

# Task 2.8d: Linux - Research changing file permissions

## What command changes file permissions?
chmod can be used to change file permissions. <br>
``` 
# remove group write access to readme.txt
chmod g-w readme.txt 

``` 
<br>

## To change permissions on a file what must the end user be? <br>
To change file permissions only two types of end users have the power to change permissions. The end user must be either a: <br>
* A superuser <br>
* The current file owner. <br>

## Give examples of some different ways/syntaxes to set permissions on a new file (named testfile.txt) to:
### Set User to read, Group to read + write + execute, and Other to read and write only:

  * chmod u+r, g+rwx, o+rw testfile.txt <br>
  * chmod u=r,g=rwx,o=rw testfile.txt <br>

  
## Add execute permissions (to all entities):

  ```
  * chmod a+x testfile.txt
  ```
  

## Take write permissions away from Group:

```
chmod g-w testfile.txt
```

Use numeric values to give read + write access to User, read access to Group, and no access to other.


640
``` 
chmod 640 testfile.txt
``` 

# References
please see references for info below

* https://www.baeldung.com/linux/new-files-dirs-default-permission#:~:text=The%20operations%20that%20a%20user,%2C%20and%20execute%20permissions%2C%20respectively.<br>
https://www.ibm.com/docs/en/aix/7.2?topic=c-chown-command#:~:text=Description,group%20can%20also%20be%20specified.<br>
* https://www.maths.cam.ac.uk/computing/linux/unixinfo/perms#:~:text=644%20means%20you%20can%20read,users%20can%20only%20read%20it.<br>
* https://www.theserverside.com/blog/Coffee-Talk-Java-News-Stories-and-Opinions/how-permissions-chmod-with-numbers-command-explained-777-rwx-unix <br>
* https://docs.oracle.com/cd/E19683-01/816-4883/6mb2joat4/index.html#:~:text=Only%20the%20current%20owner%20or,on%20a%20file%20or%20directory.






