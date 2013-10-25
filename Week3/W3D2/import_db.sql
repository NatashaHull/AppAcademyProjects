CREATE TABLE users (
	id INTEGER PRIMARY KEY,
	fname VARCHAR(20) NOT NULL,
	lname VARCHAR(20) NOT NULL
);

CREATE TABLE questions (
	id INTEGER PRIMARY KEY,
	title VARCHAR(140) NOT NULL,
	body VARCHAR(500) NOT NULL,
	user_id INTEGER NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
	id INTEGER PRIMARY KEY,
	question_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
	id INTEGER PRIMARY KEY,
	body VARCHAR(140) NOT NULL,
	question_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	reply_id INTEGER,
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
	id INTEGER PRIMARY KEY,
	question_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE tags (
	id INTEGER PRIMARY KEY,
	name VARCHAR(15) NOT NULL
);

CREATE TABLE question_tags (
	id INTEGER PRIMARY KEY,
	question_id INTEGER NOT NULL,
	tag_id INTEGER NOT NULL,
	FOREIGN KEY (question_id) REFERENCES questions(id),
	FOREIGN KEY (tag_id) REFERENCES tags(id)
);

INSERT INTO
	users (fname, lname)
VALUES
	('Jane', 'Doe'),
	('John', 'Buck'),
	('Malcolm', 'Reynolds');

INSERT INTO
	questions (title, body, user_id)
VALUES
	('SQL Installation', 'Why do you only have instructions for OSX?',
	(SELECT id FROM users WHERE lname = 'Reynolds' AND fname = 'Malcolm')),
	('Singleton', 'How do I user singleton?',
	(SELECT id FROM users WHERE lname = 'Doe' AND fname = 'Jane')),
	('JOIN statements', 'Is RIGHT JOIN the same as RIGHT OUTER JOIN?',
	(SELECT id FROM users WHERE lname = 'Buck' AND fname = 'John'));

INSERT INTO
	question_followers (question_id, user_id)
VALUES
	((SELECT id FROM questions WHERE title = 'SQL Installation'),
	(SELECT id FROM users WHERE fname = 'Jane' AND lname = 'Doe')),
	((SELECT id FROM questions WHERE title = 'JOIN statements'),
	(SELECT id FROM users WHERE fname = 'Jane' AND lname = 'Doe')),
	((SELECT id FROM questions WHERE title = 'JOIN statements'),
	(SELECT id FROM users WHERE fname = 'Malcolm' AND lname = 'Reynolds'));

INSERT INTO
	replies (body, question_id, user_id)
VALUES
	('Yes',
	(SELECT id from questions WHERE title = 'JOIN statements'),
	(SELECT id from users WHERE fname = 'Malcolm' AND lname = 'Reynolds'));

INSERT INTO
	replies (body, question_id, user_id, reply_id)
VALUES
	('I agree with Mal',
	(SELECT id FROM questions WHERE title = 'JOIN statements'),
	(SELECT id FROM users WHERE fname = 'Jane' AND lname = 'Doe'),
	(SELECT id FROM replies WHERE body = 'Yes'));

INSERT INTO
	question_likes (question_id, user_id)
VALUES
	((SELECT id FROM questions WHERE title = 'SQL Installation'),
	(SELECT id FROM users WHERE fname = 'Jane' AND lname = 'Doe'));

INSERT INTO
	tags (name)
VALUES
	("html"),
	('css'),
	('ruby'),
	('javascript');

INSERT INTO
	question_tags (question_id, tag_id)
VALUES
	((SELECT id FROM questions WHERE title = 'Singleton'),
	(SELECT id FROM tags WHERE name = 'ruby')),
	((SELECT id FROM questions WHERE title = 'JOIN statements'),
	(SELECT id FROM tags WHERE name = 'ruby')),
	((SELECT id FROM questions WHERE title = 'SQL Installation'),
	(SELECT id FROM tags WHERE name = 'javascript'));