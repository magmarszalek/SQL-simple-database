-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

--user favorite with view
SELECT "title" FROM "user_favorites"
WHERE "user_name"='admin';

--music search by author
SELECT "id", "title" FROM "musics"
WHERE "author_id" =(
    SELECT "id" FROM "authors"
    WHERE "name"='John Lennon'
);

--music search by level
SELECT "id", "title", "version" FROM "musics"
WHERE "level" ='basic';

--add music, checking trigger
INSERT INTO "musics" ("title", "author_id", "file", "version", "level")
VALUES ('Bee', 1, 'cat.mp3', 'my favorite', 'advanced');

--checking result
SELECT * FROM "download_music";

--update admin password
UPDATE "users"
SET
    "id"=1,
    "user_name"='admin',
    "password"='oops!5'
WHERE "id"=1;

--checking result
SELECT * FROM "users_password_change";
