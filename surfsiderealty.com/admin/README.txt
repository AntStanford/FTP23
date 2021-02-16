******************************************************

  ICND CMS 2.0
  
  Authors: Jonathan Richey and Chris Johnson (2012)

******************************************************

The purpose of this document is to explain how the CMS works and how to implement it.

This version of the CMS was built using Twitter Bootstrap and the Unicorn admin template:
  
  - http://twitter.github.com/bootstrap/
  - http://wrapbootstrap.com/preview/WB0F35928
  
  You can view documentation using:
  
  - http://jonathan1.icnd.net/admin/_Unicorn-Base/documentation/
  
  Another view of the demo:
  
  - http://jonathan1.icnd.net/admin/_Unicorn-Base/html/
  
There are links to these references in the footer of the application when logged in as an 'admin'.




-------------------------------------------------------
Contents:
-------------------------------------------------------
1. Setup
2. Required Files and Folders
2. Getting Started
3. Modules
4. Options
5. Security
6. Validation


-------------------------------------------------------
1. Setup:
-------------------------------------------------------

  1. Change the dsn value in application.cfm to the DSN of your new site
  
  2. Change the navigation as needed in /components/header.cfm. If you don't need a module, comment out the nav item and the query at the top that gets the recordcount
  

-------------------------------------------------------
2. Required Files and Folders:
-------------------------------------------------------

  1. _Unicorn-Base
  2. application.cfm
  3. /boostrap
  4. /components
  5. dashboard.cfm
  6. /images
  7. index.cfm
  8. /javascripts
  9. /live-editor
  10. login.cfm
  11. /users  
  12. auth folder outside webroot; place this in same level as htdocs
    
  
-------------------------------------------------------
3. Requirements:
-------------------------------------------------------
  
   
  - At the minimum, you will need to create a 'users' table so you can login. See the 'users' folder for the SQL needed to create
    the table.

  To log into this control panel use, go to: http://jonathan1.icnd.net/admin/login.cfm
  
  email: jrichey@icoastalnet.com
  
  password: demo

  - PHOTO UPLOADS: Be sure to copy over filecheck.cfc into your new site's 'components' folder in the root. This is needed
    for any photo uploads.
    
  - Create a 'userfiles' folder in the root of the site. This is where user uploads go when using the texteditor.
  
  - Create a page_clicks table:
  
  CREATE TABLE `page_clicks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `thedate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `pageid` int(11) DEFAULT NULL,
  `remoteip` varchar(50) DEFAULT NULL,
  `cfid` varchar(255) DEFAULT NULL,
  `cftoken` varchar(255) DEFAULT NULL,
  `referrer` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=latin1;
  
  - Also, copy the sql.txt in settings folder

-------------------------------------------------------
3. Modules:
-------------------------------------------------------

Users - controls who has access to the admin control panel 

Contacts - list of contacts that come in through site 

Pages - simple page text editor with SEO abilities 

Testimonials - user and testimony 

Staff - add basic staff info with picture 

Sorter Example - drag and drop jQuery sorter can be implemented with any other module 

Coordinates - add latitude/longitude to a property which will be used for Google maps 

Photos - basic photo uploader 

Settings - manage client's basic info like address, phone, fax, etc. 

Multiple Uploads - a bare-bones module displaying how to allow for multiple-uploads that feed into a secondary photos table as opposed to using a single
table with multiple columns. This allows for endless uploads of photos and documents since each upload is recorded as a new record in the 'photos' table

Blog - the control panel for a simple blog with categories, pics and posts


-------------------------------------------------------
4. Options:
-------------------------------------------------------

  - If client wants to manage their own SEO OR if you are on the SEO team and want to display SEO fields for the Pages module,
go into the application.cfm file and set EnableSeoManagement = 'Yes'.

  - Any page that needs a texteditor - copy and paste the following snippet and place in the footer:
  
  <cfinclude template="/admin/components/texteditor.cfm">
  

-------------------------------------------------------
5. Security:
-------------------------------------------------------

Ref: http://www.oxalto.co.uk/2011/07/password-hashing-and-salting/

In order to make this app more secure, I am hashing the passwords and salting them.  I am also 
using a key found in /auth/key.txt to encrypt the salt value before storing it in the database.

Hashing is only one way, so if a user forgets their password they can only change it, not reveal the existing one.

Even if a hacker got access to the database, they would also have to compromise the filesystem in order to retrieve
the key located outside the webroot in /auth/key.txt

Be sure to copy /auth/key.txt over to the same level as htdocs in your production environment

Default login is:  ICND / ICNDrox!


-------------------------------------------------------
6. Validation:
-------------------------------------------------------

To make form fields required, simply add id="basic_validate" to any <form> tag, and then add class="required"
to your input fields.

The two required JS files, jquery.validate.js and unicorn.form_validation.js are already included in the 
footer

