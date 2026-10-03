USE Northwind;
GO

-- Exercise 1: Display Full name in lower-case with titleOfCourtesy and Sex[cite: 2]
SELECT 
    LOWER(LastName + ' ' + FirstName) AS [Full name], 
    TitleOfCourtesy,
    'Male' AS Sex
FROM Employees;
GO

-- Exercise 2: Display Full name in upper-case[cite: 2]
SELECT 
    UPPER(LastName + ' ' + FirstName) AS [Full name]
FROM Employees;
GO

-- Exercise 3: Display all employees that are from United States[cite: 2]
SELECT EmployeeID, LastName, FirstName, Title, City, Country
FROM Employees
WHERE Country = 'USA';
GO

-- Exercise 4: Display all customers that are from UK[cite: 2]
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Country
FROM Customers
WHERE Country = 'UK';
GO

-- Exercise 5: Display all customers that are from Mexico[cite: 2]
SELECT CustomerID, CompanyName, Address, City, Country
FROM Customers
WHERE Country = 'Mexico';
GO

-- Exercise 6: Display all customers that are from Sweden[cite: 2]
SELECT CustomerID, CompanyName, Phone, Address, City, Country
FROM Customers
WHERE Country = 'Sweden';
GO

-- Exercise 7: Products with inventory (UnitsInStock) between 5 and 10[cite: 2]
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock BETWEEN 5 AND 10;
GO

-- Exercise 8: Products with ordered units (UnitsOnOrder) between 60 and 100[cite: 2]
SELECT ProductID, ProductName, UnitPrice, ReorderLevel, UnitsOnOrder
FROM Products
WHERE UnitsOnOrder BETWEEN 60 AND 100;
GO

-- Exercise 9: Total orders of every employee in 1996[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    e.Title, 
    DATEPART(year, o.OrderDate) AS [year], 
    COUNT(o.OrderID) AS [total orders]
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1996-01-01' AND '1996-12-31'
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.Title, DATEPART(year, o.OrderDate);
GO

-- Exercise 10: Total orders of every employee in 1998[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    e.City, 
    e.Country, 
    COUNT(o.OrderID) AS [total orders]
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1998-01-01' AND '1998-12-31'
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.City, e.Country;
GO

-- Exercise 11: Total orders of every employee from 1/1/1998 to 31/7/1998[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    e.HireDate, 
    COUNT(o.OrderID) AS [total orders]
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1998-01-01' AND '1998-07-31'
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.HireDate;
GO

-- Exercise 12: Total orders of every employee from 1/1/1997 to 30/6/1997[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    e.HireDate, 
    e.HomePhone, 
    COUNT(o.OrderID) AS [total orders]
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.OrderDate BETWEEN '1997-01-01' AND '1997-06-30'
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.HireDate, e.HomePhone;
GO

-- Exercise 13: Freight with tax calculation between 1/8/1996 and 5/8/1996[cite: 2]
SELECT 
    OrderID, 
    DAY(OrderDate) AS OrderDay, 
    MONTH(OrderDate) AS OrderMonth, 
    YEAR(OrderDate) AS OrderYear, 
    Freight, 
    CASE 
        WHEN Freight >= 100 THEN '10%' 
        ELSE '5%' 
    END AS tax,
    CASE 
        WHEN Freight >= 100 THEN Freight * 1.10 
        ELSE Freight * 1.05 
    END AS [Freight with tax]
FROM Orders
WHERE OrderDate BETWEEN '1996-08-01' AND '1996-08-05';
GO

-- Exercise 14: Employees Full name, TitleOfCourtesy and Sex (Male / Female)[cite: 2]
SELECT 
    LastName + ' ' + FirstName AS [Full name], 
    TitleOfCourtesy,
    CASE 
        WHEN TitleOfCourtesy = 'Mr.' THEN 'Male'
        WHEN TitleOfCourtesy IN ('Ms.', 'Mrs.') THEN 'Female'
    END AS Sex
FROM Employees
WHERE TitleOfCourtesy IN ('Mr.', 'Ms.', 'Mrs.');
GO

-- Exercise 15: Employees Sex mapped to 'M' or 'F'[cite: 2]
SELECT 
    LastName + ' ' + FirstName AS [Full name], 
    TitleOfCourtesy,
    CASE 
        WHEN TitleOfCourtesy IN ('Mr.', 'Dr.') THEN 'M'
        WHEN TitleOfCourtesy IN ('Ms.', 'Mrs.') THEN 'F'
    END AS sex
FROM Employees;
GO

-- Exercise 16: Employees Sex mapped to Male / Female / Unknown[cite: 2]
SELECT 
    LastName + ' ' + FirstName AS [Full name], 
    TitleOfCourtesy,
    CASE 
        WHEN TitleOfCourtesy = 'Mr.' THEN 'Male'
        WHEN TitleOfCourtesy IN ('Ms.', 'Mrs.') THEN 'Female'
        ELSE 'Unknown'
    END AS sex
FROM Employees;
GO

-- Exercise 17: Employees Sex mapped to 1 / 0 / 2[cite: 2]
SELECT 
    LastName + ' ' + FirstName AS [Full name], 
    TitleOfCourtesy,
    CASE 
        WHEN TitleOfCourtesy = 'Mr.' THEN 1
        WHEN TitleOfCourtesy IN ('Ms.', 'Mrs.') THEN 0
        ELSE 2
    END AS sex
FROM Employees;
GO

-- Exercise 18: Employees Sex mapped to M / F / N/A[cite: 2]
SELECT 
    LastName + ' ' + FirstName AS [Full name], 
    TitleOfCourtesy,
    CASE 
        WHEN TitleOfCourtesy = 'Mr.' THEN 'M'
        WHEN TitleOfCourtesy IN ('Ms.', 'Mrs.') THEN 'F'
        ELSE 'N/A'
    END AS sex
FROM Employees;
GO

-- Exercise 19 & 20: [Tiêu đề trống trong tài liệu gốc][cite: 2]

-- Exercise 21: Revenues for products from 1/7/1996 to 5/7/1996[cite: 2]
SELECT 
    c.CategoryID, 
    c.CategoryName, 
    p.ProductID, 
    p.ProductName,
    DATEPART(day, o.OrderDate) AS [day],
    DATEPART(month, o.OrderDate) AS [month],
    DATEPART(year, o.OrderDate) AS [year],
    SUM(od.Quantity * od.UnitPrice) AS Revenue
FROM Categories c
INNER JOIN Products p ON c.CategoryID = p.CategoryID
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1996-07-01' AND '1996-07-05'
GROUP BY 
    c.CategoryID, 
    c.CategoryName, 
    p.ProductID, 
    p.ProductName, 
    DATEPART(day, o.OrderDate), 
    DATEPART(month, o.OrderDate), 
    DATEPART(year, o.OrderDate)
ORDER BY c.CategoryID, p.ProductID;
GO

-- Exercise 22: Information about 7-days late orders[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    o.OrderID, 
    o.OrderDate, 
    o.RequiredDate, 
    o.ShippedDate
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.ShippedDate > DATEADD(day, 7, o.RequiredDate)
ORDER BY e.EmployeeID;
GO

-- Exercise 23: Telephone numbers of customers (starting with 'W') and all employees[cite: 2]
SELECT CompanyName, Phone
FROM Customers
WHERE CompanyName LIKE 'W%'
UNION ALL
SELECT LastName + ' ' + FirstName, HomePhone
FROM Employees;
GO

-- Exercise 24: Customer information for OrderID 10643[cite: 2]
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.ContactTitle
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID = 10643;
GO

-- Exercise 25: Products with total units ordered >= 1200[cite: 2]
SELECT 
    p.ProductID, 
    p.ProductName, 
    SUM(od.Quantity) AS [Total Ordered]
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity) >= 1200
ORDER BY SUM(od.Quantity) ASC;
GO

-- Exercise 26: Products with total units ordered >= 1400[cite: 2]
SELECT 
    p.ProductID, 
    p.ProductName, 
    p.SupplierID, 
    p.CategoryID, 
    SUM(od.Quantity) AS [Total ordered]
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName, p.SupplierID, p.CategoryID
HAVING SUM(od.Quantity) >= 1400;
GO

-- Exercise 27: Categories that have maximum total products[cite: 2]
SELECT 
    c.CategoryID, 
    c.CategoryName, 
    COUNT(p.ProductID) AS [Total products]
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(p.ProductID) = (
    SELECT TOP 1 COUNT(ProductID)
    FROM Products
    GROUP BY CategoryID
    ORDER BY COUNT(ProductID) DESC
);
GO

-- Exercise 28: Categories that have minimum total products[cite: 2]
SELECT 
    c.CategoryID, 
    c.CategoryName, 
    COUNT(p.ProductID) AS [Total products]
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(p.ProductID) = (
    SELECT TOP 1 COUNT(p2.ProductID)
    FROM Categories c2
    LEFT JOIN Products p2 ON c2.CategoryID = p2.CategoryID
    GROUP BY c2.CategoryID
    ORDER BY COUNT(p2.ProductID) ASC
);
GO

-- Exercise 29: Total records in Customers and Employees tables[cite: 2]
SELECT SUM(TotalRecords) AS [Total records]
FROM (
    SELECT COUNT(*) AS TotalRecords FROM Customers
    UNION ALL
    SELECT COUNT(*) AS TotalRecords FROM Employees
) AS a;
GO

-- Exercise 30: Employees who have minimum total orders[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    e.Title, 
    COUNT(o.OrderID) AS [total orders]
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.Title
HAVING COUNT(o.OrderID) = (
    SELECT TOP 1 COUNT(OrderID) 
    FROM Orders 
    GROUP BY EmployeeID 
    ORDER BY COUNT(OrderID) ASC
);
GO

-- Exercise 31: Employees who have maximum total orders[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    e.Title, 
    COUNT(o.OrderID) AS Total_Orders
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.LastName, e.FirstName, e.Title
HAVING COUNT(o.OrderID) = (
    SELECT TOP 1 COUNT(OrderID) 
    FROM Orders 
    GROUP BY EmployeeID 
    ORDER BY COUNT(OrderID) DESC
);
GO

-- Exercise 32: Products that have maximum units in inventory[cite: 2]
SELECT ProductID, ProductName, SupplierID, CategoryID, UnitsInStock
FROM Products
WHERE UnitsInStock = (SELECT MAX(UnitsInStock) FROM Products);
GO

-- Exercise 33: Products that have minimum units in inventory[cite: 2]
SELECT ProductID, ProductName, SupplierID, CategoryID, UnitsInStock
FROM Products
WHERE UnitsInStock = (SELECT MIN(UnitsInStock) FROM Products);
GO

-- Exercise 34: Products that have maximum total ordered units (UnitsOnOrder)[cite: 2]
SELECT ProductID, ProductName, SupplierID, CategoryID, UnitsOnOrder
FROM Products
WHERE UnitsOnOrder = (SELECT MAX(UnitsOnOrder) FROM Products);
GO

-- Exercise 35: Products that have maximum re-order level[cite: 2]
SELECT ProductID, ProductName, SupplierID, CategoryID, ReorderLevel
FROM Products
WHERE ReorderLevel = (SELECT MAX(ReorderLevel) FROM Products);
GO

-- Exercise 36: Employees who have maximum delayed orders[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    COUNT(o.OrderID) AS [Delayed Orders]
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.ShippedDate > o.RequiredDate
GROUP BY e.EmployeeID, e.LastName, e.FirstName
HAVING COUNT(o.OrderID) = (
    SELECT TOP 1 COUNT(OrderID) 
    FROM Orders 
    WHERE ShippedDate > RequiredDate
    GROUP BY EmployeeID 
    ORDER BY COUNT(OrderID) DESC
)
ORDER BY e.EmployeeID;
GO

-- Exercise 37: Employees who have at least one delayed order and minimum total delayed orders[cite: 2]
SELECT 
    e.EmployeeID, 
    e.LastName, 
    e.FirstName, 
    COUNT(o.OrderID) AS [Delayed Orders]
FROM Employees e
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
WHERE o.ShippedDate > o.RequiredDate
GROUP BY e.EmployeeID, e.LastName, e.FirstName
HAVING COUNT(o.OrderID) = (
    SELECT TOP 1 COUNT(OrderID) 
    FROM Orders 
    WHERE ShippedDate > RequiredDate
    GROUP BY EmployeeID 
    ORDER BY COUNT(OrderID) ASC
)
ORDER BY e.EmployeeID;
GO

-- Exercise 38: Products in top 3 highest total ordered units[cite: 2]
SELECT 
    p.ProductID, 
    p.ProductName, 
    SUM(od.Quantity) AS [Total Ordered]
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity) IN (
    SELECT TOP 3 SUM(Quantity) 
    FROM [Order Details] 
    GROUP BY ProductID 
    ORDER BY SUM(Quantity) DESC
)
ORDER BY SUM(od.Quantity) ASC;
GO

-- Exercise 39: Products in top 5 highest total ordered units[cite: 2]
SELECT 
    p.ProductID, 
    p.ProductName, 
    SUM(od.Quantity) AS [Total Ordered]
FROM Products p
INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Quantity) IN (
    SELECT TOP 5 SUM(Quantity) 
    FROM [Order Details] 
    GROUP BY ProductID 
    ORDER BY SUM(Quantity) DESC
)
ORDER BY SUM(od.Quantity) ASC;
GO