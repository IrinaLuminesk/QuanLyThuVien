CREATE DATABASE librarydb


USE librarydb


-- 1. Account
-- 2. Librarian
-- 3. Member
-- 4. LibraryCard
-- 5. Book
-- 6. Author
-- 7. Category
-- 8. ReservationTicket
-- 9. ReservationDetail
-- 10. LendingTicket
-- 11. LendingDetail
-- 12. Payment


CREATE TABLE Account (
   id INT PRIMARY KEY
 , password NVARCHAR(100) NOT NULL
 , name NVARCHAR(100) NOT NULL
 , gender NVARCHAR(100) NOT NULL
 , birthdate DATETIME NOT NULL
 , accountType INT NOT NULL  DEFAULT 0 
 -- 0: TEACHER, 1: OFFICER, 2: STUDENT
);



CREATE TABLE LibraryCard (
 cardNumber INT IDENTITY PRIMARY KEY
 , issuedAt DATETIME NOT NULL
 , active INT NOT NULL  DEFAULT 0
 , accountID INT UNIQUE FOREIGN KEY REFERENCES DBO.Account(id) 
);



CREATE TABLE Book (
   id INT IDENTITY PRIMARY KEY
 , name NVARCHAR(100) NOT NULL
 , description NVARCHAR(200) NOT NULL
 , price FLOAT NOT NULL DEFAULT 0
 , dateOfPurcharse DATETIME NOT NULL
 , publicationPlace NVARCHAR(100) NOT NULL
 , status INT NOT NULL  DEFAULT 0
);



CREATE TABLE Author (
   id INT IDENTITY PRIMARY KEY
 , name NVARCHAR(100) NOT NULL
);



CREATE TABLE author_book (
    PRIMARY KEY (authorID, bookID)
  , authorID INT NOT NULL REFERENCES DBO.Author(id)
  , bookID   INT NOT NULL REFERENCES DBO.Book(id)
);


CREATE TABLE Category (
   id INT IDENTITY PRIMARY KEY
 , name NVARCHAR(100) NOT NULL
);



CREATE TABLE category_book (
    PRIMARY KEY (categoryID, bookID)
  , categoryID INT NOT NULL REFERENCES DBO.Category(id)
  , bookID   INT NOT NULL REFERENCES DBO.Book(id)
);


CREATE TABLE ReservationTicket (
   id INT IDENTITY PRIMARY KEY
 , createdDate DATETIME NOT NULL DEFAULT GETDATE()
 , status INT NOT NULL DEFAULT 0
 , totalBookReserved INT NOT NULL DEFAULT 0
 , accountID INT NOT NULL REFERENCES DBO.Account(id)
);



CREATE TABLE reservation_detail (
    PRIMARY KEY (bookID, reservationID)
  , dueDate DATETIME NOT NULL
  , bookID INT NOT NULL REFERENCES DBO.Book(id)
  , reservationID INT NOT NULL REFERENCES DBO.ReservationTicket(id)
);



CREATE TABLE LendingTicket (
   id INT IDENTITY PRIMARY KEY
 , createdDate DATETIME NOT NULL DEFAULT GETDATE()
 , totalBookLended INT NOT NULL DEFAULT 0
 , accountID INT NOT NULL REFERENCES DBO.Account(id)
);



CREATE TABLE lending_detail (
    PRIMARY KEY (bookID, lendingID)
  , dueDate DATETIME NOT NULL
  , ammount FLOAT NOT NULL DEFAULT 0
  , bookID INT NOT NULL REFERENCES DBO.Book(id)
  , lendingID INT NOT NULL REFERENCES DBO.LendingTicket(id)
);



CREATE TABLE Payment (
   id INT IDENTITY PRIMARY KEY
 , ammount FLOAT NOT NULL DEFAULT 0
 , fine FLOAT NOT NULL DEFAULT 0
 , status INT NOT NULL  DEFAULT 0
 , createdDate DATETIME NOT NULL DEFAULT GETDATE()
 , accountID INT NOT NULL REFERENCES DBO.Account(id)
 , lendingID INT NOT NULL REFERENCES DBO.LendingTicket(id)
);
