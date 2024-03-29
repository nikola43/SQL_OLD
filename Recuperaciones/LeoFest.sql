CREATE DATABASE LeoFest
GO
USE LeoFest
GO
-- Artistas 
CREATE TABLE LFMusicos (
	ID Int NOT NULL,
	Nombre VarChar(20) NOT NULL,
	Apellidos VarChar(30) NOT NULL,
	NombreArtistico VarChar(50) NULL,
	Direccion VarChar(50) NULL,
	Ciudad VarChar(20) NULL,
	Telefono1 Char(9) NULL,
	Telefono2 Char(9) NULL,
 CONSTRAINT PKMusicos PRIMARY KEY (ID)
)

-- Estilos
CREATE TABLE LFEstilos(
	ID SmallInt Not NULL,
	Estilo VarChar (30) Not NULL,
	CONSTRAINT PKEstilos Primary Key (ID) 
)
-- Bandas
CREATE TABLE LFBandas(
	ID SmallInt Not NULL Identity(1,1),
	NombreBanda VarChar(50) Not NULL,
	FechaFormacion Date NULL,
	FechaDisolucion DATE NULL,
	CacheMinimo SmallMoney NULL,
	CONSTRAINT PKBandas Primary Key (ID) 
)
-- Festivales
CREATE TABLE LFFestivales(
	ID Int Not NULL Identity(1,1),
	Denominacion VarChar(55) Not NULL,
	Comentarios VarChar(800) NULL,
	CONSTRAINT PKFestivales Primary Key (ID) 
)
GO
-- Ediciones. Entidad débil de Festivales. Dependencia en identificación
CREATE TABLE LFEdiciones(
	IDFestival Int Not NULL,
	Ordinal TinyInt Not NULL,
	Lema VarChar(300) NULL,
	Lugar VarChar(40) NULL,
	Ciudad VarChar(45) Not NULL,
	ComunidadAutonoma VarChar(30) Not NULL,
	FechaHoraInicio SmallDateTime NULL,
	FechaHoraFin SmallDateTime NULL,
	CONSTRAINT PKEdiciones Primary Key (IDFestival, Ordinal),
	CONSTRAINT FKEdicionesFestivales Foreign Key (IDFestival) REFERENCES LFFestivales (ID) On Update CASCADE On Delete CASCADE,
	CONSTRAINT CKTiempo CHECK (FechaHoraInicio < FechaHoraFin)
)
-- Temas
CREATE TABLE LFTemas(
	ID UniqueIdentifier Not NULL,
	Titulo VarChar(120) NULL,
	IDAutor Int NULL,
	IDEstilo SmallInt Not NULL,
	Duracion Time NULL,
	CONSTRAINT PKTemas Primary Key (ID),
	CONSTRAINT FKTemasAutores FOREIGN KEY (IDAutor) REFERENCES LFMusicos(ID) On Delete No Action On Update CASCADE,
	CONSTRAINT FKTemasEstilos Foreign Key (IDEstilo) REFERENCES LFEstilos (ID)
)
-- Relación NM entre Bandas y Estilos
CREATE TABLE LFBandasEstilos (
	IDBanda SmallInt Not NULL,
	IDEstilo SmallInt Not NULL,
	CONSTRAINT PKBandasEstilos Primary Key (IDBanda,IDEstilo),
	CONSTRAINT FKBandasEstilosBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKBandasEstilosEstilos Foreign Key (IDEstilo) REFERENCES LFEstilos (ID)
)
-- Relación NM entre bandas y Musicos
CREATE TABLE LFMusicosBandas(
	ID UniqueIdentifier Not NULL,
	IDBanda SmallInt Not NULL,
	IDMusico Int Not NULL,
	FechaIncorporacion Date NULL,
	FechaAbandono Date NULL,
	CONSTRAINT PKMusicosBandas PRIMARY KEY (ID),
	CONSTRAINT FKMusicosBandasBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKMusicosBandasMusicos FOREIGN KEY (IDMusico) REFERENCES LFMusicos(ID)
)
-- Bandas que han participado en cada edición
CREATE TABLE LFBandasEdiciones(
	IDBanda SmallInt Not NULL,
	IDFestival Int Not NULL,
	Ordinal TinyInt Not NULL,
	Categoria TinyInt,
	CONSTRAINT PKBandasEdiciones Primary Key (IDBanda,IDFestival,Ordinal),
	CONSTRAINT FKBandasEdicionesBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKBandasEdicionesEdiciones Foreign Key (IDFestival, Ordinal) REFERENCES LFEdiciones (IDFestival, Ordinal)
)
-- Temas que ha interpretado cada banda en cada edición. Relación ternaria
CREATE TABLE LFTemasBandasEdiciones(
	IDBanda SmallInt Not NULL,
	IDFestival Int Not NULL,
	Ordinal TinyInt Not NULL,
	IDTema UniqueIdentifier Not NULL,
	CONSTRAINT PKTemasBandasEdiciones Primary Key (IDBanda,IDFestival,Ordinal,IDTema),
	CONSTRAINT FKTemasBandasEdicionesBandas Foreign Key (IDBanda) REFERENCES LFBandas (ID),
	CONSTRAINT FKTemasBandasEdicionesEdiciones Foreign Key (IDFestival, Ordinal) REFERENCES LFEdiciones (IDFestival, Ordinal) On Update No Action On Delete No Action,
	CONSTRAINT FKTemasBandasEdicionesTemas Foreign Key (IDTema) REFERENCES LFTemas (ID)
)

GO
Set dateformat ymd

INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (1, N'Aitor', N'Tilla Perez', N'Bormangani', N'Calle Japon                                       ', N'Sevilla', N'954054940', NULL)
, (2, N'Armando', N'Bronca Segura', N'Hulk', N'Calle Pakistan                                    ', N'Sevilla', N'954654345', NULL)
, (3, N'Cristina', N'Sanchez Salcedo', N'Nadia', N'Plaza Redonda, 14                                 ', N'Sevilla', N'954752006', NULL)
, (4, N'Jesus', N'Rodriguez Jurado', N'Nene', N'Avda de las Letanias                              ', N'Sevilla', N'954090439', NULL)
, (5, N'Javier', N'Rodriguez Pariente', N'Ojo loco', N'Calle Fandango                                    ', N'Huelva', N'954041392', NULL)

INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (6, N'Borja', N'Monero', N'Serranito', N'Av. del Sol, 47                                   ', N'Sevilla', N'678002451', NULL)
, (7, N'Elena', N'Dadora', NULL, N'Calle 14 de Abril, 10                             ', N'Sevilla', N'606441980', NULL)
, (8, N'Rocio', N'Marin Romero', NULL, N'Calle Estadio                                     ', N'Sevilla', N'959654425', NULL)
, (9, N'Vicente', N'Mata Gente', NULL, N'Calle Afganistan                                  ', N'Sevilla', N'954092930', NULL)
, (10, N'Joyce', N'Green', NULL, N'Marqués de Viana, 50', N'Madrid', N'600123945', NULL)

INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (11, N'Armando', N'Rose', N'Ricky Town', N'Paseo del Prado, 42', N'Madrid', N'600123958', NULL)
, (12, N'Rick', N'Hendricks', NULL, N'Sinesio Delgado, 7', N'Madrid', N'600123971', NULL)
, (13, N'Joan', N'Baker', NULL, N'Paseo de la Castellana', N'Madrid', N'600123984', NULL)
, (14, N'Clifford', N'Underwood', NULL, N'Paseo de la Castellana', N'Madrid', N'600123997', NULL)
, (15, N'Juan', N'Ybarra', N'Salsero', N'Bravo Murillo, 104', N'Madrid', N'600124010', NULL)
GO
INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (16, N'Jasper', N'Lyons', N'JL', N'Azalea, 32', N'Málaga', N'600124023', NULL)
, (17, N'Jasmine', N'Callahan', N'Lucy', N'Serrano, 20', N'Madrid', N'600124036', NULL)
, (18, N'Neil', N'Lynch', NULL, N'Av. de Asturias, 105', N'Madrid', N'600124049', N'615487002')
, (19, N'Kimberly', N'Huerta', N'Fruit', N'Paseo de la Castellana', N'Madrid', N'600124062', NULL)
, (20, N'Margarita', N'García', N'Killa', N'Sombrerete, 11', N'Madrid', N'600124075', NULL)
INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (21, N'Kara', N'Cardenas', NULL, N'Princesa, 34', N'Madrid', N'600124088', NULL)
, (22, N'Dustin', N'Torres', NULL, N'Legazpi, 30', N'Madrid', N'600124101', NULL)
, (23, N'Lewis', N'Wagner', N'El polaco', N'Atocha, 68', N'Madrid', N'600124114', NULL)
, (24, N'Abigail', N'Lowery', NULL, N'Embajadores, 3', N'Madrid', N'600124127', NULL)
, (25, N'Gabriel', N'Sosa', NULL, N'Gran Vía, 36', N'Madrid', N'600124140', NULL)
INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (26, N'Teddy', N'Nielsen', NULL, N'Paseo de la Castellana', N'Madrid', N'600124153', NULL)
, (27, N'Stephan', N'Knox', N'The edge', N'Lavapiés, 15', N'Madrid', N'600124166', NULL)
, (28, N'Ethan', N'Booth', N'Virus', N'Toledo, 31', N'Madrid', N'600124179', N'635078022')
, (29, N'Olga', N'Musino', N'Cruella', N'Paseo de la Castellana', N'Madrid', N'600124192', NULL)
, (30, N'Manel', N'Navarro', N'Eurogallo', N'Sotano nauseabundo', N'Gotham', N'666000777', NULL)
GO
INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (100, N'Juan', N'Tanamera', NULL, N'Torneo, 114', N'Sevilla', N'600124205', NULL)
, (101, N'Ana', N'Vegante', N'Marina', N'Ancha, 24', N'Cádiz', N'600124218', NULL)
, (200, N'Esteban', N'Quero', NULL, N'Feria, 27', N'Sevilla', N'600124231', NULL)
, (207, N'Fernando', N'Minguero', NULL, N'Av de Andalucía', N'Málaga', N'600124244', NULL)
, (214, N'Elisa', N'Ladita', NULL, N'Plaza de Cuba, 6', N'Sevilla', N'600124257', NULL)

INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (220, N'Paco', N'Merselo', N'Rico', N'Calle Pelota', N'Cádiz', N'600124270', NULL)
, (234, N'Simon', N'Toncito', N'Pirulo', N'Recogidas, 45', N'Granada', N'600124283', NULL)
, (245, N'Aitor', N'Menta', N'Storm', N'Calle Pelota', N'Bilbao', N'600124296', NULL)
, (307, N'Olga', N'Llinero', NULL, N'Calle Pelota', N'Madrid', N'600124309', NULL)
, (407, N'Jeremias', N'Mas', N'Johnny Melavo', N'Plaza del Pumarejo, 4', N'Sevilla', N'600124322', NULL)
INSERT [dbo].[LFMusicos] ([ID], [Nombre], [Apellidos], [NombreArtistico], [Direccion], [Ciudad], [Telefono1], [Telefono2]) VALUES (440, N'Juan Luis', N'Guerra', NULL, N'Plaza de España, 16', N'Cádiz', N'600124335', NULL)
, (507, N'Salud', N'Itos', NULL, N'Muntaner, 45', N'Barcelona', N'600124348', NULL)
, (516, N'Ramon', N'Tañero', NULL, N'Calle Pelota', N'Málaga', N'600124361', NULL)
, (607, N'Susana', N'Tillas', N'Nancy Rubia', N'Av. del Guadiana', N'Cáceres', N'600124374', NULL)
, (736, N'Pedro', N'Medario', NULL, N'Plaza de las monjas, 7', N'Huelva', N'600124387', NULL)
GO
-- Estilos
INSERT [dbo].[LFEstilos] ([ID], [Estilo]) VALUES (1, N'Pop'), (2, N'Rock'), (3, N'Música electrónica'), (4, N'Flamenco'), (5, N'Ska')
INSERT [dbo].[LFEstilos] ([ID], [Estilo]) VALUES (6, N'Hip-Hop'), (7, N'Funky'), (8, N'Jazz'), (9, N'Latina'), (10, N'Soul')
INSERT [dbo].[LFEstilos] ([ID], [Estilo]) VALUES (11, N'Blues'), (12, N'Punk'), (13, N'Melódica'), (14, N'Folk'), (15, N'Cantautor')
INSERT [dbo].[LFEstilos] ([ID], [Estilo]) VALUES (16, N'Reggae'), (17, N'Heavy Metal'), (18, N'Reggaeton'), (19, N'Hard Rock'), (20, N'Baladas')
INSERT [dbo].[LFEstilos] ([ID], [Estilo]) VALUES (21, N'Thrash Metal'), (22, N'Techno'), (23, N'Grunge'), (24, N'House'), (25, N'Rithm & Blues')
INSERT [dbo].[LFEstilos] ([ID], [Estilo]) VALUES (26, N'Country'), (27, N'Tango'), (28, N'Rap'), (29, N'Chill out')
GO
--Temas
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'02453b5b-4026-4ee8-91f9-0869ab999101', N'Lagartija solidaria', 11, 6, CAST(N'00:02:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'413b6ae2-bf18-4e19-a670-0adaa860e383', N'Jesús te odia', 1, 28, CAST(N'00:03:30' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'6f4b3055-d902-4276-a716-0b082eccbdd6', N'Revenge', 7, 23, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13', N'My life', 6, 18, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'cf73cfbf-f024-4d7e-8f90-11008ae14a52', N'La vaca Catalina', 9, 21, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'26670ace-b8d2-479b-99a7-110c2ee6c1f6', N'Me hiciste pupa', 9, 25, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'd14ffbb9-4946-456b-a5df-1ad163185758', N'WTF', 6, 19, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'f7c7c693-849a-4081-95c9-28114b152db2', N'Mi novia Desdémona', 8, 24, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'ecd0237b-3d47-441d-af51-28d063202f71', N'Venganza divina', 7, 9, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'15c005d1-0ba8-4890-a675-2b008a42a372', N'Cork', 3, 22, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16', N'Tus formas no son normales', 2, 29, CAST(N'00:03:14' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'3e6268b8-55d1-4713-8dd1-2c1822ef6491', N'Tiro la lira', 9, 8, CAST(N'00:03:00' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d', N'Fistro de la pradera', 19, 1, CAST(N'00:03:00' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'4eaf8233-be11-4330-85c2-37962def0b46', N'Full or empty', 7, 23, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'4ee392df-e790-41b0-aae4-3c986f1adeb2', N'Peperoncini', 6, 18, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'5cc547f0-cacc-468f-9f0f-42319aec1860', N'Return to nowhere', 6, 15, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'dbfe1c8b-e059-4545-b992-469e90f4e900', N'Traición', 8, 24, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39', N'La clave ajena', 16, 21, CAST(N'00:03:58' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6', N'Cuando te duermes', 6, 15, CAST(N'00:03:54' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'827fae2a-50e0-41fc-af36-4e46717c031e', N'La pizarra de Manu', 2, 29, CAST(N'00:03:14' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'ebcec6ee-e009-447e-8768-5159fbd0ce2f', N'De mi casa vengo', 9, 4, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'67ed76d2-c883-43be-9139-51806de52ae5', N'Mi prima', 5, 4, CAST(N'00:03:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'2b3699e3-e8d7-4b9a-99a8-52847e421bad', N'Marcelino el gorrino', 6, 18, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'30d4264c-a650-4f8a-991a-54b8f726c4ce', N'No te olvides de poner el Where', 15, 10, CAST(N'00:02:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'e264d8a8-853b-4b1e-ba24-57889a3e723b', N'Fiumicino', 9, 8, CAST(N'00:03:00' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'c81eec3c-c95a-446a-b6de-5c48a3976e81', N'In the extrem', 2, 27, CAST(N'00:03:31' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'441d9cb9-c49d-49d4-aaca-630f7a9cf144', N'No me deletes todavía', 1, 28, CAST(N'00:03:30' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376', N'Escarabajo ratonero', 1, 5, CAST(N'00:04:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'00ab9412-f192-44b5-8d28-6a2399ceadcd', N'Holocausto norcoreano', 1, 1, CAST(N'00:04:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a', N'No quiero mas', 15, 10, CAST(N'00:02:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'378e8e24-1a59-4494-8ccc-70686dd6eeba', N'Que caló hace aquí', 11, 3, CAST(N'00:02:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'0b262e36-5856-4add-b33c-72fdff4d8faf', N'My life', 6, 17, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b', N'Is Null', 23, 11, CAST(N'00:03:41' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf', N'Dame parámetros que me quiero ejecutar', 6, 14, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8', N'My life', 6, 15, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'd00d3992-43f4-4fb2-addc-7b7fc47021f6', N'My life', 6, 13, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2', N'Tu abuela tiene flow', 7, 7, CAST(N'00:01:22' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'ca04842e-95aa-4494-9d84-7e54ad9e3111', N'Select my Heart', 6, 13, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'a97ab275-6035-4a55-82e4-832fbaecf7a8', N'La patria del mono', 7, 9, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'bbabba3a-ac19-4740-8abc-84ac6559525b', N'In the middle', 2, 27, CAST(N'00:03:31' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a', N'No volveré', 9, 25, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'55822730-d436-4834-80c3-8b075816298d', N'Dame veneno', 16, 11, CAST(N'00:03:14' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'81bf3e07-8561-4243-a766-8c252048fff6', N'End While', 6, 10, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3', N'Federico cierra el pico', 16, 8, CAST(N'00:04:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862', N'Lunes vacío', 3, 26, CAST(N'00:03:36' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'625ff4da-b04c-482c-9b35-903874dc04f8', N'Update esa camiseta', 6, 17, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'74932d5e-7b2e-4b5c-9bab-938337cd3786', N'Andando', 16, 8, CAST(N'00:04:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'b057efff-1d83-4759-b88a-93ae0d642212', N'Small time', 6, 12, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da', N'My life', 6, 19, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'252485e1-5006-4148-97ef-983e56310c7b', N'My life', 6, 14, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48', N'Esta noche hacemos JOIN', 6, 16, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'270767c2-26d4-43e8-946a-9d262d378402', N'Seguimos', 14, 21, CAST(N'00:03:05' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'bed09e25-84bd-466b-a0a0-a93f4f303da3', N'El rey del JOIN', 3, 26, CAST(N'00:03:36' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'115ef0da-cc0a-4a39-a463-aef576eadab7', N'Sunset', 6, 4, CAST(N'00:03:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'db803423-85f8-4953-8666-afd511ab8ff1', N'Me río de la dieta', 21, 6, CAST(N'00:03:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61', N'My life', 6, 16, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e', N'Blue Moon', 7, 7, CAST(N'00:03:22' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'836f2551-c014-42dd-a092-bbf08b0c2e50', N'No time to Rollback', 6, 14, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6', N'Tirando duro', 9, 21, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'76c93dbb-6a78-4385-9957-be92112736ae', N'Back again', 6, 1, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'49690347-47ff-425a-bc6a-c031440eb07e', N'Cuando me miras', 6, 15, CAST(N'00:03:54' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'5e647c97-8bef-4a4c-831b-c0d0c3263386', N'Lamentos de Lebrija', 3, 22, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'c84c9547-9573-4dba-b25d-c39f9f9944d7', N'Sad days', 9, 4, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'913aed2e-61f1-42d6-bda0-c61b5f601f6e', N'My life', 6, 2, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'907f2ecf-06cb-47f3-819e-c6db91626f71', N'Rebuzno romántico', 4, 12, CAST(N'00:03:14' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b', N'Red Army', 7, 7, CAST(N'00:03:22' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'970cf274-4629-4661-8d92-cb772df46bc4', N'My life', 6, 18, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4', N'Tempestad', 6, 10, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'6be36785-ba23-4e61-a612-d0350b37d0b6', N'El melón volador', 1, 20, CAST(N'00:03:15' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'5d89c27d-2715-4f4f-8882-d92ce534b3d9', N'El bit asesino', 4, 12, CAST(N'00:03:14' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'3003802d-6974-4168-9375-d93e0b033f1b', N'Tu prima Ramona', 16, 1, CAST(N'00:04:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'0ace10be-3f05-4a01-b93b-dc7156f2c568', N'El perdón', 11, 5, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'944700cf-1555-4256-bb1b-e016205cd656', N'Berenjena radiactiva', 11, 3, CAST(N'00:02:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf', N'No te vayas', 16, 11, CAST(N'00:03:14' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'c2ac8373-1d95-4312-9074-e398686f4e0a', N'My life', 6, 14, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'4a815ce0-e185-4057-9fa1-e72bb3aeae45', N'Por un mendrugo', 11, 5, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'930695cb-c929-4450-b781-ec00ba92495b', N'Tiempo muerto', 16, 21, CAST(N'00:03:58' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'8662bb60-485b-4de3-9e77-ed2da7f56182', N'Tengo una rana', 5, 4, CAST(N'00:03:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb', N'My life', 6, 12, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'8c63c63a-c13a-4409-9d8b-ee27f6247561', N'En tu ventanita', 6, 4, CAST(N'00:03:10' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'a27e96be-dd3d-491d-ad0f-f5979490441c', N'Who Moved My Cheese?', 6, 2, CAST(N'00:03:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'5f79f40b-1f59-42d6-9661-f61faaab355e', N'Defeat', 23, 11, CAST(N'00:03:41' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f', N'Remando contra el viento', 1, 5, CAST(N'00:04:40' AS Time))
GO
INSERT [dbo].[LFTemas] ([ID], [Titulo], [IDAutor], [IDEstilo], [Duracion]) VALUES (N'c5801d03-427c-40a0-80b8-f7b022f8545d', N'Pescando sardinas', 14, 21, CAST(N'00:03:05' AS Time))
GO
SET IDENTITY_INSERT [dbo].[LFBandas] ON 

GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (1, N'Ejecucion hipotecaria', CAST(N'2001-04-20' AS Date), CAST(N'2014-09-30' AS Date), NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (2, N'Flower Power', CAST(N'2003-02-07' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (3, N'La carga del último enano', CAST(N'2004-02-02' AS Date), CAST(N'2016-11-14' AS Date), NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (4, N'Sospechosos', CAST(N'2000-10-30' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (5, N'Almonteños saltarines', CAST(N'2004-06-25' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (6, N'Petra Porter', NULL, NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (7, N'Malditos bastardos', CAST(N'2007-08-15' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (8, N'Riders', CAST(N'2009-05-23' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (9, N'Los Tranquilos', CAST(N'2001-12-07' AS Date), CAST(N'2015-09-14' AS Date), NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (10, N'El negro del wasap', CAST(N'2008-10-16' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (11, N'Los tiesos', CAST(N'2004-07-06' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (12, N'De sevillanas maneras', CAST(N'2006-04-02' AS Date), CAST(N'2017-02-01' AS Date), NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (13, N'Heroicos desertores', NULL, NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (14, N'Santos mártires', CAST(N'2004-06-08' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (15, N'Panceta light', NULL, NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (16, N'Corderos de Satán', NULL, NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (17, N'Rebuznos armónicos', CAST(N'2002-10-13' AS Date), CAST(N'2015-05-31' AS Date), NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (18, N'Off topic', NULL, NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (19, N'Apocalipsis mutante', CAST(N'2006-06-06' AS Date), NULL, NULL)
GO
INSERT [dbo].[LFBandas] ([ID], [NombreBanda], [FechaFormacion], [FechaDisolucion], [CacheMinimo]) VALUES (20, N'Cremallera', CAST(N'2002-03-18' AS Date), NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[LFBandas] OFF
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a570f2c9-de30-48ac-b96e-0159a49042a4', 6, 3, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'ad4b881f-70d7-4a60-8ba9-01c146991fae', 13, 101, CAST(N'2000-01-01' AS Date), CAST(N'2009-05-23' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'4dc128e6-14e0-4f64-a251-01cb6e4f3e0b', 7, 14, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'aadcfde7-7903-47ba-a57b-030726cea1e0', 17, 407, CAST(N'2003-07-25' AS Date), CAST(N'2005-11-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'444ba44e-1907-48d4-b868-03fef2ed8d6f', 19, 440, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'45cd6160-723f-47e0-8b3f-0428eb4300e7', 19, 7, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'42a0ef4d-2128-45b4-89a2-06c942e8ff17', 7, 2, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'9abf61a3-5e84-46c9-8a73-0966b24ced0a', 7, 1, CAST(N'2007-08-15' AS Date), CAST(N'2015-10-17' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f5623282-c2e2-4fef-a366-0be86996d05d', 3, 4, CAST(N'2015-10-17' AS Date), CAST(N'2015-11-02' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'48be0add-6cf2-4569-ba04-0cfde98e3929', 19, 14, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7df09511-5040-459a-b2c2-0f6d9ba72a35', 5, 16, CAST(N'2004-06-25' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a3288b2a-281c-4607-aa5f-0f9d46247a5b', 20, 407, CAST(N'2002-03-18' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'48546645-ddbc-4df8-a6e6-10dcecc3b80f', 19, 17, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'09244b70-c38c-4d46-942b-114b6f3227d3', 8, 100, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'5c024fc8-713a-4dbe-848b-13583cd70040', 12, 101, CAST(N'2014-09-30' AS Date), CAST(N'2015-07-11' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'e0556033-1359-4a5e-b06c-13b1606e8662', 2, 3, CAST(N'2003-02-07' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'02846991-6f54-438c-863a-1868508870e1', 14, 245, CAST(N'2004-06-08' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f8fd3115-4e58-4aae-9d0c-1a55b888dffa', 10, 7, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'59197ae3-71f6-4e2e-a171-1e2b0e717cfa', 10, 7, CAST(N'2008-10-16' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'59098264-465e-42dc-a91e-1f620e62e600', 20, 10, CAST(N'2002-03-18' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7b54370e-ab4c-47e0-9b57-1f79f24aa5c9', 10, 1, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'5d694cec-528f-4d16-93cf-1f8fd1a23fa0', 18, 2, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'b9652864-8652-49d7-bded-217b312d4afa', 6, 516, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'e3fcb458-d3ae-4070-8764-2293f85a8115', 3, 30, CAST(N'2010-09-25' AS Date), CAST(N'2012-03-15' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'43b83157-4d9e-48a5-9bf6-295c51c10c95', 12, 1, CAST(N'2009-06-08' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'691287ce-f625-4518-9fbc-29eb56493b26', 8, 7, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'3557d08a-fe48-4afa-a4b9-2b1e1938d8eb', 8, 30, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7c580137-41be-46cd-8563-2cb9d4088f78', 15, 234, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'c727f3f2-da2a-4696-92af-2e67ceeebf8f', 5, 20, CAST(N'2004-06-25' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f328e3f5-6e80-4d2d-9cb8-2eeb906fb261', 13, 245, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'24eb43aa-17f5-4c68-881c-2fb40acb996d', 16, 234, CAST(N'2000-01-01' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'e55be74b-5188-45c9-a278-31585f493a9d', 11, 11, CAST(N'2004-07-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'c9e6430a-13ed-4254-b8ef-35d4ef108a93', 5, 27, CAST(N'2004-06-25' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7ef0a175-8eba-47c7-aa55-37559351e84a', 13, 25, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'80cbc713-1858-4233-bdab-39c489aa6e2a', 11, 15, CAST(N'2004-07-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'25bea62a-7e59-48fb-b6bf-39d7dab397c3', 15, 207, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'488135c2-c21b-4731-a0c5-3c1fba334d94', 1, 17, CAST(N'2011-09-28' AS Date), CAST(N'2012-12-03' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'1d7ad95d-f2b5-4d56-b265-3cdb2e985311', 12, 2, CAST(N'2006-06-07' AS Date), CAST(N'2014-05-23' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'cabdff6a-fead-416a-a016-3e3e47cedfa3', 13, 27, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'467181af-1dd9-428a-b2d6-411d363447ef', 9, 5, CAST(N'2001-12-07' AS Date), CAST(N'2005-02-19' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'bbe5c319-5e7f-4b9c-b7bb-44c9462975f6', 4, 516, CAST(N'2000-10-30' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a0ef3ff1-9e35-4b7d-a6f9-451656bd287e', 18, 21, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'1da63579-a2d2-4023-82c3-4a170a0a78d9', 4, 440, CAST(N'2000-10-30' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'362f64f2-c84d-4df9-b9fd-4be947054638', 14, 4, CAST(N'2004-06-08' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'12bb1e2d-607b-483e-adec-4ccf50266020', 9, 27, CAST(N'2010-11-06' AS Date), CAST(N'2014-08-27' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0ecdcf0b-1691-4ede-9f60-51bb9b9986f8', 4, 29, CAST(N'2000-10-30' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'b5109ebf-5534-4254-a94c-51ca9ca3c9ed', 20, 28, CAST(N'2002-03-18' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'9e8a5ca2-bf63-4671-9b42-574662ba7cdc', 5, 17, CAST(N'2004-06-25' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'c28e7bda-8afe-48b0-bad9-584a1476d927', 20, 220, CAST(N'2002-03-18' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'aa8b8175-aad2-446b-8822-5b04cd7c26af', 10, 200, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'01824a36-698b-4aa8-a32b-5b42605b240a', 5, 21, CAST(N'2004-06-25' AS Date), CAST(N'2012-04-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'9fe90654-28ac-4656-a818-5bbad4402481', 5, 15, CAST(N'2004-06-25' AS Date), CAST(N'2008-02-04' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'e5b07bd0-16ca-4645-afbb-5c36e39b907a', 8, 101, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'1a9ea508-f502-446b-9a49-5c7668177282', 11, 200, CAST(N'2004-07-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'5f68db06-1e72-4030-9c79-5c8fd16ef7c6', 3, 507, CAST(N'2005-12-19' AS Date), CAST(N'2008-02-04' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'4401966e-2701-420e-bfc5-5c976295e76c', 4, 27, CAST(N'2000-10-30' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a4945210-37f6-44c4-9dfe-5cfc4be777e4', 13, 200, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7c5de229-6986-4f42-9aae-5edd86024a9c', 5, 2, CAST(N'2004-06-25' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'402c726a-d3f6-4e5e-9bdc-6088ef9ea99d', 3, 10, CAST(N'2007-07-21' AS Date), CAST(N'2009-11-30' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'bd627a01-e3e0-47b2-92b6-60f1dcf889ac', 11, 20, CAST(N'2004-07-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f95cc1cd-a2e7-481c-ab2e-6233772f67ff', 17, 23, CAST(N'2007-05-25' AS Date), CAST(N'2012-12-23' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'fe40695a-ff9d-4916-b9fa-658a8a074f47', 3, 200, CAST(N'2004-02-02' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'712aad93-5115-465c-a9e0-6a5b17a9868c', 19, 14, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'ea493323-d3aa-4f54-acb5-6c9856b34e49', 1, 2, CAST(N'2009-10-06' AS Date), CAST(N'2014-07-23' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'd202f615-d763-4421-ab2d-6e7160d5fc79', 14, 11, CAST(N'2004-06-08' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0cb012de-21bc-4618-b9ce-7069cd15684a', 15, 507, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f510b9f4-b6fa-449b-88f7-71bb62cd1144', 4, 12, CAST(N'2000-10-30' AS Date), CAST(N'2008-02-04' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a087f5c3-c99d-495c-a4dc-7456ed523ae0', 10, 21, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'de4ad279-e851-4fa2-a5ce-74c9b14e47f9', 14, 2, CAST(N'2004-06-08' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'8cc13b24-1249-42d5-9d92-74d273503d77', 6, 20, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'748ee518-8932-4e10-99e3-7700247c50d8', 1, 207, CAST(N'2004-11-05' AS Date), CAST(N'2008-05-20' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'df0682d4-a996-4b9b-bf5b-787d213af6ef', 17, 12, CAST(N'2005-09-01' AS Date), CAST(N'2015-01-18' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a794b0ac-fd21-4324-9f29-79e444fbf01f', 17, 200, CAST(N'2011-10-31' AS Date), CAST(N'2012-04-22' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f52128fe-1c48-4477-9734-7b642f798b99', 15, 207, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'8248b19e-fecd-4783-b9c4-7b9943611f3d', 2, 440, CAST(N'2003-02-07' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'1e3b540d-b166-4557-a9ee-7ccf8fe018ff', 8, 25, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'ceea3fce-155b-4761-9342-7d6483d6ecc9', 14, 12, CAST(N'2004-06-08' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'2d200e29-08d1-4285-8dcd-7e419b11f295', 2, 516, CAST(N'2003-02-07' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'44bdf5f1-2d82-4499-8e07-80c2922b6447', 15, 18, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'8ccb5cb3-4d17-40a9-8b52-80ff19ba7f1c', 1, 11, CAST(N'2008-12-20' AS Date), CAST(N'2009-05-11' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'338ffc17-2760-4013-be9f-81d9f6ee57bd', 7, 516, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0ff6c845-465b-4d60-8610-8238361c155b', 8, 22, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'26d1c4be-91eb-4d40-a4f1-8247223bd99e', 9, 214, CAST(N'2008-07-23' AS Date), CAST(N'2012-07-07' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'608f2304-24cf-4f93-92c9-824857199611', 17, 27, CAST(N'2002-10-13' AS Date), CAST(N'2007-11-10' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'bcdf4ab7-a56b-4dd7-9545-8268d4835565', 7, 100, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'2501dd07-f297-408c-965b-84857c5ad751', 4, 25, CAST(N'2000-10-30' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'841574db-a340-4235-a810-85d0829193c6', 20, 5, CAST(N'2002-03-18' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a504a8ad-73d2-43c7-8acc-86c537d95478', 2, 10, CAST(N'2003-02-07' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'bad09c21-6c67-4de3-a147-87e09d250001', 18, 24, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'b4c0ee79-1cff-4a82-bb46-880d4858e128', 16, 7, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'69ec3781-c2c3-4048-a4e0-88ca874f50a3', 9, 607, CAST(N'2005-04-17' AS Date), CAST(N'2014-01-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'834a349d-630e-4cc8-9fe7-8bc972c71a8f', 12, 24, CAST(N'2006-04-02' AS Date), CAST(N'2006-06-13' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'd7223ae7-9bbb-4a0a-acfd-8cc467ecd45c', 19, 507, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'abc8ad35-7be4-41b0-8ae1-8deea282c744', 18, 26, CAST(N'2000-01-01' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'eb7e0edc-9d5c-472a-b854-8efebf5b129c', 16, 30, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'87e2748b-563b-4c8c-82d6-985310867bfe', 16, 12, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f3480185-c627-460b-a922-9a1f0263e190', 12, 11, CAST(N'2014-06-05' AS Date), CAST(N'2016-03-12' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'2f7206a0-5189-40a9-95c9-9add1488d523', 7, 27, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a6fdb660-dc23-4564-8a49-9cd29026b7b9', 12, 12, CAST(N'2007-04-11' AS Date), CAST(N'2010-05-19' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'36f99b55-2821-4ec7-a271-9cf7297e09e2', 16, 26, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'16aa2fdb-7418-4531-8949-9d1e6a8c4137', 16, 1, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'92fd7c87-7309-4bb6-b467-9ef6cf24e1d8', 12, 736, CAST(N'2007-05-05' AS Date), CAST(N'2008-01-22' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'13fe3468-b40d-4e99-a42d-9f66f170da96', 14, 17, CAST(N'2004-06-08' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'c8eaba73-1c12-49de-b944-a19fcfd1552d', 7, 30, CAST(N'2007-08-15' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'5015b3e1-0d98-4523-bb73-a330b8f101c1', 10, 4, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'3e12376e-4546-46a2-a8b0-a5a10f90e7b8', 18, 207, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'47925f40-6e1b-4ced-8604-a743c6833501', 11, 21, CAST(N'2004-07-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'3b234723-b346-4337-95f3-a7752017cb87', 9, 10, CAST(N'2006-05-19' AS Date), CAST(N'2012-02-27' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'aa3a7539-20d0-40a8-9765-a7a1dcbae680', 8, 440, CAST(N'2009-05-23' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'b88dfbc1-b2e4-4c0d-a2ab-a90e1dd4c0fd', 9, 9, CAST(N'2002-10-08' AS Date), CAST(N'2006-07-14' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'97e14c27-80f4-4544-b049-ae4bab0a1a64', 17, 23, CAST(N'2003-08-25' AS Date), CAST(N'2009-09-26' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'4ab70d0c-e48c-4357-a899-aeff76ea52b7', 6, 440, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'ade222d8-c2c9-4916-85c8-af46d9ba04b2', 3, 22, CAST(N'2014-08-12' AS Date), CAST(N'2016-07-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'b7c4300c-173d-45fa-9f86-afacb200f904', 5, 29, CAST(N'2004-06-25' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'f6091c75-eaa7-4bd6-969b-b1c8a0971292', 12, 101, CAST(N'2007-10-23' AS Date), CAST(N'2012-12-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'553d5f5a-2cb8-4b7d-b9ce-b35dc290a4c2', 10, 220, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'eae2cba0-53b0-4205-b579-b5192bc15069', 3, 2, CAST(N'2004-02-05' AS Date), CAST(N'2005-09-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'fedcdae4-9085-4883-902e-b66477d55dbe', 20, 5, CAST(N'2002-03-18' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'3726a880-700b-43ec-9b60-b6cb2c03e8bc', 15, 407, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0bade51a-a46f-4388-af12-b776a339141f', 11, 101, CAST(N'2004-07-06' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'ba07af4d-9008-4041-a422-b8e569700fd3', 15, 18, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'd7bfc424-bcb7-41ed-866a-ba83ffb7e746', 10, 8, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7e6f363e-caa8-4a86-b42d-bd0da0d60fc2', 1, 23, CAST(N'2012-07-07' AS Date), CAST(N'2013-12-31' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0110fe9c-8e9e-4cf0-bcfc-bfc3e852c5e2', 2, 28, CAST(N'2003-02-07' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'6113c87f-838d-4c16-94a0-c371c7fec209', 20, 5, CAST(N'2002-03-18' AS Date), CAST(N'2016-10-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'8b000e6f-3f3d-448a-800e-c8f1c3180cba', 2, 13, CAST(N'2003-02-07' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'b9e0ab4e-f66a-4ea6-b5a9-c978faead4bf', 6, 18, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0e3b0583-4ff4-4482-927c-cb0c58fb323f', 17, 1, CAST(N'2008-05-16' AS Date), CAST(N'2011-06-25' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'2eb2f744-3b8f-4d5e-b236-d035f26f561e', 11, 200, CAST(N'2004-07-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'3664bdfd-cf9f-41fb-93dc-d095a9bc4cd6', 6, 101, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'e3e4a3e1-c194-46c9-abff-d209d7dea22d', 9, 24, CAST(N'2002-01-05' AS Date), CAST(N'2007-01-28' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'6fa2275d-eb93-44fd-9a56-d660015813b2', 18, 220, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'31d0869f-7dc9-4521-941f-d7181f4b85d6', 13, 2, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'911d10d4-3cda-41d1-8b0b-da67fe373be6', 14, 27, CAST(N'2004-06-08' AS Date), CAST(N'2014-06-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0958cf3d-391b-4c09-8450-dbbda2e26f88', 15, 507, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'467fbfed-b84c-4ca2-9a29-dc605643d8d7', 14, 516, CAST(N'2004-06-08' AS Date), CAST(N'2014-06-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7ba4b190-9534-4ff7-af9d-de2dadb64165', 15, 5, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'0a06a04d-9e8a-4342-9980-e05e893e9092', 1, 25, CAST(N'2006-12-07' AS Date), CAST(N'2012-05-31' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'a8dda1fc-20a9-4dca-917c-e0ea035c527c', 17, 11, CAST(N'2014-04-09' AS Date), CAST(N'2014-06-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'cf202d7b-7608-4594-8f6b-e215e94fa3c3', 2, 2, CAST(N'2003-02-07' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'99ba1c2b-afa2-4501-87e3-e24531f6be3f', 7, 29, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'db46edf8-08de-4581-a94d-e4d65b7e8f5f', 4, 507, CAST(N'2000-10-30' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'3423366d-644f-4411-bfc6-e542e5b9f02b', 10, 214, CAST(N'2008-10-16' AS Date), CAST(N'2014-06-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'6d716f0c-de73-4aae-a205-e547f2ce21ba', 6, 27, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'bac87eb8-65f6-424c-a504-ea9dcd6f9e75', 18, 2, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'e92cda99-7660-4f97-a7ab-f20328f0f2fe', 1, 20, CAST(N'2013-04-09' AS Date), CAST(N'2013-10-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7b725591-8ca4-482f-bb0e-f3c6b847d5c6', 9, 214, CAST(N'2011-02-28' AS Date), CAST(N'2012-06-04' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'c4a9afa5-879e-4958-93eb-f50bd63cce46', 7, 2, CAST(N'2007-08-15' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'92285a21-6fec-4ff9-9713-f548c1b72676', 19, 27, CAST(N'2006-06-06' AS Date), CAST(N'2014-06-06' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'62b59ea8-c835-4fb1-91b9-f7f603bbcb0f', 10, 17, CAST(N'2008-10-16' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'ccf0eca9-8da4-4461-af0f-f9f03c1c42cc', 12, 5, CAST(N'2012-11-12' AS Date), CAST(N'2015-07-11' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'91c78ea6-c5a0-4def-9351-fa3fb55327ae', 6, 2, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'7c4c8e0b-f391-40b2-a24e-fb1922ece6f1', 19, 200, CAST(N'2006-06-06' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'db0c9837-4af2-4625-b333-fb6c692a1df6', 1, 8, CAST(N'2001-04-20' AS Date), CAST(N'2008-08-08' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'16968a00-6c68-4d5c-b2db-fb9beec66416', 1, 18, CAST(N'2007-10-22' AS Date), CAST(N'2014-05-19' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'c7d88bb6-8abd-4f11-953b-fc3b7ce43e5c', 6, 20, CAST(N'2000-01-01' AS Date), NULL)
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'42d6b82a-0160-4e0d-a5c8-fe1cf3cc8db6', 17, 27, CAST(N'2011-02-25' AS Date), CAST(N'2011-09-17' AS Date))
GO
INSERT [dbo].[LFMusicosBandas] ([ID], [IDBanda], [IDMusico], [FechaIncorporacion], [FechaAbandono]) VALUES (N'49083532-f645-4bb4-b552-ff7e356c3ec9', 12, 101, CAST(N'2006-06-03' AS Date), CAST(N'2010-09-22' AS Date))
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (1, 2)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (1, 8)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (1, 17)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (1, 22)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (2, 6)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (2, 15)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (2, 17)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (2, 20)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (3, 6)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (3, 16)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (3, 27)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (4, 7)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (4, 11)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (4, 19)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (4, 24)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (5, 3)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (5, 6)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (5, 11)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (5, 12)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (5, 18)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (6, 15)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (6, 22)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (6, 25)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (6, 27)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (7, 1)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (7, 4)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (7, 5)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (7, 9)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (7, 11)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (8, 3)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (8, 25)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (9, 8)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (9, 10)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (9, 18)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (9, 19)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (9, 20)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (10, 9)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (10, 11)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (10, 17)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (10, 28)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (11, 5)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (11, 7)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (11, 14)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (11, 19)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (11, 20)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (11, 26)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (12, 4)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (12, 8)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (12, 22)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (13, 1)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (13, 2)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (13, 5)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (13, 10)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (13, 15)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (13, 22)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (14, 12)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (14, 18)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (14, 19)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (14, 26)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (15, 3)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (15, 4)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (15, 5)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (15, 13)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (15, 19)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (16, 1)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (16, 8)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (16, 13)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (16, 14)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (16, 17)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (16, 24)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (17, 2)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (17, 12)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (17, 18)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (17, 22)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (18, 2)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (18, 14)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (18, 15)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (18, 25)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (18, 27)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (19, 4)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (19, 24)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (19, 26)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (20, 14)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (20, 20)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (20, 21)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (20, 22)
GO
INSERT [dbo].[LFBandasEstilos] ([IDBanda], [IDEstilo]) VALUES (20, 29)
GO
SET IDENTITY_INSERT [dbo].[LFFestivales] ON 

GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (1, N'Trending music', N'Sevilla         Andalucía')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (2, N'QTKGas', N'Orense          Galicia')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (3, N'Salamandras Fest', N'Toledo          Castilla-La Mancha')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (4, N'Al solete', N'Isla Cristina   Andalucía')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (5, N'Meneito sabroson', N'Cadiz           Andalucía')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (6, N'Happy Fest', N'Valencia        Comunidad valenciana')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (7, N'Campiña Rock', N'Castro del Rio Andalucía')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (8, N'Abejorrock', N'Merida          Extremadura')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (9, N'Green Fest', N'Grazalema       Andalucía')
GO
INSERT [dbo].[LFFestivales] ([ID], [Denominacion], [Comentarios]) VALUES (10, N'Pingüino Rock', N'Burgos          Castilla y León')
GO
SET IDENTITY_INSERT [dbo].[LFFestivales] OFF
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 1, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2001-12-24 12:04:00' AS SmallDateTime), CAST(N'2001-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 2, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2003-12-24 12:04:00' AS SmallDateTime), CAST(N'2003-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 3, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2004-12-24 12:04:00' AS SmallDateTime), CAST(N'2004-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 4, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2005-12-24 12:04:00' AS SmallDateTime), CAST(N'2005-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 5, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2007-12-24 12:04:00' AS SmallDateTime), CAST(N'2007-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 6, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2009-12-24 12:04:00' AS SmallDateTime), CAST(N'2009-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 7, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2010-12-24 12:04:00' AS SmallDateTime), CAST(N'2010-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 8, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2013-12-24 12:04:00' AS SmallDateTime), CAST(N'2013-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 9, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2015-12-24 12:04:00' AS SmallDateTime), CAST(N'2015-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (1, 10, NULL, NULL, N'Sevilla        ', N'Andalucía', CAST(N'2017-12-24 12:04:00' AS SmallDateTime), CAST(N'2017-12-27 12:04:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 1, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2002-01-13 11:40:00' AS SmallDateTime), CAST(N'2002-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 2, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2005-01-13 11:40:00' AS SmallDateTime), CAST(N'2005-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 3, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2007-01-13 11:40:00' AS SmallDateTime), CAST(N'2007-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 4, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2010-01-13 11:40:00' AS SmallDateTime), CAST(N'2010-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 5, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2011-01-13 11:40:00' AS SmallDateTime), CAST(N'2011-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 6, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2012-01-13 11:40:00' AS SmallDateTime), CAST(N'2012-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 7, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2015-01-13 11:40:00' AS SmallDateTime), CAST(N'2015-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (2, 8, NULL, NULL, N'Orense         ', N'Galicia', CAST(N'2017-01-13 11:40:00' AS SmallDateTime), CAST(N'2017-01-16 11:40:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 1, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2001-12-26 17:56:00' AS SmallDateTime), CAST(N'2001-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 2, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2002-12-26 17:56:00' AS SmallDateTime), CAST(N'2002-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 3, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2005-12-26 17:56:00' AS SmallDateTime), CAST(N'2005-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 4, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2007-12-26 17:56:00' AS SmallDateTime), CAST(N'2007-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 5, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2008-12-26 17:56:00' AS SmallDateTime), CAST(N'2008-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 6, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2009-12-26 17:56:00' AS SmallDateTime), CAST(N'2009-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 7, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2012-12-26 17:56:00' AS SmallDateTime), CAST(N'2012-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 8, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2014-12-26 17:56:00' AS SmallDateTime), CAST(N'2014-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (3, 9, NULL, NULL, N'Toledo         ', N'Castilla-La Mancha', CAST(N'2017-12-26 17:56:00' AS SmallDateTime), CAST(N'2017-12-29 17:56:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 1, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2001-12-10 12:21:00' AS SmallDateTime), CAST(N'2001-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 2, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2004-12-10 12:21:00' AS SmallDateTime), CAST(N'2004-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 3, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2006-12-10 12:21:00' AS SmallDateTime), CAST(N'2006-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 4, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2009-12-10 12:21:00' AS SmallDateTime), CAST(N'2009-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 5, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2011-12-10 12:21:00' AS SmallDateTime), CAST(N'2011-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 6, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2013-12-10 12:21:00' AS SmallDateTime), CAST(N'2013-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 7, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2015-12-10 12:21:00' AS SmallDateTime), CAST(N'2015-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (4, 8, NULL, NULL, N'Isla Cristina  ', N'Andalucía', CAST(N'2017-12-10 12:21:00' AS SmallDateTime), CAST(N'2017-12-13 12:21:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 1, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2001-12-15 10:46:00' AS SmallDateTime), CAST(N'2001-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 2, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2003-12-15 10:46:00' AS SmallDateTime), CAST(N'2003-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 3, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2005-12-15 10:46:00' AS SmallDateTime), CAST(N'2005-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 4, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2007-12-15 10:46:00' AS SmallDateTime), CAST(N'2007-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 5, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2009-12-15 10:46:00' AS SmallDateTime), CAST(N'2009-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 6, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2012-12-15 10:46:00' AS SmallDateTime), CAST(N'2012-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 7, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2014-12-15 10:46:00' AS SmallDateTime), CAST(N'2014-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 8, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2015-12-15 10:46:00' AS SmallDateTime), CAST(N'2015-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (5, 9, NULL, NULL, N'Cadiz          ', N'Andalucía', CAST(N'2017-12-15 10:46:00' AS SmallDateTime), CAST(N'2017-12-18 10:46:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 1, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2001-11-08 19:28:00' AS SmallDateTime), CAST(N'2001-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 2, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2002-11-08 19:28:00' AS SmallDateTime), CAST(N'2002-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 3, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2003-11-08 19:28:00' AS SmallDateTime), CAST(N'2003-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 4, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2005-11-08 19:28:00' AS SmallDateTime), CAST(N'2005-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 5, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2008-11-08 19:28:00' AS SmallDateTime), CAST(N'2008-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 6, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2009-11-08 19:28:00' AS SmallDateTime), CAST(N'2009-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 7, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2011-11-08 19:28:00' AS SmallDateTime), CAST(N'2011-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 8, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2013-11-08 19:28:00' AS SmallDateTime), CAST(N'2013-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 9, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2014-11-08 19:28:00' AS SmallDateTime), CAST(N'2014-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 10, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2016-11-08 19:28:00' AS SmallDateTime), CAST(N'2016-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (6, 11, NULL, NULL, N'Valencia       ', N'Comunidad valencian', CAST(N'2017-11-08 19:28:00' AS SmallDateTime), CAST(N'2017-11-11 19:28:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 1, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2002-02-02 13:42:00' AS SmallDateTime), CAST(N'2002-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 2, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2005-02-02 13:42:00' AS SmallDateTime), CAST(N'2005-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 3, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2007-02-02 13:42:00' AS SmallDateTime), CAST(N'2007-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 4, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2009-02-02 13:42:00' AS SmallDateTime), CAST(N'2009-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 5, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2011-02-02 13:42:00' AS SmallDateTime), CAST(N'2011-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 6, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2013-02-02 13:42:00' AS SmallDateTime), CAST(N'2013-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 7, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2016-02-02 13:42:00' AS SmallDateTime), CAST(N'2016-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (7, 8, NULL, NULL, N'Castro del Rio ', N'Andalucía', CAST(N'2017-02-02 13:42:00' AS SmallDateTime), CAST(N'2017-02-05 13:42:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 1, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2002-01-15 09:58:00' AS SmallDateTime), CAST(N'2002-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 2, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2005-01-15 09:58:00' AS SmallDateTime), CAST(N'2005-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 3, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2006-01-15 09:58:00' AS SmallDateTime), CAST(N'2006-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 4, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2008-01-15 09:58:00' AS SmallDateTime), CAST(N'2008-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 5, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2011-01-15 09:58:00' AS SmallDateTime), CAST(N'2011-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 6, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2014-01-15 09:58:00' AS SmallDateTime), CAST(N'2014-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 7, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2015-01-15 09:58:00' AS SmallDateTime), CAST(N'2015-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (8, 8, NULL, NULL, N'Merida         ', N'Extremadura', CAST(N'2017-01-15 09:58:00' AS SmallDateTime), CAST(N'2017-01-18 09:58:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 1, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2002-01-24 22:59:00' AS SmallDateTime), CAST(N'2002-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 2, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2005-01-24 22:59:00' AS SmallDateTime), CAST(N'2005-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 3, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2006-01-24 22:59:00' AS SmallDateTime), CAST(N'2006-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 4, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2008-01-24 22:59:00' AS SmallDateTime), CAST(N'2008-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 5, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2009-01-24 22:59:00' AS SmallDateTime), CAST(N'2009-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 6, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2012-01-24 22:59:00' AS SmallDateTime), CAST(N'2012-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 7, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2015-01-24 22:59:00' AS SmallDateTime), CAST(N'2015-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (9, 8, NULL, NULL, N'Grazalema      ', N'Andalucía', CAST(N'2016-01-24 22:59:00' AS SmallDateTime), CAST(N'2016-01-27 22:59:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 1, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2001-11-09 13:22:00' AS SmallDateTime), CAST(N'2001-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 2, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2003-11-09 13:22:00' AS SmallDateTime), CAST(N'2003-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 3, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2004-11-09 13:22:00' AS SmallDateTime), CAST(N'2004-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 4, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2007-11-09 13:22:00' AS SmallDateTime), CAST(N'2007-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 5, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2008-11-09 13:22:00' AS SmallDateTime), CAST(N'2008-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 6, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2009-11-09 13:22:00' AS SmallDateTime), CAST(N'2009-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 7, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2012-11-09 13:22:00' AS SmallDateTime), CAST(N'2012-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 8, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2013-11-09 13:22:00' AS SmallDateTime), CAST(N'2013-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 9, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2014-11-09 13:22:00' AS SmallDateTime), CAST(N'2014-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 10, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2015-11-09 13:22:00' AS SmallDateTime), CAST(N'2015-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFEdiciones] ([IDFestival], [Ordinal], [Lema], [Lugar], [Ciudad], [ComunidadAutonoma], [FechaHoraInicio], [FechaHoraFin]) VALUES (10, 11, NULL, NULL, N'Burgos         ', N'Castilla y León', CAST(N'2016-11-09 13:22:00' AS SmallDateTime), CAST(N'2016-11-12 13:22:00' AS SmallDateTime))
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 1, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 2, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 3, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 5, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 6, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 1, 8, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 2, 2, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 2, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 2, 4, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 2, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 2, 6, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 3, 1, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 3, 4, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 3, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 3, 7, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 4, 1, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 4, 2, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 4, 4, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 4, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 4, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 5, 1, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 5, 2, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 5, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 5, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 5, 6, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 6, 1, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 6, 3, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 6, 4, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 6, 7, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 7, 1, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 7, 2, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 7, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 7, 5, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 7, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 8, 1, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 8, 2, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 8, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 8, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 8, 5, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 8, 6, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 9, 1, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 9, 2, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 9, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 9, 5, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 9, 6, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 1, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 2, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 3, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 5, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 6, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (1, 10, 8, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 1, 3, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 1, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 1, 6, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 1, 8, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 1, 9, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 2, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 2, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 2, 7, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 3, 3, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 3, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 3, 5, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 3, 7, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 3, 8, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 4, 2, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 4, 3, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 4, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 4, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 4, 7, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 5, 4, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 5, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 5, 8, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 6, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 6, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 6, 9, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 6, 10, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 7, 4, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 7, 5, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 7, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 8, 2, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 8, 3, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 8, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 8, 5, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 8, 7, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 9, 3, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 9, 4, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 9, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 9, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 9, 7, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 10, 4, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 10, 5, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 10, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 10, 8, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (3, 10, 10, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 1, 1, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 1, 3, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 1, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 1, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 1, 7, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 1, 8, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 2, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 2, 6, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 3, 1, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 3, 3, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 3, 5, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 3, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 4, 3, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 5, 2, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 5, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 5, 4, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 6, 2, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 6, 3, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 6, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 6, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 6, 8, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 6, 9, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 7, 1, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 7, 3, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 7, 4, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 7, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 8, 1, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 8, 3, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 8, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 8, 5, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 9, 2, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 9, 4, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 9, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 9, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 9, 7, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 10, 3, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 10, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 10, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 10, 6, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 10, 8, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (9, 10, 9, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 1, 5, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 1, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 1, 8, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 1, 9, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 2, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 2, 6, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 3, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 3, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 3, 8, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 4, 3, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 4, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 4, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 4, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 4, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 5, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 5, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 5, 8, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 6, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 6, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 6, 7, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 6, 8, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 6, 9, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 6, 10, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 7, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 7, 5, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 8, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 8, 6, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 8, 7, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 8, 8, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 9, 4, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 9, 7, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 10, 4, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 10, 8, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 10, 9, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (12, 10, 11, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 1, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 1, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 1, 6, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 2, 2, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 2, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 2, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 2, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 3, 3, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 3, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 3, 7, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 3, 8, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 4, 3, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 4, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 5, 3, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 5, 5, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 5, 6, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 5, 7, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 6, 4, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 6, 5, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 6, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 6, 7, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 6, 8, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 7, 3, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 7, 4, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 7, 5, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 8, 2, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 8, 4, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 8, 5, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 8, 7, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 9, 4, 4)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 9, 5, 1)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 9, 6, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 9, 7, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 10, 2, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 10, 5, 2)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 10, 6, 5)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 10, 7, 3)
GO
INSERT [dbo].[LFBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [Categoria]) VALUES (17, 10, 8, 2)
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 1, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 1, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 1, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 1, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 1, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 2, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 2, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 2, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 2, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 2, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 2, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 3, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 3, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 3, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 3, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 3, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 5, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 5, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 5, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 5, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 5, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 6, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 6, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 6, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 6, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 6, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 7, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 7, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 7, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 7, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 7, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 8, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 8, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 8, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 8, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 1, 8, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 2, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 2, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 2, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 3, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 3, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 3, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 3, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 3, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 3, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 4, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 5, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 5, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 5, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 5, N'30d4264c-a650-4f8a-991a-54b8f726c4ce')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 5, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 6, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 6, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 2, 6, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 1, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 1, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 1, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 1, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 1, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 4, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 4, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 4, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 4, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 6, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 6, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 6, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 6, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 6, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 6, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 7, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 7, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 7, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 7, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 3, 7, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 1, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 1, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 1, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 1, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 1, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 2, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 2, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 2, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 2, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 2, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 4, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 4, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 4, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 4, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 4, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 4, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 5, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 5, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 5, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 5, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 5, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 6, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 6, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 6, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 6, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 4, 6, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 1, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 1, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 1, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 1, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 1, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 1, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 2, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 2, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 2, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 2, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 3, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 3, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 3, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 3, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 5, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 5, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 5, N'30d4264c-a650-4f8a-991a-54b8f726c4ce')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 5, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 5, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 6, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 6, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 6, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 6, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 6, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 5, 6, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 1, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 3, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 3, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 3, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 3, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 3, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 4, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 4, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 4, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 4, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 4, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 4, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 7, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 7, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 7, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 7, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 6, 7, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 1, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 1, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 1, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 1, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 1, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 2, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 2, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 2, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 2, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 4, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 5, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 5, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 5, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 5, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 5, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 7, 6, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 1, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 1, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 1, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 1, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 1, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 2, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 2, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 2, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 2, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 2, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 3, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 3, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 3, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 3, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 3, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 4, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 4, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 4, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 4, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 4, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 5, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 5, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 5, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 5, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 5, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 6, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 6, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 6, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 8, 6, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 1, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 1, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 1, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 1, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 1, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 2, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 3, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 3, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 3, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 3, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 3, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 3, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 5, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 5, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 5, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 5, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 6, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 6, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 6, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 9, 6, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 1, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 2, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 2, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 2, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 2, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 2, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 3, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 3, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 3, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 3, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 5, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 5, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 5, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 5, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 5, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 6, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 6, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 6, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 6, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 6, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 7, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 7, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 7, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 7, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 8, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 8, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 8, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 8, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 8, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (1, 10, 8, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 3, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 3, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 3, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 3, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 5, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 5, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 5, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 5, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 5, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 6, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 8, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 9, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 9, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 9, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 9, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 9, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 1, 9, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 5, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 5, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 5, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 5, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 5, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 6, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 6, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 6, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 6, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 6, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 6, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 7, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 7, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 7, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 2, 7, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 3, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 3, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 3, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 3, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 3, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 4, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 4, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 4, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 4, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 4, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 4, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 5, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 5, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 5, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 5, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 7, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 7, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 7, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 7, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 7, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 7, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 8, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 8, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 8, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 8, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 3, 8, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 2, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 2, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 2, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 2, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 2, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 3, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 3, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 3, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 3, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 3, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 3, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 4, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 4, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 4, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 4, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 4, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 6, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 6, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 6, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 6, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 7, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 7, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 7, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 7, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 4, 7, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 4, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 4, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 4, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 4, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 4, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 4, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 5, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 5, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 5, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 5, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 5, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 8, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 8, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 8, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 8, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 5, 8, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 5, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 5, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 5, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 5, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 5, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 7, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 7, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 7, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 7, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 7, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 9, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 10, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 10, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 10, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 10, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 10, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 6, 10, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 4, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 4, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 4, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 4, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 4, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 4, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 5, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 5, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 5, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 5, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 5, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 6, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 6, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 6, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 6, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 6, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 7, 6, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 2, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 2, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 2, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 2, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 2, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 3, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 3, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 3, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 3, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 3, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 4, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 4, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 4, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 4, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 4, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 5, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 5, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 5, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 5, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 5, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 5, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 7, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 7, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 7, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 8, 7, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 3, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 3, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 3, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 3, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 3, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 4, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 4, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 4, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 4, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 4, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 4, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 5, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 5, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 5, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 5, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 5, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 6, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 6, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 6, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 6, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 6, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 7, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 7, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 9, 7, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 4, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 4, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 4, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 4, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 5, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 5, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 5, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 5, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 6, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 6, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 6, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 6, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 8, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 8, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 8, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 8, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 8, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 10, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 10, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 10, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 10, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 10, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (3, 10, 10, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 1, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 1, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 1, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 1, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 1, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 3, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 3, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 3, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 3, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 3, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 3, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 5, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 5, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 5, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 5, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 5, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 6, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 6, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 6, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 6, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 6, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 6, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 7, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 7, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 7, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 7, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 7, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 8, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 8, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 8, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 8, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 1, 8, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 3, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 3, N'30d4264c-a650-4f8a-991a-54b8f726c4ce')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 3, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 3, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 3, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 3, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 6, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 6, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 6, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 6, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 6, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 2, 6, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 1, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 1, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 1, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 1, N'6be36785-ba23-4e61-a612-d0350b37d0b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 1, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 3, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 3, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 3, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 3, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 3, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 3, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 5, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 6, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 6, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 6, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 6, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 6, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 3, 6, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 4, 3, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 4, 3, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 4, 3, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 4, 3, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 4, 3, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 2, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 2, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 2, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 2, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 2, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 2, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 3, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 3, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 3, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 3, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 4, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 4, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 4, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 4, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 5, 4, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 2, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 2, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 2, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 2, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 2, N'6be36785-ba23-4e61-a612-d0350b37d0b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 2, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 3, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 3, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 3, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 3, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 3, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 5, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 5, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 5, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 5, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 5, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 7, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 7, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 7, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 7, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 7, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 7, N'c5801d03-427c-40a0-80b8-f7b022f8545d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 8, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 8, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 8, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 8, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 8, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 9, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 9, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 9, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 9, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 6, 9, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 1, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 3, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 3, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 3, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 3, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 3, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 3, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 4, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 4, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 4, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 4, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 4, N'913aed2e-61f1-42d6-bda0-c61b5f601f6e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 4, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 6, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 6, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 6, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 6, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 7, 6, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 1, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 1, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 1, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 1, N'6be36785-ba23-4e61-a612-d0350b37d0b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 1, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 1, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 3, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 3, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 3, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 3, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 3, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 3, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 4, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 4, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 4, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 4, N'913aed2e-61f1-42d6-bda0-c61b5f601f6e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 4, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 5, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 5, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 5, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 5, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 8, 5, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 2, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 2, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 2, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 2, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 2, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 4, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 4, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 4, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 4, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 5, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 5, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 5, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 6, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 6, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 6, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 6, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 7, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 7, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 7, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 7, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 7, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 9, 7, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 3, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 3, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 3, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 3, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 3, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 4, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 4, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 4, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 4, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 4, N'913aed2e-61f1-42d6-bda0-c61b5f601f6e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 5, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 5, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 5, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 5, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 5, N'6be36785-ba23-4e61-a612-d0350b37d0b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 6, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 6, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 6, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 6, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 6, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 8, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 8, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 8, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 8, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 9, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 9, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 9, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 9, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (9, 10, 9, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 5, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 5, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 5, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 5, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 5, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 5, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 6, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 6, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 6, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 6, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 6, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 8, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 1, 9, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 5, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 5, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 5, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 5, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 5, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 5, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 6, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 6, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 6, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 2, 6, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 4, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 4, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 4, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 4, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 4, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 7, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 7, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 7, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 7, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 7, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 8, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 8, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 8, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 8, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 8, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 3, 8, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 3, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 3, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 3, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 3, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 3, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 4, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 4, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 4, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 4, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 4, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 4, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 5, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 5, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 5, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 5, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 6, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 6, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 6, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 6, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 6, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 7, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 7, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 7, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 4, 7, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 5, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 5, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 5, N'913aed2e-61f1-42d6-bda0-c61b5f601f6e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 5, N'6be36785-ba23-4e61-a612-d0350b37d0b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 5, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 7, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 7, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 7, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 7, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 7, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 8, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 8, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 8, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 8, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 5, 8, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 5, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 5, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 5, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 5, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 6, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 6, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 6, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 6, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 6, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 7, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 7, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 7, N'6be36785-ba23-4e61-a612-d0350b37d0b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 7, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 8, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 8, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 8, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 8, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 8, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 8, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 9, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 9, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 9, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 9, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 9, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 10, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 10, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 10, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 10, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 6, 10, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 4, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 4, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 4, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 4, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 4, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 4, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 5, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 5, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 7, 5, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 4, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 6, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 6, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 6, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 6, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 6, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 7, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 7, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 7, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 7, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 7, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 8, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 8, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 8, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 8, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 8, 8, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 4, N'30d4264c-a650-4f8a-991a-54b8f726c4ce')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 4, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 4, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'dbfe1c8b-e059-4545-b992-469e90f4e900')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 9, 7, N'913aed2e-61f1-42d6-bda0-c61b5f601f6e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 4, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 4, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 4, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 4, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 4, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 4, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 8, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 8, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 8, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 8, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 8, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 8, N'd54f9f03-a982-4fd4-bf0b-cc4a902686f4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 9, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 9, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 9, N'970cf274-4629-4661-8d92-cb772df46bc4')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 9, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 9, N'ed8eb9a0-b830-4b65-b426-e0cf83dfbbaf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 11, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 11, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 11, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (12, 10, 11, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 4, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 4, N'00ab9412-f192-44b5-8d28-6a2399ceadcd')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 4, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 4, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 4, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 5, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 6, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 6, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 6, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 1, 6, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 2, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 2, N'edbea6e6-6a25-49b0-8e5b-6994dcd9e376')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 2, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 2, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 3, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 3, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 3, N'30d4264c-a650-4f8a-991a-54b8f726c4ce')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 3, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 3, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 3, N'5f79f40b-1f59-42d6-9661-f61faaab355e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 4, N'36318d5e-6e07-4326-a8c0-6cb9edd54c1a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 4, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 4, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 4, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 4, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 6, N'6f4b3055-d902-4276-a716-0b082eccbdd6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 6, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 6, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 6, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 2, 6, N'4c2f13ad-fc3d-4a1a-a06e-f6c97098787f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 3, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 3, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 3, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 3, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 3, N'c2ac8373-1d95-4312-9074-e398686f4e0a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 3, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 4, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 4, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 4, N'378e8e24-1a59-4494-8ccc-70686dd6eeba')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 4, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 4, N'bea432c1-18fe-4e8c-a269-ee0c1d9f35cb')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 4, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 7, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 7, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 7, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 7, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 7, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 7, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 3, 8, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 3, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 3, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 3, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 3, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 3, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 3, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 5, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 5, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 5, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 5, N'55822730-d436-4834-80c3-8b075816298d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 4, 5, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'cf73cfbf-f024-4d7e-8f90-11008ae14a52')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 3, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 5, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 5, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 5, N'2dda251a-5d75-42eb-bdd3-c8503a2c2b0b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 5, N'0ace10be-3f05-4a01-b93b-dc7156f2c568')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 5, N'8c63c63a-c13a-4409-9d8b-ee27f6247561')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 6, N'3e6268b8-55d1-4713-8dd1-2c1822ef6491')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 6, N'270767c2-26d4-43e8-946a-9d262d378402')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 6, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 6, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 7, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 7, N'44bb2f5c-ed01-4563-a2bf-2ea298715c8d')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 7, N'f215bdd5-b7b6-49e5-a51f-76c4f8da1dbf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 7, N'd00d3992-43f4-4fb2-addc-7b7fc47021f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 5, 7, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 4, N'ad2eed25-53a9-43c6-8de9-4b1da9c61c39')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 4, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 4, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 4, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 4, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 4, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 5, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 5, N'e264d8a8-853b-4b1e-ba24-57889a3e723b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 5, N'49690347-47ff-425a-bc6a-c031440eb07e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 5, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 6, N'c81eec3c-c95a-446a-b6de-5c48a3976e81')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 6, N'8bcf5c3c-85f1-4e95-b6c9-76df4368edc8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 6, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 6, N'625ff4da-b04c-482c-9b35-903874dc04f8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 7, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 7, N'4eaf8233-be11-4330-85c2-37962def0b46')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 7, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 7, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 7, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 7, N'bed09e25-84bd-466b-a0a0-a93f4f303da3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 8, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 8, N'39ca670b-b0db-4f67-b29b-7d3ef7eaf5b2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 8, N'3003802d-6974-4168-9375-d93e0b033f1b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 6, 8, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 3, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 3, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 3, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 3, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 3, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 4, N'02453b5b-4026-4ee8-91f9-0869ab999101')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 4, N'f7c7c693-849a-4081-95c9-28114b152db2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 4, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 4, N'bbabba3a-ac19-4740-8abc-84ac6559525b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 4, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 4, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 5, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 5, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 5, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 7, 5, N'5d89c27d-2715-4f4f-8882-d92ce534b3d9')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 2, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 2, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 2, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 2, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 2, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 2, N'4a815ce0-e185-4057-9fa1-e72bb3aeae45')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 4, N'5cc547f0-cacc-468f-9f0f-42319aec1860')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 4, N'ebcec6ee-e009-447e-8768-5159fbd0ce2f')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 4, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 4, N'81bf3e07-8561-4243-a766-8c252048fff6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 4, N'c84c9547-9573-4dba-b25d-c39f9f9944d7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 5, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 5, N'a5109fc8-29b1-4c9d-b62c-2bb7a675ac16')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 5, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 5, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 7, N'8f2e6911-7131-4b3b-96cd-8f0b13aa2862')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 7, N'9cad079e-ccf5-4aa0-9d95-9b3d74ad5e48')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 8, 7, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 4, N'4ee392df-e790-41b0-aae4-3c986f1adeb2')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 4, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 4, N'441d9cb9-c49d-49d4-aaca-630f7a9cf144')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 4, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 4, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 4, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 5, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 5, N'26670ace-b8d2-479b-99a7-110c2ee6c1f6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 5, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 5, N'827fae2a-50e0-41fc-af36-4e46717c031e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 5, N'f7281e69-85f8-4ee6-b425-8cebcf4b11d3')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 5, N'836f2551-c014-42dd-a092-bbf08b0c2e50')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 6, N'413b6ae2-bf18-4e19-a670-0adaa860e383')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 6, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 6, N'252485e1-5006-4148-97ef-983e56310c7b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 6, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 6, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 6, N'5e647c97-8bef-4a4c-831b-c0d0c3263386')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 7, N'456e4ff1-4f82-4b98-b7cf-0ebbd642aa13')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 7, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 7, N'f9ac05bc-54b2-4ae7-a6df-8765b12fcb6a')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 7, N'74932d5e-7b2e-4b5c-9bab-938337cd3786')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 7, N'76c93dbb-6a78-4385-9957-be92112736ae')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 9, 7, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 2, N'ecd0237b-3d47-441d-af51-28d063202f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 2, N'b057efff-1d83-4759-b88a-93ae0d642212')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 2, N'b1ea135b-cb90-4c6d-ae93-bd4f230234d6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 2, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 2, N'930695cb-c929-4450-b781-ec00ba92495b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 5, N'67ed76d2-c883-43be-9139-51806de52ae5')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 5, N'a97ab275-6035-4a55-82e4-832fbaecf7a8')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 5, N'115ef0da-cc0a-4a39-a463-aef576eadab7')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 5, N'db803423-85f8-4953-8666-afd511ab8ff1')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 5, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 6, N'0b262e36-5856-4add-b33c-72fdff4d8faf')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 6, N'6dad5b95-d8ae-49dc-aaff-ba3852f0c78e')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 6, N'907f2ecf-06cb-47f3-819e-c6db91626f71')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 6, N'8662bb60-485b-4de3-9e77-ed2da7f56182')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 7, N'd14ffbb9-4946-456b-a5df-1ad163185758')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 7, N'15c005d1-0ba8-4890-a675-2b008a42a372')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 7, N'04f83d96-2ff3-4cb8-b4a7-4b4f660696b6')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 7, N'944700cf-1555-4256-bb1b-e016205cd656')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 8, N'2b3699e3-e8d7-4b9a-99a8-52847e421bad')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 8, N'ef3a86dd-ccf0-4dba-8eb8-7507a685164b')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 8, N'ca04842e-95aa-4494-9d84-7e54ad9e3111')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 8, N'9e4ed67f-4ac0-4f1d-8bf1-93b38e4d15da')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 8, N'a7eb350f-2436-4d05-8fd7-b3df1c3e1d61')
GO
INSERT [dbo].[LFTemasBandasEdiciones] ([IDBanda], [IDFestival], [Ordinal], [IDTema]) VALUES (17, 10, 8, N'a27e96be-dd3d-491d-ad0f-f5979490441c')
GO
