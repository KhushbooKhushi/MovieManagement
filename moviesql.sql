USE [master]
GO
/****** Object:  Database [MovieManagement]    Script Date: 24-04-2019 23:32:42 ******/
CREATE DATABASE [MovieManagement]
 CONTAINMENT = NONE

GO
USE [MovieManagement]
GO
/****** Object:  Table [dbo].[ActorMovieConnection]    Script Date: 24-04-2019 23:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActorMovieConnection](
	[ActorMovieConnectionId] [int] IDENTITY(1,1) NOT NULL,
	[ActorId] [int] NOT NULL,
	[MovieId] [int] NOT NULL,
	[ConnectionStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_ActorMovieConnection] PRIMARY KEY CLUSTERED 
(
	[ActorMovieConnectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Actors]    Script Date: 24-04-2019 23:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actors](
	[ActorId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Sex] [tinyint] NOT NULL,
	[DOB] [date] NOT NULL,
	[Bio] [nvarchar](550) NULL,
	[ActorStatus] [tinyint] NOT NULL,
 CONSTRAINT [PK_Actors] PRIMARY KEY CLUSTERED 
(
	[ActorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Movie]    Script Date: 24-04-2019 23:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[MovieId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[YearOfRelease] [nvarchar](10) NULL,
	[Plot] [nvarchar](1050) NULL,
	[Poster] [nvarchar](50) NULL,
	[ProducerId] [int] NOT NULL,
 CONSTRAINT [PK_Movies] PRIMARY KEY CLUSTERED 
(
	[MovieId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Producer]    Script Date: 24-04-2019 23:32:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Producer](
	[ProducerId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Sex] [tinyint] NULL,
	[DOB] [date] NULL,
	[Bio] [nvarchar](550) NULL,
 CONSTRAINT [PK_Producer] PRIMARY KEY CLUSTERED 
(
	[ProducerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ActorMovieConnection]  WITH CHECK ADD  CONSTRAINT [FK_ActorMovieConnection_Actors] FOREIGN KEY([ActorId])
REFERENCES [dbo].[Actors] ([ActorId])
GO
ALTER TABLE [dbo].[ActorMovieConnection] CHECK CONSTRAINT [FK_ActorMovieConnection_Actors]
GO
ALTER TABLE [dbo].[ActorMovieConnection]  WITH CHECK ADD  CONSTRAINT [FK_ActorMovieConnection_Movie] FOREIGN KEY([MovieId])
REFERENCES [dbo].[Movie] ([MovieId])
GO
ALTER TABLE [dbo].[ActorMovieConnection] CHECK CONSTRAINT [FK_ActorMovieConnection_Movie]
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD  CONSTRAINT [FK_Movies_Producer] FOREIGN KEY([ProducerId])
REFERENCES [dbo].[Producer] ([ProducerId])
GO
ALTER TABLE [dbo].[Movie] CHECK CONSTRAINT [FK_Movies_Producer]
GO
USE [master]
GO
ALTER DATABASE [MovieManagement] SET  READ_WRITE 
GO
