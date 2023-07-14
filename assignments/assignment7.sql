-- A system error with the library system led to some books ben returned before the 
-- issue date. Create a nested that lists all invalid instances of BORROWS and then
-- return s a table of memebr's first names if they had an invalid transactoin

SELECT Fname FROM MEMBER WHERE Card_Id IN (
  SELECT Card_Id FROM BORROWS WHERE Issued_Date > Return_Date
);

-- 2.	Utilize the EXIST function to get all author names with at least
--  one book they wrote in the BOOK table.

SELECT Author_Name FROM AUTHOR WHERE EXISTS (
    SELECT * FROM BOOK WHERE BOOK.Author_Name = AUTHOR.Author_Name
);

-- 3.	Using the JOIN operation to create a table for all borrowed books 
-- containing the columns member's first name, last name, and book ISBN. 

CREATE TABLE Borrowed_Books (
    Fname VARCHAR(15) NOT NULL,
    Lname VARCHAR(15) NOT NULL,
    Book_Isbn CHAR(10) NOT NULL
);

INSERT INTO Borrowed_Books
SELECT Fname, Lname, Book_Isbn 
FROM MEMBER 
JOIN BORROWS ON MEMBER.Card_Id = BORROWS.Card_Id;

-- 4.	Use the GROUP clause to create the table Branch Name, Books borrowed, 
-- which displays how many books were borrowed at each branch. Since a member 
-- has a local branch, they go to assume they only borrow from that branch. Note 
-- that if the same book is borrowed twice, it should be two towards the Books borrowed.
CREATE TABLE Branch_Name_Books_Borrowed (
    Branch_Name VARCHAR(20) NOT NULL,
    Books_Borrowed INT NOT NULL
);
INSERT INTO Branch_Name_Books_Borrowed
SELECT Branch_Name, COUNT(*) 
FROM MEMBER JOIN (BORROWS ON MEMBER.Card_Id = BORROWS.Card_Id 
JOIN LOCATION ON MEMBER.Local_Location = LOCATION.Branch_Id 
GROUP BY Branch_Name);


-- 5.	Use the GROUP clause to create the table Branch Name, Books borrowed. Note that 
-- if the same book is borrowed twice, it should be two towards the Books borrowed. 


-- 6.	Create a view called "Hachette_Borrows", a table consisting of two columns card_id,
--  and book_name. The view is a subset of the BORROWS table, only selecting books from the publisher Hachette. 
CREATE VIEW hachette_borrowsHachette_Borrows AS
SELECT Card_Id, Book_Name FROM BORROWS JOIN BOOK ON BORROWS.Book_Isbn = BOOK.Isbn WHERE BOOK.Publisher_Name = 'Hachette';
