CREATE SEQUENCE id_lugar_seq
	START WITH 1
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9999;

CREATE SEQUENCE id_museo_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_obra_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_artista_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_idioma_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_empleado_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_mant_vig_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_estructura_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_ticket_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_expo_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_coleccion_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;

CREATE SEQUENCE id_sala_exp_seq    
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_mantenimiento_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_formacion_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_mant_ob_seq   
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_emp_mant_vig_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_expo_evento_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_estructura_fisica_seq    
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_estructura_org_seq    
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
CREATE SEQUENCE id_cat_museo_seq    
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;
	


CREATE TABLE LUGAR (
    id_lugar NUMERIC PRIMARY KEY DEFAULT nextval('id_lugar_seq'),
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL CHECK (tipo IN ('P', 'C')),
    continente VARCHAR(2) CHECK (continente IN ('AM', 'AF', 'EU', 'AS', 'OC')),
    id_lugar_padre NUMERIC,
    CONSTRAINT FK_LUGAR_PADRE FOREIGN KEY (id_lugar_padre) REFERENCES LUGAR(id_lugar)
);


CREATE TABLE MUSEO (
    id_museo NUMERIC PRIMARY KEY DEFAULT nextval('id_museo_seq'),
    nombre VARCHAR(255) NOT NULL,
    fecha_fund DATE NOT NULL,
    descripcion_museo VARCHAR(2000)
);

CREATE TABLE OBRA_ARTE (
    id_obra NUMERIC PRIMARY KEY DEFAULT nextval('id_obra_seq'),
    nombre_obra VARCHAR(255) NOT NULL,
    fecha DATE NOT NULL,
    estilo_desc VARCHAR(255) NOT NULL,
    tecnicaymateriales_desc VARCHAR(1000) NOT NULL,
    dimensiones VARCHAR(100) NOT NULL,
    tipo VARCHAR(1) NOT NULL CHECK (tipo IN ('P', 'E'))
);


CREATE TABLE ARTISTA (
    id_artista NUMERIC PRIMARY KEY DEFAULT nextval('id_artista_seq'),
    primer_nombre VARCHAR(100),
    primer_apellido VARCHAR(100),
    segundo_nombre VARCHAR(100),
    segundo_apellido VARCHAR(100),
    apodo VARCHAR(100),
    fecha_nac DATE,
    fecha_falle DATE,
    resumen_caracteristicas VARCHAR(2000) NOT NULL,
    CONSTRAINT CHK_FECHA_FALLE_ARTISTA CHECK (fecha_falle > fecha_nac)
);


CREATE TABLE IDIOMA (
    id_idioma NUMERIC PRIMARY KEY DEFAULT nextval('id_idioma_seq'),
    nombre VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE EMP_MANT_VIG (
    id_mant_vig NUMERIC PRIMARY KEY DEFAULT nextval('id_emp_mant_vig_seq'),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    doc_identidad VARCHAR(50) NOT NULL UNIQUE,
    tipo VARCHAR(100) NOT NULL
);


CREATE TABLE EMPLEADO_PRO (
    id_empleado NUMERIC PRIMARY KEY DEFAULT nextval('id_empleado_seq'),
    primer_nombre VARCHAR(100) NOT NULL,
    segundo_nombre VARCHAR(100),
    primer_apellido VARCHAR(100) NOT NULL,
    segundo_apellido VARCHAR(100) NOT NULL,
    fecha_nac DATE NOT NULL,
    docidentidad NUMERIC(50) NOT NULL UNIQUE, 
    contacto_tel VARCHAR(50)
 );


CREATE TABLE ESTRUCTURA_ORG (
    id_museo NUMERIC NOT NULL DEFAULT nextval('id_estructura_org_seq'),
    id_depto NUMERIC NOT NULL,
    nombre_depto VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL CHECK(tipo IN ('DIR','DEPT','SEC')),
    descripcion VARCHAR(1000),
    PRIMARY KEY (id_museo, id_depto),
    CONSTRAINT FK_ESTORG_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo)
);


CREATE TABLE ESTRUCTURA_FISICA (
    id_museo NUMERIC NOT NULL DEFAULT nextval('id_estructura_fisica_seq'),
    id_estructura NUMERIC NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL CHECK (tipo IN('ED','PI','AR')),
    descripcion VARCHAR(1000),
    direccion_edificio VARCHAR(500),
    id_lugar NUMERIC,
    id_estructura_padre NUMERIC,
    PRIMARY KEY (id_museo, id_estructura),
    CONSTRAINT FK_ESTFIS_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo),
    CONSTRAINT FK_ESTFIS_LUGAR FOREIGN KEY (id_lugar) REFERENCES LUGAR(id_lugar),
    CONSTRAINT FK_ESTFIS_PADRE FOREIGN KEY (id_museo, id_estructura_padre) REFERENCES ESTRUCTURA_FISICA(id_museo, id_estructura)
);

CREATE TABLE TICKET (
    id_museo NUMERIC NOT NULL DEFAULT nextval('id_ticket_seq'),
    id_ticket NUMERIC NOT NULL,
    fechayhora_ticket TIMESTAMP NOT NULL,
    costo_ticket DECIMAL(10, 2) NOT NULL,
    tipo_ticket VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_museo, id_ticket),
    CONSTRAINT FK_TICKET_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo)
);


CREATE TABLE HORARIO_MUSEO (
    id_museo NUMERIC NOT NULL,
    dia DATE NOT NULL,
    hora_apertura VARCHAR(5) NOT NULL,
    hora_cierra VARCHAR(5) NOT NULL,
    PRIMARY KEY (id_museo, dia),
    CONSTRAINT FK_HORARIO_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo)
);

CREATE TABLE HISTORIA_MUSEO (
    id_museo NUMERIC NOT NULL,
    año DATE NOT NULL, 
    hechos VARCHAR(2000) NOT NULL,
    PRIMARY KEY (id_museo, año),
    CONSTRAINT FK_HISTORIA_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo)
);


CREATE TABLE TIPO_TICKET (
    id_museo NUMERIC NOT NULL,
    fecha_ini DATE NOT NULL,
    tipo VARCHAR(3) NOT NULL CHECK (tipo IN ('NI', 'AD', 'AN', 'EST')),
    precio NUMERIC(10, 2) NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (id_museo, fecha_ini, tipo),
    CONSTRAINT FK_TIPOTICKET_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo),
    CONSTRAINT CHK_FECHA_FIN_TIPOTICKET CHECK (fecha_fin IS NULL OR fecha_fin > fecha_ini)
);

CREATE TABLE EXPO_EVENTO (
    id_museo NUMERIC NOT NULL DEFAULT nextval('id_expo_evento_seq'),
    id_expo VARCHAR(50) NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    fecha_ini DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    ubicacion VARCHAR(255) NOT NULL,
    institucion_edu VARCHAR(150),
    costo_persona NUMERIC(10, 2),
    cantidad_visitantes NUMERIC,
    PRIMARY KEY (id_museo, id_expo),
    CONSTRAINT FK_EXPOEVENTO_MUSEO FOREIGN KEY (id_museo) REFERENCES MUSEO(id_museo),
    CONSTRAINT CHK_FECHA_FIN_EXPOEVENTO CHECK (fecha_fin > fecha_ini)
);

CREATE TABLE ART_OBR (
    id_artista NUMERIC NOT NULL,
    id_obra NUMERIC NOT NULL,
    PRIMARY KEY (id_artista, id_obra),
    CONSTRAINT FK_ARTOBR_ARTISTA FOREIGN KEY (id_artista) REFERENCES ARTISTA(id_artista),
    CONSTRAINT FK_ARTOBR_OBRA FOREIGN KEY (id_obra) REFERENCES OBRA_ARTE(id_obra)
);


CREATE TABLE FORMACION_PROF (
    id_empleado NUMERIC NOT NULL DEFAULT nextval('id_formacion_seq'),
    id_formacion NUMERIC NOT NULL,
    titulo_profesional VARCHAR(255) NOT NULL,
    especialidad_descripcion VARCHAR(255) NOT NULL,
    año DATE NOT NULL,
    PRIMARY KEY (id_empleado, id_formacion),
    CONSTRAINT FK_FORMACION_EMPLEADO FOREIGN KEY (id_empleado) REFERENCES EMPLEADO_PRO(id_empleado)
);

CREATE TABLE EMP_IDIOMA (
    id_empleado NUMERIC NOT NULL,
    id_idioma NUMERIC NOT NULL,
    PRIMARY KEY (id_empleado, id_idioma),
    CONSTRAINT FK_EMPIDIOMA_EMPLEADO FOREIGN KEY (id_empleado) REFERENCES EMPLEADO_PRO(id_empleado),
    CONSTRAINT FK_EMPIDIOMA_IDIOMA FOREIGN KEY (id_idioma) REFERENCES IDIOMA(id_idioma)
);

CREATE TABLE HIST_CARGO (
    id_empleado NUMERIC NOT NULL,
    id_museo NUMERIC NOT NULL,
    id_depto NUMERIC NOT NULL,
    fecha_ini DATE NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (id_empleado, id_museo, id_depto, fecha_ini),
    CONSTRAINT FK_HISTCARGO_EMPLEADO FOREIGN KEY (id_empleado) REFERENCES EMPLEADO_PRO(id_empleado),
    CONSTRAINT FK_HISTCARGO_ESTORG FOREIGN KEY (id_museo, id_depto) REFERENCES ESTRUCTURA_ORG(id_museo, id_depto),
    CONSTRAINT CHK_FECHA_FIN_HISTCARGO CHECK (fecha_fin > fecha_ini)
);


CREATE TABLE COLECCION_PERMANENTE (
    id_museo NUMERIC NOT NULL,
    id_depto NUMERIC NOT NULL,
    id_coleccion NUMERIC NOT NULL DEFAULT nextval('id_coleccion_seq'),
    nombre_coleccion VARCHAR(255) NOT NULL,
    descripcion_coleccion VARCHAR(2000) NOT NULL,
    palabra_clave VARCHAR(255) NOT NULL,
    orden_recorrido NUMERIC NOT NULL,
    PRIMARY KEY (id_museo, id_depto, id_coleccion),
    CONSTRAINT FK_COLECCION_ESTORG FOREIGN KEY (id_museo, id_depto) REFERENCES ESTRUCTURA_ORG(id_museo, id_depto)
);


CREATE TABLE SALA_EXP (
    id_museo NUMERIC NOT NULL,
    id_estructura NUMERIC NOT NULL,
    id_sala NUMERIC NOT NULL DEFAULT nextval('id_sala_exp_seq'),
    nombre_sala VARCHAR(255) NOT NULL,
    descripcion VARCHAR(1000),
    PRIMARY KEY (id_museo, id_estructura, id_sala),
    CONSTRAINT FK_SALAEXP_ESTFIS FOREIGN KEY (id_museo, id_estructura) REFERENCES ESTRUCTURA_FISICA(id_museo, id_estructura)
);


CREATE TABLE OBRA_HIST (
    id_obra NUMERIC NOT NULL,
    id_cat_museo NUMERIC NOT NULL DEFAULT nextval('id_cat_museo_seq'),
    fecha_adq DATE NOT NULL,     
    forma_adq VARCHAR(4) NOT NULL CHECK (forma_adq IN ('ADQ', 'DONA', 'HALL')),
    destacada VARCHAR(2) NOT NULL CHECK (destacada IN ('SI', 'NO')),
    fin_adq DATE,
    orden_recorrido NUMERIC,
    valor_monetario NUMERIC(12, 2),
    id_museo NUMERIC,
    id_depto NUMERIC,
    id_coleccion NUMERIC, 
    id_estructura NUMERIC,
    id_sala NUMERIC,
    id_empleado_responsable NUMERIC, 
    PRIMARY KEY (id_obra, id_cat_museo),
    CONSTRAINT FK_OBRAHIST_OBRA FOREIGN KEY (id_obra) REFERENCES OBRA_ARTE(id_obra),
    CONSTRAINT FK_OBRAHIST_COLECCION FOREIGN KEY (id_museo, id_depto, id_coleccion) REFERENCES COLECCION_PERMANENTE(id_museo, id_depto, id_coleccion),
    CONSTRAINT FK_OBRAHIST_SALA FOREIGN KEY (id_museo, id_estructura, id_sala) REFERENCES SALA_EXP(id_museo, id_estructura, id_sala),
    CONSTRAINT FK_OBRAHIST_EMPLEADO FOREIGN KEY (id_empleado_responsable) REFERENCES EMPLEADO_PRO(id_empleado),
    CONSTRAINT CHK_VALOR_ADQ CHECK ((forma_adq = 'ADQ' AND valor_monetario > 0) OR (forma_adq IN ('DONA', 'HALL') AND valor_monetario IS NULL) OR (forma_adq = 'ADQ' AND valor_monetario IS NULL))
);


CREATE TABLE MANTENIMIENTO_OBRA (
    id_obra NUMERIC NOT NULL,
    id_cat_museo NUMERIC NOT NULL,
    id_mantenimiento NUMERIC NOT NULL DEFAULT nextval('id_mant_ob_seq'),
    frecuencia VARCHAR(5) NOT NULL CHECK (frecuencia IN ('MEN', 'BI', 'TRI', 'CUA','SEM','AN')),
    actividad VARCHAR(1000) NOT NULL,
    tipo_responsable VARCHAR(100) NOT NULL CHECK (tipo_responsable IN ('CUR', 'RES', 'OTR')),
    PRIMARY KEY (id_obra, id_cat_museo, id_mantenimiento),
    CONSTRAINT FK_MANTOBRA_OBRA_HIST FOREIGN KEY (id_obra, id_cat_museo) REFERENCES OBRA_HIST(id_obra, id_cat_museo)
);


CREATE TABLE REALIZADO (
    id_obra NUMERIC NOT NULL,
    id_cat_museo NUMERIC NOT NULL,
    id_mantenimiento NUMERIC NOT NULL,
    id_realizado NUMERIC NOT NULL,
    id_empleado_ejecutor NUMERIC NOT NULL,
    fecha_ini DATE NOT NULL,
    fecha_fin DATE,
    observaciones VARCHAR(500),
    PRIMARY KEY (id_obra, id_cat_museo, id_mantenimiento, id_empleado_ejecutor, id_realizado),
    CONSTRAINT FK_REALIZADO_MANTOBRA FOREIGN KEY (id_obra, id_cat_museo, id_mantenimiento) REFERENCES MANTENIMIENTO_OBRA(id_obra, id_cat_museo, id_mantenimiento),
    CONSTRAINT FK_REALIZADO_EMPLEADO FOREIGN KEY (id_empleado_ejecutor) REFERENCES EMPLEADO_PRO(id_empleado),
    CONSTRAINT CHK_FECHA_FIN_REALIZADO CHECK (fecha_fin >= fecha_ini)
);

CREATE TABLE SAL_COL (
    id_museo1 NUMERIC NOT NULL,
    id_depto NUMERIC NOT NULL,
    id_coleccion NUMERIC NOT NULL,
    id_museo2 NUMERIC NOT NULL,
    id_estructura NUMERIC NOT NULL,
    id_sala NUMERIC NOT NULL,
    orden_recorrido NUMERIC NOT NULL,
    PRIMARY KEY (id_museo1, id_depto, id_coleccion, id_museo2, id_estructura, id_sala),
    CONSTRAINT FK_SALCOL_COLECCION FOREIGN KEY (id_museo1, id_depto, id_coleccion) REFERENCES COLECCION_PERMANENTE(id_museo, id_depto, id_coleccion),
    CONSTRAINT FK_SALCOL_SALA FOREIGN KEY (id_museo2, id_estructura, id_sala) REFERENCES SALA_EXP(id_museo, id_estructura, id_sala)
);


CREATE TABLE CIERRE_HIST (
    id_museo NUMERIC NOT NULL,
    id_estructura NUMERIC NOT NULL,
    id_sala NUMERIC NOT NULL,
    fecha_ini DATE NOT NULL,
    fecha_fin DATE,
    PRIMARY KEY (id_museo, id_estructura, id_sala, fecha_ini),
    CONSTRAINT FK_CIERREHIST_SALA FOREIGN KEY (id_museo, id_estructura, id_sala) REFERENCES SALA_EXP(id_museo, id_estructura, id_sala),
    CONSTRAINT CHK_FECHA_FIN_CIERREHIST CHECK (fecha_fin > fecha_ini)
);


CREATE TABLE ASIGNACION_MES (
    id_mant_vig NUMERIC NOT NULL,
    id_museo NUMERIC NOT NULL,
    id_depto NUMERIC NOT NULL,
    mes_año VARCHAR(7) NOT NULL,
    turno VARCHAR(50) NOT NULL CHECK (turno IN ('MAT','VES','NOC')),
    PRIMARY KEY (id_mant_vig, id_museo, id_depto, mes_año),
    CONSTRAINT FK_ASIGMES_EMPMANTVIG FOREIGN KEY (id_mant_vig) REFERENCES EMP_MANT_VIG(id_mant_vig),
    CONSTRAINT FK_ASIGMES_ESTORG FOREIGN KEY (id_museo, id_depto) REFERENCES ESTRUCTURA_ORG(id_museo, id_depto)
);


--Triggers

CREATE OR REPLACE FUNCTION chequear_asignacion_curador()
RETURNS TRIGGER AS $$
DECLARE
    is_curator BOOLEAN := FALSE;
BEGIN
    IF NEW.id_empleado_responsable IS NOT NULL THEN
        SELECT EXISTS (
            SELECT 1
            FROM HIST_CARGO hc
            WHERE hc.id_empleado = NEW.id_empleado_responsable
              AND (hc.cargo ILIKE '%Curador%')
              AND (hc.fecha_fin IS NULL OR hc.fecha_fin >= CURRENT_DATE)
        ) INTO is_curator;

        IF NOT is_curator THEN
            RAISE EXCEPTION 'El empleado asignado (ID: %) no es un curador o no tiene un rol de curador activo.', NEW.id_empleado_responsable;
        END IF;
    ELSE
         RAISE EXCEPTION 'Se debe asignar un curador responsable a la obra de arte.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_chequear_asignacion_curador
BEFORE INSERT OR UPDATE ON OBRA_HIST
FOR EACH ROW
WHEN (NEW.id_empleado_responsable IS NOT NULL)
EXECUTE FUNCTION chequear_asignacion_curador();



CREATE OR REPLACE FUNCTION prevenir_duplicado_hist_cargo()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM HIST_CARGO
        WHERE id_empleado = NEW.id_empleado
          AND (id_museo != NEW.id_museo OR id_depto != NEW.id_depto OR fecha_ini != NEW.fecha_ini)
          AND tstzrange(NEW.fecha_ini, NEW.fecha_fin, '[)') && tstzrange(fecha_ini, fecha_fin, '[)') 
    ) THEN
        RAISE EXCEPTION 'El nuevo período de cargo para el empleado ID % en el museo ID % y depto ID % se superpone con un período existente.',
                        NEW.id_empleado, NEW.id_museo, NEW.id_depto;
    END IF;


    IF NEW.fecha_fin IS NULL THEN
        IF EXISTS (
            SELECT 1
            FROM HIST_CARGO
            WHERE id_empleado = NEW.id_empleado
              AND fecha_fin IS NULL
              AND (id_museo != NEW.id_museo OR id_depto != NEW.id_depto OR fecha_ini != NEW.fecha_ini)
        ) THEN
            RAISE EXCEPTION 'El empleado ID % ya tiene un cargo actual (fecha_fin IS NULL) en el historial.', NEW.id_empleado;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevenir_duplicado_hist_cargo
BEFORE INSERT OR UPDATE ON HIST_CARGO
FOR EACH ROW
EXECUTE FUNCTION prevenir_duplicado_hist_cargo();




--Inserts
INSERT INTO LUGAR (id_lugar, nombre, tipo, continente, id_lugar_padre) VALUES
('Holanda', 'P', 'EU', NULL),
('Inglaterra', 'P', 'EU', NULL),
('Francia', 'P', 'EU', NULL),
('Alemania', 'P', 'EU', NULL),
('Amsterdam', 'C', 'EU', 1),
('Londres', 'C', 'EU', 2),
('La Rochelle', 'C', 'EU', 3),
('Caen', 'C', 'EU', 3),
('Berlin', 'C', 'EU', 4);

INSERT INTO MUSEO (nombre, fecha_fund, descripcion_museo) VALUES
('Museo Van Gogh', '02-06-1971', 'La misión del Museo Van Gogh es hacer la vida y obra de Vincent van Gogh y el arte de su tiempo accesibles a la mayor cantidad de personas posible. Buscan enriquecer e inspirar a una audiencia diversa. El museo se enfoca en cuidar, exhibir, investigar y expandir su colección para las futuras generaciones.'),
('Museo Casa de Rembrandt', '10-06-1911', 'El Museo Casa de Rembrandt busca sumergir al visitante en la vida y obra del maestro holandés. Preserva y exhibe la casa donde vivió y trabajó, junto con una importante colección de sus grabados. Su objetivo es inspirar y fomentar un mayor interés en el extraordinario legado cultural de Rembrandt.'),
('Natural History Museum de Londres', '18-04-1881', 'La misión del Museo de Historia Natural de Londres es inspirar una apreciación más profunda de la naturaleza y nuestra relación con ella. Para lograrlo, se dedica a mantener y desarrollar sus colecciones de talla mundial, utilizándolas para impulsar la investigación científica y la educación pública. '),
('National Gallery de Londres', '10-05-1824', 'La misión de la National Gallery de Londres se centra en la preservación y enriquecimiento de su invaluable colección de pinturas, asegurando que este patrimonio artístico perdure para las futuras generaciones. Simultáneamente, busca garantizar el acceso universal a estas obras, permitiendo que un público diverso las explore y disfrute con propósitos educativos y de ocio. '),
('Musée d’Histoire Naturelle de La Rochelle', '30-04-1832', 'La misión del Musée d''Histoire Naturelle de La Rochelle es ofrecer una perspectiva única sobre la naturaleza local y global, uniendo la historia natural con la etnografía. Busca inspirar la comprensión del territorio y las diversas culturas a través de sus extensas colecciones, promoviendo el conocimiento científico y la educación para todos los públicos.'),
('Musée de Normandie', '05-07-1946', 'La misión del Musée de Normandie es preservar y exhibir el patrimonio histórico y etnográfico de Normandía, desde la prehistoria hasta la actualidad. Se esfuerza por promover una comprensión profunda de la identidad regional, sus paisajes, sus habitantes y sus actividades a través de sus colecciones.'),
('Aster 3D TrickArt', '03-08-2024', 'La misión de Aster 3D TrickArt es crear experiencias inmersivas y divertidas a través del arte tridimensional que juega con la percepción visual. Busca desafiar la imaginación de los visitantes y fomentar la interacción con las obras, permitiéndoles formar parte activa de las ilusiones.'),
('Museo de Pérgamow', '26-09-1910', 'La misión del Museo de Pérgamo es preservar y exhibir colecciones de arte y arquitectura de la antigüedad y el Cercano Oriente, así como arte islámico. Se enfoca en presentar estas culturas en su contexto histórico y cultural, permitiendo a los visitantes una inmersión profunda en civilizaciones pasadas. ');
