# Design Document

## Scope
This SQL database would be the part of the biggest project making learning the piano easier for beginners and encouraging children to learn in a fun way. Created for many userts to store and play music for example midi file, includes:
* users and their data( username, password, favorites music),
* music files and information about them (authors, versions etc.),
* allows you to add music to your favorites list,
* this database does not allow for interaction between users.

The idea for this database is to have a simple structure. Allows you to share selected midi files to another device via Bluetooth. The favorites table allows quick and intuitive access to the most frequently used files and information related to them. The  view of user_favorites allows quick access to favorite titles by asking for user_name. Aadding versions helps the user quickly distinguish the same songs. Level determines the degree of difficulty of these songs in relation to playing them on the piano with which the application will ultimately be connected. Users can create multiple accounts within one device, choose their own favorite songs and add them to the list independently of each other. It is created mainly for parents of children, not all of whom have their own phone and application.

## Functional Requirements
The user should be able to view, add, edit and delete songs.
The user shoud create their own playlists based on their preferences.
The user cannot see other users' data and modify the database structure.
Data remains within one device, but the application may differ depending on who uses it.
Each user can add music to "musics", but adding to "favorites" is individual.

## Representation

Entities are captured in SQLite tables with the following schema.

### Entities

#### Users
    "id" which specifies the unique ID for the users as an `INTEGER`. This column has the `PRIMARY KEY` constraint applied.
    "user_name"  has a type TEXT is appropriate for name. NOT NULL and UNIQUE completing the uniqe username field is necessary to distinguish users and to logon.
    "password" has a type TEXT  is appropriate for passwords. NOT NULL is a necessary condition for logon.

#### Musics
	"id" which specifies the unique ID for the music as an `INTEGER`. This column has the `PRIMARY KEY` constraint applied.
	"title" has a type TEXT is appropriate for title. NOT NULL the title is essential for the user.
	"author_id" has a type INTEGER is appropriate for ID. This column has the FOREIGN KEY.
	"file" has a type BLOB is suitable for large files e.g. midi or mp3 file NOT NULL is essential of use.
	"version" has a type TEXT is appropriate for small note. NOT NULL will help the user distinguish between two versions with the same title and author.
	"level" has a type TEXT is appropriate for one word. NOT NULL necessary to determine the level of advancement. CHECK ("level" IN ('basic', 'medium', 'advanced')) intuitive choice from among 3 options.

#### Authors
	"id" which specifies the unique ID for the music as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
	"name" has a type TEXT is approprite for name. NOT NULL, if there is no author name, the id is unnecessary.

#### Favorites
    This teble is created to connect users and their favorites songs, and provides quick access to  the most frequently used ones. It contain two FOREIGN KEY (INTEGER).

#### Users_password_change
    "id" " which specifies the unique ID  as an `INTEGER` to identify the record. This column thus has the `PRIMARY KEY` constraint applied.
	"user_id" has a type INTEGER is appropriate for ID. This column has the FOREIGN KEY.
    "old_password" has a type TEXT is appropriate for passwords,
    "new_password" has a type TEXT is appropriate for passwords NOT NULL is a necessary condition for logon,

#### Download_music
    "id"  which specifies the unique ID  as an `INTEGER` to identify the record. This column thus has the `PRIMARY KEY` constraint applied,
    "music_title" has a type TEXT is appropriate for title NOT NULL the title is essential for the user.
    "download_date" has a type TIMESTAMP specifies when the download occurred DEFAULT CURRENT_TIMESTAMP default current time,

### Relationships
 * One user is capable of making 0 to many favorites. A favorite is made by one user.
 * Music can be added to favorites but do not have to, so this is  0 to many. Favorites have to at least one music, but can have many, so this is 1 to many.
 * Music sometimes have known author so this is 0 to many, but author have to at last one music, so it is 1 to many.

## Optimizations
I added two indexes to this database. Fist index optymizes by user name search. It reduces search time when we need information about user. Second index optymizes by music's title. Query about title will be the most frequently asked in this database. The introduction of this index was crucial for the optimization of this database.
I add one view "user_favorites". Creating a favorites view allowed for quick access to the list of the user's favorite songs it will be helpfull when user use the aplication.

## Limitations
The current schema assumes individual creating favorites list. Collaborative favorites list would require a shift to a many-to-many relationship between users and favorites. Users cannot communicate or connect with each other. To provide this possibility, it would be necessary to create an additional table.
