-- inserção de dados e queries

use ecommerce;

show tables;

-- idClient, Fname,Minit, Lname, CPF, Address

insert into clients(Fname, Minit, Lname, CPF, Address)
values	('Maria','M', 'Silva', 123456789, 'Rua Silva de Prata 29, Carangola - Cidade das Flores'),
		('Matheus', 'O', 'Pimentel', 987654321, 'Rua Alameda 289, Centro - Cidadedas das Flores'),
        ('Ricardo', 'F', 'Silva', 456789123, 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
        ('Julia', 'S', 'França', 789123456, 'Rua Lareijras 861, Centro - Cidade das Flores'),
        ('Roberta', 'G', 'Assis', 987456531, 'Avenida de Koller 19, Centro - Cidade das Flores'),
        ('Isabela', 'M', 'Cruz', 654789123, 'Rua Alemeda das Flores 28, Centro - Cidade das Flores');
        

-- idProduct, Pname, classification_kids boolean, category(Eletronico,Vesturário,Brinquedos,Alimentos,Moveis,Livros), avaliação, size
insert into product(Pname, classification_kids, category, avaliação, size) 
	values	('Fone de Ouvido', false, 'Eletrônico','4', null),
			('Barbie Elsa', true, 'Brinquedos','3', null),
            ('Body Carters', true, 'Vestuário','5', null),
            ('Microfone Vedo - Youtuber', false, 'Eletrônico','4', null),
            ('Sofá Retrátil', false, 'Móveis','3', '3x57x80'),
            ('Farinha de Arroz', false, 'Alimentos','2', null),
            ('Fire Stick Amazon', false, 'Eletrônico','3', null),
            ('Morro dos Ventos Uivantes', true, 'Livros', 1, null),
            ('Box Julio Verne', false, 'Livros', 1, null),
            ('Box Harry Potter', true, 'Livros', 1, null),
            ('Academia dos casos Arquivados', false, 'Livros', 1, null);
            
select * from clients;
select * from product;

-- IdOrder, idOrder_Client,order_Status,order_Description, sendValue, paymentCash
insert into orders(idOrder_Client, order_Status, order_Description, freight_value, paymentCash) values
	(1, default, 'compra via aplicativo', null, 1),
    (2, default, 'compra via aplicativo', 50, 0),
    (3, 'Confirmado', null, null, 1),
    (4, default, 'compra via web site',150, 0);

delete from orders where idOrder_Client in (1,2,3,4);

select * from orders;

-- idPOproduct, idPOorder, poquantity, postatus;
insert into productOrder(idPOproduct, idPOorder, poquantity, postatus) values
	(1,5,2,null),
    (2,5,1,null),
    (3,6,1,null);

-- storageLocation, quantity;
insert into productStorage (storagelocation, quantity) values
	('Rio de Janeiro', 1000),
    ('Rio de Janeiro', 500),
    ('São Paulo', 10),
    ('São Paulo', 100),
    ('São Paulo', 10),
    ('Brasilia', 60);
    
-- idLproduct, idLstorage, location
insert into storageLocation(idLproduct, idLstorage, location) values
	(1,2,'RJ'),
    (2,6,'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into Supplier(SocialName, CNPJ, contact) values
	('Almeida e Filhos', 123456789123456, '21985474'),
    ('Eletrônicos Silva', 854519649143457, '21985474'),
    ('Eletrônicos Valma', 934567893934695, '21975474'),
    ('Zanin Livrarias', 584625789456123, '56234987'),
    ('Amazon', 154879548215001, '58961245');

select * from supplier;

-- idPsSupplier, idPsProduct, quantity
insert into productSupplier(idPsSupplier, idPsProduct, quantity) values
	(1,1,500),
	(1,2,400),
    (2,4,633),
    (3,3,5),
    (2,5,10);

-- idSeller, SocialName, AbstractName, location, CNPJ, CPF, contact
insert into seller(SocialName, AbstractName, CNPJ, CPF, location, contact) values
	('Tech Eletronics', null, 123456789456321, null, 'Rio de Janeiro', 28199462887),
    ('Botique Durgas', null, null, 123456783, 'Rio de Janeiro', 21956789555),
    ('Kids World', null, 456789123654485, null,'São Paulo', 11986574842);

select * from seller;

-- idPSeller, idProduct, qprodquantity
insert into productSeller (idPSeller, idpProduct, qprodquantity) 
	values
		(1,6,80),
		(2,7,10);

select * from productSeller;

select count(*) from clients;

select * from clients c, orders o where c.idClient = idOrder_Client;

select concat(Fname, '', Lname) as Client_Name, idOrder as Request, order_Status as Status_Order from clients c, orders o where c.idClient = idOrder_Client;

-- inserir mais uma linha
insert into orders(idOrder_Client, order_Status, order_Description, freight_value, paymentCash) values
	(2, default, 'compra via aplicativo', null, 1);

select count(*) from clients c, orders o where c.idClient = idOrder_Client;

select * from productOrder;
select * from orders;


select * from clients c
	inner join orders o ON c.idClient = o.idOrder_Client
		inner join productOrder p on p.idPOorder = o.idOrder;

-- Recupera um pedido com um produto associado
select c.idClient, Fname, count(*) as Number_of_Orders from clients c
	inner join orders o ON c.idClient = o.idOrder_Client
		inner join productOrder p on p.idPOorder = o.idOrder
        group by idClient;

-- Recuperar quantos pedidos clientes realizaram
select c.idClient, Fname, count(*) as Number_of_Orders from clients c
	inner join orders o ON c.idClient = o.idOrder_Client
        group by idClient;
        
-- Algum vendedor também é fornecedor?
select * from seller;
select * from Supplier;

select slr.SocialName from seller slr
	inner join supplier spr on slr.SocialName = spr.SocialName;
    
-- relação de produtos fornecedores e estoque
select * from product;
select * from supplier;
select * from productStorage;
select * from productSeller;
select * from storageLocation;
select * from productSupplier;

select * from product
	inner join productStorage pstg on idProdStorage = idProduct
    inner join storageLocation sloc on idLstorage = idProdStorage;

-- relação nome dos fornecedores e nomes dos produtos
select * from supplier;
select * from product;
select * from productSupplier;

-- SoocialName, Pname (Nome Produto), category
select 
	idSupplier as Supplier,
    spr.SocialName as Social_Name,
    p.Pname as Product_Name,
    p.category as Categoria
		from supplier as spr
			inner join productSupplier pspr on spr.idSupplier = pspr.idPsSupplier
            inner join product p on pspr.idPsProduct = p.idProduct;