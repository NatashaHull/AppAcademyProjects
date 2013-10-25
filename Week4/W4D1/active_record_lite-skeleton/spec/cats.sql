CREATE TABLE cats (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  owner_id INTEGER NOT NULL,

  FOREIGN KEY(owner_id) REFERENCES human(id)
);

CREATE TABLE humans (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL,
  house_id INTEGER NOT NULL,

  FOREIGN KEY(house_id) REFERENCES human(id)
);

CREATE TABLE houses (
  id INTEGER PRIMARY KEY,
  address VARCHAR(255) NOT NULL
);

INSERT INTO houses (address) VALUES ("26th and Guerrero");
INSERT INTO humans (fname, lname, house_id) VALUES ("Devon", "Watts", 1);
INSERT INTO humans (fname, lname, house_id) VALUES ("Matt", "Rubens", 1);
INSERT INTO cats (name, owner_id) VALUES ("Breakfast", 1);
INSERT INTO cats (name, owner_id) VALUES ("Earl", 2);
