-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)
select p.ProductName, c.CategoryName from Product as p 
 JOIN Category c ON p.CategoryId = c.Id;


-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)

select o.Id ,c.CompanyName  from [Order] as o
join Customer c on o.CustomerID = c.Id
where OrderDate < "2012-08-09"

-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)

select Count(ProductName) as "Ürün Sayısı" , p.ProductName from OrderDetail as od
join Product as p on od.ProductId = p.Id 
where OrderId = 10251
group by ProductName
Order by p.ProductName
-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)

select o.Id,c.CompanyName,e.LastName from [Order] as o
join Employee as e on o.EmployeeId = e.Id
join Customer as c on o.CustomerId = c.Id


- Her gönderici tarafından gönderilen gönderi sayısını bulun.

SELECT CustomerId , count(CustomerID) as "Sipariş Sayısı" FROM [Orders] as o
group by CustomerID

- Sipariş sayısına göre ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.

Select EmployeeId,count(EmployeeId) as "Performans" from Orders as o
group by EmployeeId
order by count(EmployeeId) DESC
limit 5

- Gelir olarak ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.

select o.EmployeeId ,Sum(od.UnitPrice) from OrderDetail as od
join [Order] as o on od.OrderId = o.Id
group by o.EmployeeId 
order by Sum(od.UnitPrice) desc


- En az gelir getiren kategoriyi bulun.

select c.CategoryName, Sum(od.UnitPrice) as "Toplam Satış Tutarı" from OrderDetail od
join Product p on p.Id = od.ProductId
join Category c on c.Id = p.CategoryId
group by c.CategoryName
order by Sum(od.UnitPrice)
limit 1

- En çok siparişi olan müşteri ülkesini bulun.

select c.Country , count(c.Country) as "Sipariş sayısı" from [Order] o
join Customer c on c.Id = o.CustomerId
group by c.ContactName
order by count(c.Country) desc
limit 1