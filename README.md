# README
This is the repository for the Cantando Ingles rails website.

/                  - Landing page for Cantando Ingles. The default language
                     is :es.                   

/songs             - Lists all the songs that one can download from this website or
                 using the Android app Cantando Ingles. The default language 
                     is :es.

/admin             - /admin is only in :en             

/admin/home        - Anyone can get to this page, not just admins. If you're 
                 an Admin, Songs link is shown. 

/admin/songs/      - Lists all the songs, and each song has a 'delete'
                 and 'edit' button. Also contains a 'new song' button. Only
                 an admin named flocela@gmail.com can add, delete, or change
                 a song, or even get to this page.

/admins/signup     -admins is the directory where the Devise logic is.

database           -Tables are 'songs', 'admins', and 'download_counts'. 

                   Songs table keeps all the song attributes, which
                 mostly deal with copyright information.

                   Admins table is made by Devise, and I have mostly let 
                 Devise alone.

                   Download_Counts table keeps the number of downloads per
                 song, per month. If the song has not received any downloads
                 in a month, then it will not be added as a row.
 
has a .gitignore file in this directory CaIngWebsites/CaIng/.gitignore






















* ...
