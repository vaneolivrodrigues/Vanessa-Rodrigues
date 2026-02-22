-- DESAFIO LOGICO PARA CRIAÇÃO DE BANCO DE DADOS PARA O CENÁRIO DE E-COMMERCE
-- match option = posso definir o match pois pode influenciar a formação no banco de dados
drop database ecommerce;

create database ecommerce;
use ecommerce;

-- criar tabela cliente

-- atributo composto contendo rua, bairro, numero, complemento, cidade, estado necessita tratamento de dados após o usuário preencher;

create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    constraint unique_cpf_cliente unique(CPF),
    Address varchar(100) 
);
-- desc clients;
alter table clients auto_increment=1;

-- criar tabela produto

-- size = dimensão do produto
-- classification_kids bool = true or falso, produto para crianças ou adultos?

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false, 
    category enum('Eletrônico', 'Vestuário','Brinquedos','Alimentos','Móveis','Livros') not null,
    avaliação float default 0,
    size varchar(10)
);

-- criar tabela pagamentos

-- mais de um tipo de pagamento precisa demais de um tipo de id
-- para ser continuado no desafio: terminar de implementar a tabela e crie a conexão com as tabelas necessárias 
-- além disso reflita essa modificação no diagrama de esquema relacional
create table payments(
	idClient int,
    idPayment int,
    typePayment enum('Dinheiro', 'Boleto','Cartão de Crédito','Cartão de Débito','Pix'),
    limitAvailable float,
    primary key (idClient, idPayment)
);

-- criar tabela pedido

-- freight_value = valor do frete
-- idPayment vai se ruma foreign key - criar constraints relacionadas ao pagamento

create table orders(
	idOrder int auto_increment primary key,
    idOrder_Client int,
    Order_Status enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    order_Description varchar(255),
    freight_value float default 10,
    paymentCash bool default false,
--    idPayment,
    constraint fk_orders_client foreign key (idOrder_Client) references clients(idClient)
		on update cascade
);
desc orders;

-- criar tabela estoque

create table productStorage(
	idProdStorage int auto_increment primary key,
	storagelocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor

create table Supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc Supplier;

-- criar tabela vendedor

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstractName varchar(255),
    location varchar(255),
    CNPJ char(15),
    CPF char(9),
    contact char(11) not null,
    constraint unique_cnpj_suller unique (CNPJ),
    constraint unique_cpf_suller unique (CPF)
);

-- tabela produto x vendedor
create table productSeller(
	idPSeller int,
    idProduct int,
    qprodquantity int default 1,
	primary key (idPSeller, idProduct),
    constraint fk_product_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)
    
);

-- tabela produto x pedido
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poquantity int default 1,
    postatus enum('Disponível','Sem Estoque') default 'Disponível',
	primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

-- tabela estoque x local do produto
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    postatus enum('Disponível','Sem Estoque') default 'Disponível',
	primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

show tables;

-- tabela produto x fornecedor
create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
	primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

show tables;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';

-- comando para encontrar as constraints definidas no banco de dados
-- integridade referencial = foreign key