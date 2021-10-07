USE [master]
GO
/****** Object:  Database [ECommerce]    Script Date: 07/10/2021 13:04:49 ******/
CREATE DATABASE [ECommerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ECommerce', FILENAME = N'C:\Users\noemi.more\ECommerce.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ECommerce_log', FILENAME = N'C:\Users\noemi.more\ECommerce_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ECommerce] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECommerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECommerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECommerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ECommerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECommerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECommerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECommerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECommerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECommerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECommerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECommerce] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ECommerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECommerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECommerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECommerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECommerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECommerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECommerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECommerce] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ECommerce] SET  MULTI_USER 
GO
ALTER DATABASE [ECommerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECommerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECommerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ECommerce] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ECommerce] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ECommerce] SET QUERY_STORE = OFF
GO
USE [ECommerce]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [ECommerce]
GO
/****** Object:  Table [dbo].[Carta]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carta](
	[CodiceCarta] [char](16) NOT NULL,
	[Tipologia] [nvarchar](30) NOT NULL,
	[Scadenza] [datetime] NOT NULL,
	[Saldo] [decimal](18, 0) NOT NULL,
	[CodiceCliente] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Carta] PRIMARY KEY CLUSTERED 
(
	[CodiceCarta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[CodiceCliente] [nvarchar](10) NOT NULL,
	[Nome] [varchar](20) NOT NULL,
	[Cognome] [varchar](30) NOT NULL,
	[DataNascita] [datetime] NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[CodiceCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Indirizzo]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Indirizzo](
	[IdIndirizzo] [int] IDENTITY(1,1) NOT NULL,
	[Tipo] [nvarchar](10) NOT NULL,
	[Citta] [nvarchar](30) NOT NULL,
	[Via] [nvarchar](50) NOT NULL,
	[Cap] [nvarchar](10) NOT NULL,
	[NumeroCivico] [int] NOT NULL,
	[Provincia] [nvarchar](30) NOT NULL,
	[Nazione] [nvarchar](30) NOT NULL,
	[CodiceCliente] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Indirizzo] PRIMARY KEY CLUSTERED 
(
	[IdIndirizzo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ordine]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ordine](
	[IdOrdine] [int] NOT NULL,
	[QuantitàProdotto] [int] NOT NULL,
	[SpesaTotale] [decimal](18, 0) NOT NULL,
	[Stato] [nvarchar](20) NOT NULL,
	[CodiceCliente] [nvarchar](10) NOT NULL,
	[CodiceCarta] [char](16) NOT NULL,
	[IdIndirizzo] [int] NOT NULL,
 CONSTRAINT [PK_Ordine] PRIMARY KEY CLUSTERED 
(
	[IdOrdine] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdineProdotto]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdineProdotto](
	[IdOrdine] [int] NOT NULL,
	[IdProdotto] [int] NOT NULL,
	[Quantità] [int] NOT NULL,
	[SubTotale] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_OrdineProdotto] PRIMARY KEY CLUSTERED 
(
	[IdOrdine] ASC,
	[IdProdotto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prodotto]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prodotto](
	[IdProdotto] [int] NOT NULL,
	[CodiceProdotto] [nvarchar](5) NOT NULL,
	[Nome] [nvarchar](20) NOT NULL,
	[Descrizione] [nvarchar](100) NOT NULL,
	[Prezzo] [decimal](18, 0) NOT NULL,
	[QuantitàDisponibile] [int] NOT NULL,
 CONSTRAINT [PK_Prodotto] PRIMARY KEY CLUSTERED 
(
	[IdProdotto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Cliente] ([CodiceCliente], [Nome], [Cognome], [DataNascita]) VALUES (N'11111', N'Giorgio', N'Sacco', CAST(N'1987-04-12T12:05:07.000' AS DateTime))
INSERT [dbo].[Cliente] ([CodiceCliente], [Nome], [Cognome], [DataNascita]) VALUES (N'12222', N'Stefano', N'Baldi', CAST(N'1950-03-12T11:00:00.000' AS DateTime))
GO
ALTER TABLE [dbo].[Carta]  WITH CHECK ADD  CONSTRAINT [FK_CartaCliente] FOREIGN KEY([CodiceCliente])
REFERENCES [dbo].[Cliente] ([CodiceCliente])
GO
ALTER TABLE [dbo].[Carta] CHECK CONSTRAINT [FK_CartaCliente]
GO
ALTER TABLE [dbo].[Indirizzo]  WITH CHECK ADD  CONSTRAINT [FK_Cliente] FOREIGN KEY([CodiceCliente])
REFERENCES [dbo].[Cliente] ([CodiceCliente])
GO
ALTER TABLE [dbo].[Indirizzo] CHECK CONSTRAINT [FK_Cliente]
GO
ALTER TABLE [dbo].[Ordine]  WITH CHECK ADD  CONSTRAINT [FK_OrdineCarta] FOREIGN KEY([CodiceCarta])
REFERENCES [dbo].[Carta] ([CodiceCarta])
GO
ALTER TABLE [dbo].[Ordine] CHECK CONSTRAINT [FK_OrdineCarta]
GO
ALTER TABLE [dbo].[Ordine]  WITH CHECK ADD  CONSTRAINT [FK_OrdineCliente] FOREIGN KEY([CodiceCliente])
REFERENCES [dbo].[Cliente] ([CodiceCliente])
GO
ALTER TABLE [dbo].[Ordine] CHECK CONSTRAINT [FK_OrdineCliente]
GO
ALTER TABLE [dbo].[Ordine]  WITH CHECK ADD  CONSTRAINT [FK_OrdineIndirizzo] FOREIGN KEY([IdIndirizzo])
REFERENCES [dbo].[Indirizzo] ([IdIndirizzo])
GO
ALTER TABLE [dbo].[Ordine] CHECK CONSTRAINT [FK_OrdineIndirizzo]
GO
ALTER TABLE [dbo].[OrdineProdotto]  WITH CHECK ADD  CONSTRAINT [FK_Ordine] FOREIGN KEY([IdOrdine])
REFERENCES [dbo].[Ordine] ([IdOrdine])
GO
ALTER TABLE [dbo].[OrdineProdotto] CHECK CONSTRAINT [FK_Ordine]
GO
ALTER TABLE [dbo].[OrdineProdotto]  WITH CHECK ADD  CONSTRAINT [FK_Prodotto] FOREIGN KEY([IdProdotto])
REFERENCES [dbo].[Prodotto] ([IdProdotto])
GO
ALTER TABLE [dbo].[OrdineProdotto] CHECK CONSTRAINT [FK_Prodotto]
GO
ALTER TABLE [dbo].[Carta]  WITH CHECK ADD  CONSTRAINT [CHK_Tipologia] CHECK  (([Tipologia]='Credito' OR [Tipologia]='Debito'))
GO
ALTER TABLE [dbo].[Carta] CHECK CONSTRAINT [CHK_Tipologia]
GO
ALTER TABLE [dbo].[Indirizzo]  WITH CHECK ADD  CONSTRAINT [CHK_Tipo] CHECK  (([Tipo]='Residenza' OR [Tipo]='Domicilio'))
GO
ALTER TABLE [dbo].[Indirizzo] CHECK CONSTRAINT [CHK_Tipo]
GO
ALTER TABLE [dbo].[Ordine]  WITH CHECK ADD  CONSTRAINT [CHK_Stato] CHECK  (([Stato]='Provvisorio' OR [Stato]='Confermato'))
GO
ALTER TABLE [dbo].[Ordine] CHECK CONSTRAINT [CHK_Stato]
GO
/****** Object:  StoredProcedure [dbo].[InserisciCliente]    Script Date: 07/10/2021 13:04:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[InserisciCliente]
@codice nvarchar(10),
@nome nvarchar(20),
@cognome nvarchar (30),
@dataNascita datetime

AS
INSERT INTO Cliente  values(@codice,@nome,@cognome,@dataNascita)
GO
USE [master]
GO
ALTER DATABASE [ECommerce] SET  READ_WRITE 
GO
