CREATE DATABASE ECommerce

create table Cliente (
	CodiceCliente NvarCHAR(10) NOT NULL,
	Nome VARCHAR(20) NOT NULL ,
	Cognome VARCHAR(30) NOT NULL,
	DataNascita DATETIME NOT NULL,
	CONSTRAINT PK_Cliente PRIMARY KEY (CodiceCliente)	
);


create table Indirizzo(
IdIndirizzo int identity(1,1) ,
Tipo nvarchar (10) not null,
Citta NVARCHAR(30) not null,
Via nvarchar(50) not null,
Cap nvarchar(10) not null,
NumeroCivico int not null,
Provincia nvarchar(30) not null,
Nazione nvarchar(30) not null,
CodiceCliente nvarchar(10) not null,
CONSTRAINT PK_Indirizzo PRIMARY kEY (IdIndirizzo),
CONSTRAINT FK_Cliente FOREIGN KEY (CodiceCliente) REFERENCES Cliente(CodiceCliente),
CONSTRAINT CHK_Tipo check ( Tipo ='Residenza' OR Tipo='Domicilio')

);

create table Carta(
CodiceCarta char(16) not null,
Tipologia nvarchar (30) not null,
Scadenza DATETIME  not null,
Saldo decimal not null,
CodiceCliente nvarchar(10) not null,
CONSTRAINT PK_Carta PRIMARY kEY (CodiceCarta),
CONSTRAINT FK_CartaCliente FOREIGN KEY (CodiceCliente) references Cliente (CodiceCliente),
CONSTRAINT CHK_Tipologia check ( Tipologia ='Credito' OR Tipologia='Debito')
);


create table Ordine(
IdOrdine int not null,
QuantitąProdotto int  not null,
SpesaTotale  decimal not null,
Stato nvarchar(20) not null,
CodiceCliente nvarchar(10) not null,
CodiceCarta char(16) not null,
IdIndirizzo int not null,
CONSTRAINT PK_Ordine PRIMARY kEY (IdOrdine),
CONSTRAINT FK_OrdineCliente FOREIGN KEY (CodiceCliente) references Cliente (CodiceCliente),
CONSTRAINT FK_OrdineCarta FOREIGN KEY (CodiceCarta) references Carta (CodiceCarta),
CONSTRAINT FK_OrdineIndirizzo FOREIGN KEY (IdIndirizzo) references Indirizzo (IdIndirizzo),
CONSTRAINT CHK_Stato check ( Stato ='Provvisorio' OR Stato='Confermato')
);
--alter table Ordine alter COLUMN Stato nvarchar(20) not null DEFAULT 'Provvisorio',


create table Prodotto(
IdProdotto int not null,
CodiceProdotto nvarchar (5) not null,
Nome nvarchar(20)  not null,
Descrizione nvarchar (100) not null,
Prezzo decimal not null,
QuantitąDisponibile int not null,
CONSTRAINT PK_Prodotto PRIMARY kEY (IdProdotto),

);

create table OrdineProdotto(
IdOrdine int not  null,
IdProdotto int not null,
Quantitą int not null,
SubTotale decimal not null,
CONSTRAINT PK_OrdineProdotto PRIMARY kEY (IdOrdine, IdProdotto),
Constraint FK_Ordine foreign key (IdOrdine) references Ordine(IdOrdine),
Constraint FK_Prodotto foreign key (IdProdotto) references Prodotto(IdProdotto),

);





--PROCEDURE 

--PROCEDURA INSERIMENTO DATI

--CLIENTE
create procedure InserisciCliente
@codice nvarchar(10),
@nome nvarchar(20),
@cognome nvarchar (30),
@dataNascita datetime

AS
INSERT INTO Cliente  values(@codice,@nome,@cognome,@dataNascita)
GO

EXECUTE InserisciCliente @codice='11111', @nome='Giorgio',@Cognome='Sacco',@dataNascita='1987-04-12 12:05:07'

EXECUTE InserisciCliente '12222','Stefano','Baldi', @dataNascita='1950-03-12 11:00'



--INDIRIZZO

create procedure InserisciIndirizzo
--@id_Indirizzo int,
@tipo nvarchar (10),
@citta nvarchar (30),
@via nvarchar(50),
@cap nvarchar(10),
@numeroCivico int,
@provincia nvarchar(30),
@nazione nvarchar(30),
@codiceCliente nvarchar(10)

AS
INSERT INTO Indirizzo  values(@tipo,@citta,@via,@cap,@numeroCivico,@provincia,@nazione,@codiceCliente)
GO

EXECUTE InserisciIndirizzo 'Domicilio','Roma','via Salomone','009iu',05,'rm','Italia','12222'
EXECUTE InserisciIndirizzo 'Residenza','Torino','via Salmone','00100',12,'tr','Italia','11111'




--carta
create procedure InserisciCarta
@codiceCarta char(16),
@Tipologia nvarchar(30),
@scadenza DATETIME ,
@saldo decimal,
@codiceCliente nvarchar(10)

AS
begin TRY

if @scadenza<=  GETDATE() -- se @scadenza č <= alla data di oggi?
SET @scadenza = null;
INSERT INTO Carta  values(@codiceCarta,@Tipologia,@scadenza,@saldo,@codiceCliente)

END TRY

BEGIN CATCH
SELECT ERROR_MESSAGE();

END catch


GO


EXECUTE InserisciCarta '5533445154587568','Debito','2024-06-12 12:05','100','12222'



--ORDINE

create procedure InserisciOrdineProvvisorio
@quantitąProdotto int,
@spesaTotale decimal,
@codiceCliente nvarchar(10) 

AS
INSERT INTO Ordine values(@quantitąProdotto,@spesaTotale,'Provvisorio', @codiceCliente)
GO


--conferma ordine con ordine codice carta e codice cliente con update
--inserimento per tutte le tabelle+ controlli 
--transizione che prende in imput cliente- carta- ordine