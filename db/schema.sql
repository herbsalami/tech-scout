BEGIN;

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS following;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS interests;
DROP TABLE IF EXISTS userInterestEdge;
DROP TABLE IF EXISTS eventInterestEdge;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(64) NOT NULL,
  title VARCHAR(64) DEFAULT '',
  password VARCHAR(64) NOT NULL,
  email VARCHAR(100),
  img_url VARCHAR(255) DEFAULT 'http://www.barebooks.com/wp-content/uploads/2013/10/Round-Game-Board-Blank.gif'
);

CREATE TABLE events(
  id SERIAL PRIMARY KEY,
  name VARCHAR(64) NOT NULL,
  date_created TIMESTAMP NOT NULL DEFAULT NOW(),
  description text NOT NULL,
  event_date TIMESTAMP,
  location VARCHAR(64),
  creator INTEGER REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  img_url VARCHAR(255) DEFAULT 'http://www.barebooks.com/wp-content/uploads/2013/10/Round-Game-Board-Blank.gif'
  );

CREATE TABLE interests(
  id SERIAL PRIMARY KEY,
  name VARCHAR(32) NOT NULL);

CREATE TABLE attendence(
  user_id INTEGER NOT NULL REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  event INTEGER NOT NULL REFERENCES events(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(user_id, event));

CREATE TABLE following(
  follower INTEGER NOT NULL REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  followee INTEGER NOT NULL REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(follower, followee));
CREATE INDEX follower_idx ON following(follower);
CREATE INDEX followee_idx ON following(followee);

CREATE TABLE userInterestEdge(
  user_id INTEGER NOT NULL REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
  interest INTEGER NOT NULL REFERENCES interests(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(user_id, interest));

CREATE TABLE eventInterestEdge(
  event INTEGER NOT NULL REFERENCES events(id) ON UPDATE CASCADE ON DELETE CASCADE,
  interest INTEGER NOT NULL REFERENCES interests(id) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(event, interest));

COMMIT;
