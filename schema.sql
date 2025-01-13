-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

--user table, application accounts
CREATE TABLE "users"(
	"id" INTEGER,
	"user_name" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	PRIMARY KEY ("id")
);
--supplementary tables
CREATE TABLE "authors"(
	"id" INTEGER,
	"name" TEXT NOT NULL,
PRIMARY KEY("id")
);

--table of music available in the application
CREATE TABLE "musics"(
	"id" INTEGER,
	"title" TEXT NOT NULL,
	"author_id" INTEGER,
	"file" BLOB NOT NULL,
	"version" TEXT NOT NULL,
	"level"TEXT NOT NULL CHECK ("level" IN ('basic', 'medium', 'advanced')),
PRIMARY KEY("id"),
FOREIGN KEY ("author_id") REFERENCES "authors"("id")
);



--linking table
CREATE TABLE "favorites"(
	"user_id" INTEGER,
	"music_id"INTEGER,
FOREIGN KEY("music_id") REFERENCES "musics"("id"),
FOREIGN KEY("user_id") REFERENCES "users"("id")
);

--trigger tables
CREATE TABLE "users_password_change" (
    "id" INTEGER,
	"user_id" INTEGER,
    "old_password" TEXT,
    "new_password" TEXT NOT NULL,
    PRIMARY KEY("id")
	FOREIGN KEY("user_id") REFERENCES "users"("id")
);

CREATE TABLE "download_music" (
    "id" INTEGER ,
    "music_title" TEXT NOT NULL,
    "download_date" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY("id")
);

--optimization by username and title
CREATE INDEX "user_search" ON "users"("user_name");
CREATE INDEX "title_search" ON "musics"("title");

--trigger creates a table of names of songs added by the user
CREATE TRIGGER "download"
AFTER INSERT ON "musics"
BEGIN
    INSERT INTO "download_music"("music_title")
    VALUES (NEW."title");
END;

--password change trigger
CREATE TRIGGER "user_password_change"
AFTER UPDATE OF "password" ON "users"
FOR EACH ROW
BEGIN
    INSERT INTO "users_password_change" ("user_id", "old_password", "new_password")
    VALUES (OLD."id", OLD."password", NEW."password");
END;

--view of list of favorite songs
CREATE VIEW "user_favorites" AS
SELECT "users"."id", "users"."user_name" , "musics"."title"
FROM "favorites"
JOIN "users" ON "favorites"."user_id" = "users"."id"
JOIN "musics" ON "favorites"."music_id" = "musics"."id";
