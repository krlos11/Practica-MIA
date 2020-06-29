-- PRACTICA 1 - MIA - 2020
-- carlos lopez - 201313894


-- **********************************************************************************************************************************************************
-- CREACION DE TABLAS  1  *****************************************************************************
-- **********************************************************************************************************************************************************

create table profesion(
cod_prof integer not null,
nombre varchar(50) not null,
primary key (cod_prof),
constraint unique_profesion unique(nombre)
);
create table pais(
cod_pais integer not null,		
nombre varchar(50) not null,
primary key (cod_pais),
constraint unique_pais unique(nombre)
);
create table miembro(
cod_miembro integer not null,
nombre varchar(100) not null,
apellido varchar(100) not null,
edad integer not null,
telefono integer,
residencia varchar(100),
PAIS_cod_pais integer not null,
PROFESION_cod_prof integer not null,
primary key (cod_miembro),
constraint const_cod_pais foreign key (PAIS_cod_pais) references pais(cod_pais),
constraint const_cod_prof foreign key (PROFESION_cod_prof) references profesion(cod_prof)
);


create table puesto(
cod_puesto integer not null,
nombre varchar(50) not null,
primary key (cod_puesto),
constraint uniq_puesto unique(nombre)
);
create table departamento(
cod_depto integer not null,
nombre varchar(50) not null,
primary key(cod_depto),
constraint unique_departamento unique(nombre)
);
create table puesto_miembro(
MIEMBRO_cod_miembro integer not null,
PUESTO_cod_puesto integer not null,
DEPARTAMENTO_cod_depto integer not null,
fecha_inicio date not null,
fecha_fin date,
primary key (MIEMBRO_cod_miembro, PUESTO_cod_puesto, DEPARTAMENTO_cod_depto),
constraint const_cod_miembro  foreign key(MIEMBRO_cod_miembro) references miembro(cod_miembro),
constraint const_cod_puesto foreign key(PUESTO_cod_puesto) references puesto(cod_puesto),
constraint const_cod_depto foreign key(DEPARTAMENTO_cod_depto) references departamento(cod_depto)
);


create table tipo_medalla(
cod_tipo integer not null,
medalla varchar(20) not null,
primary key (cod_tipo),
constraint const_uniq_tipo_medalla unique (medalla)
);
create table medallero(
PAIS_cod_pais integer not null,
TIPO_MEDALLA_cod_tipo integer not null,
cantidad_medallas integer not null,
primary key(PAIS_cod_pais, TIPO_MEDALLA_cod_tipo),
constraint const_cod_pais foreign key (PAIS_cod_pais) references pais(cod_pais),
constraint const_cod_tipo foreign key (TIPO_MEDALLA_cod_tipo) references tipo_medalla(cod_tipo)
);


create table disciplina(
cod_disciplina integer not null,
nombre varchar(50) not null,
descripcion varchar(150),
primary key (cod_disciplina)
);
create table atleta(
cod_atleta integer primary key not null,
nombre varchar(50) not null,
apellido varchar(50) not null,
edad integer not null,
participaciones varchar(100) not null,
DISCIPLINA_cod_disciplina integer not null,
PAIS_cod_pais integer not null,
constraint const_cod_disciplina foreign key (DISCIPLINA_cod_disciplina) references disciplina(cod_disciplina),
constraint const_cod_pais foreign key (PAIS_cod_pais) references pais(cod_pais)
);
create table categoria(
cod_categoria integer not null,
categoria varchar(50) not null,
primary key (cod_categoria)
);
create table tipo_participacion(
cod_participacion integer not null,
tipo_participacion varchar(100) not null,
primary key(cod_participacion)
);
create table evento(
cod_evento integer not null,
fecha date not null,
ubicacion varchar(50) not null,
hora time not null,
DISCIPLINA_cod_disciplina integer not null,
TIPO_PARTICIPACION_cod_participacion integer not null,
CATEGORIA_cod_categoria integer not null,
primary key(cod_evento),
constraint const_cod_disciplina foreign key (DISCIPLINA_cod_disciplina) references disciplina(cod_disciplina),
constraint const_cod_participacion foreign key (TIPO_PARTICIPACION_cod_participacion) references tipo_participacion(cod_participacion),
constraint const_cod_categoria foreign key (CATEGORIA_cod_categoria) references categoria(cod_categoria)
);
create table televisora(
cod_televisora integer not null,
nombre varchar(50) not null,
primary key(cod_televisora)
);
create table evento_atleta(
ATLETA_cod_atleta integer not null,
EVENTO_cod_evento integer not null,
primary key (ATLETA_cod_atleta, EVENTO_cod_evento),
constraint const_cod_atleta foreign key (ATLETA_cod_atleta) references atleta(cod_atleta),
constraint const_cod_evento foreign key (EVENTO_cod_evento) references evento(cod_evento)
);
create table costo_evento(
EVENTO_cod_evento integer not null,
TELEVISORA_cod_televisora integer not null,
tarifa integer not null,
primary key(EVENTO_cod_evento, TELEVISORA_cod_televisora)
);


-- **********************************************************************************************************************************************************
-- 2  *****************************************************************************
-- **********************************************************************************************************************************************************

select * from evento;
alter table evento drop fecha; 	-- 24/7/2020
alter table evento drop hora;	-- 11:00:00


-- permite agregar fecha + hora  (24/7/2020 11:00:00) 
alter table evento add column fecha_hora timestamp;



-- **********************************************************************************************************************************************************
-- 3  *****************************************************************************
-- **********************************************************************************************************************************************************
alter table evento add constraint restriccion_hora1
check (fecha_hora between '24/7/2020 9:00:00' and '09/8/2020 20:00:00');



-- **********************************************************************************************************************************************************
-- 4  *****************************************************************************
-- **********************************************************************************************************************************************************
-- a
create table sede(
codigo integer not null,
sede varchar(50) not null,
primary key(codigo)
);
-- b
alter table evento alter column ubicacion type integer using cast(ubicacion as integer);
select * from evento;
-- c
alter table evento add constraint ubicacion foreign key (ubicacion) references sede(codigo);



-- **********************************************************************************************************************************************************
-- 5  *****************************************************************************
-- **********************************************************************************************************************************************************
alter table miembro alter telefono set default 0;





-- **********************************************************************************************************************************************************
-- INSERCION DE DATOS 6  *****************************************************************************
-- **********************************************************************************************************************************************************
insert into pais values	(1, 'Guatemala'), 
			(2, 'Francia'), 
			(3, 'Argentina'), 
			(4, 'Alemania'), 
			(5, 'Itallia'), 
			(6, 'Brasil'), 
			(7, 'Estados unidos');




insert into profesion values (1, 'Médico'), (2, 'Arquitecto'), (3, 'Ingeniero'), (4, 'Secretaria'), (5,'Auditor');

insert into miembro values (1, 'scott', 'Mitchell', 32, null, '1092 Highland Drive Manitowoc, WI 54220', 7, 3),
		           (2, 'Fanette', 'Poulin', 25, 25075853, '49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY', 2,4),
		           (3, 'Laura', 'Cunha Silva', 55, null, 'Rua Onze, 86 Uberraba-MG', 6, 5),
		           (4, 'Juan José', 'López', 38, 36985247, '26 calle 4-10 zona 11', 1, 2),
		           (5, 'Arcangela', 'Panicucci', 39, 391664921, 'Via Santa Teresa, 114 90010-Geraci Siculo PA', 5, 1),
		           (6,'Jeuel', 'Villalpando', 31, null, 'Acuña de Figeroa 6106 80101 Playa Pascual', 3, 5);
                
insert into disciplina values (1, 'Atletismo', 'Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco.'),
		              (2, 'Bádminton', null),
		              (3, 'Ciclismo', null),
		              (4, 'Judo', 'Es un arte marcial que se originó en Japón alrededor de 1880'),
		              (5, 'Lucha',  null),
		              (6, 'Tenis de Mesa', null),
		              (7, 'Boxeo', null),
		              (8, 'Natación', 'Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.'),
		              (9, 'Esgrima', null),
		              (10, 'Vela', null);
                

insert into tipo_medalla values	(1, 'Oro'), (2, 'Plata'), (3, 'Bronce'), (4, 'Platino');

insert into categoria values 	(1, 'Clasificatorio'), (2, 'Eliminatorio'), (3, 'Final');

insert into tipo_participacion values	(1, 'Individual'), (2, 'Pareja'), (3, 'Equipos');

insert into medallero values (5, 1, 3),
		             (2, 1, 5),
		             (6, 3, 4),
		             (4, 4, 3),
		             (7, 3, 10),
		             (3, 2, 8),
		             (1, 1, 2),
		             (1, 4, 5),
		             (5, 2, 7);


insert into sede values	(1, 'Gimnasio Metropolitano de Tokio'), (2, 'Jardín del Palacio Imperial de Tokio'),
			(3, 'Gimnasio Nacional Yoyogi'), 	(4, 'Nippon Budokan'), 
                        (5, 'Estadio Olímpico');
                                                

insert into evento values	(1, 3, 2, 2, 1, '24-7-2020 11:00:00'),
				(2, 1, 6, 1, 3, '26-7-2020 10:30:00'),
				(3, 5, 7, 1, 2, '30-7-2020 18:45:00'),
				(4, 2, 1, 1, 1, '01-8-2020 12:15:00'),
				(5, 4, 10, 3, 1, '08-8-2020 19:35:00');



-- **********************************************************************************************************************************************************
-- 7  *****************************************************************************
-- **********************************************************************************************************************************************************
alter table pais drop constraint unique_pais;
alter table tipo_medalla drop constraint const_uniq_tipo_medalla;
alter table departamento drop constraint unique_departamento;




-- **********************************************************************************************************************************************************
-- 8  *****************************************************************************
-- **********************************************************************************************************************************************************
-- a
alter table atleta drop DISCIPLINA_cod_disciplina;

-- b
create table Disciplina_Atleta(
cod_atleta integer not null,
cod_disciplina integer not null,
primary key(cod_atleta, cod_disciplina),
constraint ATLETA_cod_atleta foreign key(cod_atleta) references atleta(cod_atleta),
constraint DISCIPLINA_cod_disciplina foreign key(cod_disciplina) references disciplina(cod_disciplina)
);




-- **********************************************************************************************************************************************************
-- 9  *****************************************************************************
-- **********************************************************************************************************************************************************
alter table costo_evento alter column tarifa type decimal(10,2) using (tarifa::decimal(10,2));


-- **********************************************************************************************************************************************************
-- 11  *****************************************************************************
-- **********************************************************************************************************************************************************
drop table televisora;
drop table costo_evento;



-- **********************************************************************************************************************************************************
-- 13  *****************************************************************************
-- **********************************************************************************************************************************************************
update miembro set telefono = 55464601 where nombre = 'Laura' and apellido = 'Cunha Silva';
update miembro set telefono = 91514243 where nombre = 'Jeuel' and apellido = 'Villalpando';
update miembro set telefono = 920686670 where nombre = 'scott' and apellido = 'Mitchell';



-- **********************************************************************************************************************************************************
-- 14  *****************************************************************************
-- **********************************************************************************************************************************************************
alter table atleta add column fotografia oid;



-- **********************************************************************************************************************************************************
-- 15  *****************************************************************************
-- **********************************************************************************************************************************************************
alter table atleta add constraint minimos_edad check(edad < 25);

