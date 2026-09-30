/* Netflix Content Strategy - SQL Server schema */
CREATE DATABASE NetflixContentAnalytics;
GO
USE NetflixContentAnalytics;
GO

CREATE TABLE FactTitles (
    show_id INT NOT NULL PRIMARY KEY,
    type VARCHAR(20) NULL,
    title NVARCHAR(255) NOT NULL,
    date_added DATE NULL,
    release_year INT NULL,
    rating VARCHAR(30) NULL,
    duration_minutes INT NULL,
    duration_seasons INT NULL,
    description NVARCHAR(MAX) NULL,
    added_year INT NULL,
    added_month INT NULL,
    added_month_name VARCHAR(20) NULL,
    content_age_years INT NULL,
    duration_bucket VARCHAR(30) NULL
);

CREATE TABLE BridgeDirector (
    show_id INT NOT NULL,
    director NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_BridgeDirector PRIMARY KEY(show_id, director),
    CONSTRAINT FK_BridgeDirector_Title FOREIGN KEY(show_id) REFERENCES FactTitles(show_id)
);

CREATE TABLE BridgeCountry (
    show_id INT NOT NULL,
    country NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_BridgeCountry PRIMARY KEY(show_id, country),
    CONSTRAINT FK_BridgeCountry_Title FOREIGN KEY(show_id) REFERENCES FactTitles(show_id)
);

CREATE TABLE BridgeCast (
    show_id INT NOT NULL,
    cast_member NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_BridgeCast PRIMARY KEY(show_id, cast_member),
    CONSTRAINT FK_BridgeCast_Title FOREIGN KEY(show_id) REFERENCES FactTitles(show_id)
);

CREATE TABLE BridgeCategory (
    show_id INT NOT NULL,
    category NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_BridgeCategory PRIMARY KEY(show_id, category),
    CONSTRAINT FK_BridgeCategory_Title FOREIGN KEY(show_id) REFERENCES FactTitles(show_id)
);

CREATE TABLE DimDate (
    [Date] DATE NOT NULL PRIMARY KEY,
    [Year] INT NOT NULL,
    [Quarter] INT NOT NULL,
    [Month] INT NOT NULL,
    [MonthName] VARCHAR(20) NOT NULL
);
GO

CREATE INDEX IX_FactTitles_DateAdded ON FactTitles(date_added);
CREATE INDEX IX_FactTitles_Type ON FactTitles(type);
CREATE INDEX IX_FactTitles_ReleaseYear ON FactTitles(release_year);
CREATE INDEX IX_BridgeCountry_Country ON BridgeCountry(country);
CREATE INDEX IX_BridgeCategory_Category ON BridgeCategory(category);
GO
