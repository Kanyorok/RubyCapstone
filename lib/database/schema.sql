CREATE TABLE music(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    on_spotify BOOLEAN,
    publish_date DATE,
    archived boolean,
    genre_id INT REFERENCES genres(id)
);

CREATE TABLE genres(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50)
);