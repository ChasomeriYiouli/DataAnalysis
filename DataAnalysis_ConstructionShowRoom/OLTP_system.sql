ALTER TABLE RawConstructionData ADD RCID int identity(1,1) not null
GO
ALTER TABLE RawConstructionData

add CONSTRAINT pk_RawConstructionData_RCID primary key(RCID)
GO
--ALTER TABLE table_name ADD new_column int NOT NULL AUTO_INCREMENT primary key--


ALTER TABLE Schedule ADD SID int identity(1,1) not null
ALTER TABLE Schedule
add CONSTRAINT pk_Schedule_SID primary key(SID)


ALTER TABLE Floor
add CONSTRAINT pk_Floor_FloorID primary key(FloorID)

ALTER TABLE Building
add CONSTRAINT pk_Building_BuildingID primary key(BuildingID)

ALTER TABLE Trade
add CONSTRAINT pk_Trade_Trade primary key(Trade)


-- Fix the error on the Scope of 18 records in the RawConstructionData table
UPDATE RawConstructionData
SET	Scope = 'PRS_BO_STR'
FROM RawConstructionData
WHERE Scope = 'PRB_BO_STR'

-- Build Normalized Tables. Create Table Scope

Create Table Scope (
    Scope_id int identity(1,1) not null,
    BuildingID varchar(MAX) not null, 
    FloorID varchar(MAX) not null,
    TradeID varchar(MAX) not null,
    primary key (Scope_id))

INSERT INTO Scope(BuildingID,FloorID,TradeID)
values ('PRS','BO','STR'),('PRS','BO','ARC'),('PRS','BO','MEC'),('PRS','BO','ELE'),
('PRS','L0','STR'),('PRS','L0','ARC'),('PRS','L0','MEC'),('PRS','L0','ELE'),
('PRS','L1','STR'),('PRS','L1','ARC'),('PRS','L1','MEC'),('PRS','L1','ELE'),
('PRS','L2','STR'),('PRS','L2','ARC'),('PRS','L2','MEC'),('PRS','L2','ELE'),
('PRS','RF','STR'),('PRS','RF','ARC'),('PRS','RF','MEC'),('PRS','RF','ELE')

UPDATE RawConstructionData
set RawCS = Scope.Scope_id
FROM RawConstructionData INNER JOIN Scope ON RawConstructionData.Scope = Scope.ScopeID

select * from RawConstructionData


----RENAME COLUMN---
Alter Table RawConstructionData Drop column Scope
EXEC sp_rename 'RawconstructionData.RawCS', 'Scope'; 

---ADD FOREIGN KEY--
ALTER TABLE RawconstructionData
ADD CONSTRAINT FK_Scope
FOREIGN KEY (Scope) REFERENCES Scope(Scope_id);
--CHANGE VARCHAR TO INT--
alter table RawconstructionData alter column Scope int;
alter table Scope drop column ScopeID



create table construction_elements (construction_id int identity(1,1) not null primary key, 
construction_elem_type varchar (MAX), construction_elem_family varchar (MAX), 
construction_elem_part varchar (MAX))


INSERT INTO construction_elements(construction_elem_type,construction_elem_family,construction_elem_part)
values ('Protection Layer','ProtectionWork','Basement Protection Layer FF'),
('Protection Layer','ProtectionWork','Basement Protection Layer LF'),
('Protection Layer','ProtectionWork','DOW'),
('Protection Layer','ProtectionWork','DOW 3cm'),
('Protection Layer','ProtectionWork','DOW 3cm LF'),
('Protection Layer','ProtectionWork','PIT Protection Layer LF'),
('Protection Layer','ProtectionWork','Prot.Layer for Ramp Walls & Roof'),
('Protection Layer','ProtectionWork','Prot.Layer for slab +0.25'),
('Protection Layer','ProtectionWork','Protection Layer GF'),
('Protection Layer','ProtectionWork','Roof Protection Layer FF'),
('Protection Layer','ProtectionWork','Roof Protection Layer LF - 2cm'),
('Earth Work','Earth Work','Earthwork for Elevator Pits - FF'),
('Earth Work','Earth Work','Earthwork for Mat Foundation - FF'),
('Earth Work','Earth Work','Earthwork for Rainwater Tank - FF'),
('Earth Work','Earth Work','Earthwork for Septic Tank - FF'),
('Formwork','Formwork','POS for Slabs'),
('Beam','Concretework','RC_Beam C-B'),
('Beam','Concretework','RC_Beam C-C/C-CW'),
('Beam','Concretework','RC_Beam C-RW'),
('Columns','Concretework','RC_CoL_eX'),
('Columns','Concretework','RC_CoL_Int'),
('ConcreteWall','Concretework','RC_CW'),
('ConcreteWall','Concretework','RC_CW (standalone)'),
('ConcreteWall','Concretework','RC_CW (standard)'),
('ConcreteWall','Concretework','RC_CW (W)'),
('ConcreteWall','Concretework','RC_CW (W-W/W-C)'),
('Mat Foundation','Concretework','RC_MF'),
('Mat Foundation','Concretework','RC_MF-LF'),
('Parapet','Concretework','RC_Parapet'),
('Ramp','Concretework','RC_Ramp'),
('Retaining Wall','Concretework','RC_RW/(CW/C-C)'),
('Retaining Wall','Concretework','RC_RW/(RW-C)'),
('Slab','Concretework','RC_Slab'),
('Slab','Concretework','RC_Slab S15'),
('Stair','Concretework','RC_Stair Filling'),
('Stair','Concretework','RC_StairFlight'),
('Stair','Concretework','RC_StairLanding')

create table construction_elements (construction_id int identity(1,1) not null primary key, 
construction_elem_type varchar (MAX), construction_elem_family varchar (MAX), 
construction_elem_part varchar (MAX))

create table activity (activity_id int not null primary key, activity_code int not null, 
activity_desc varchar(MAX), floor_id nvarchar(50) not null foreign key references floor);

CREATE TABLE BOQ(
    BOQ_id INT identity(1,1) NOT NULL,
    BOQ VARCHAR(120) NOT NULL,
    BOQ_Category VARCHAR(120) NOT NULL,
    BOQ_Description VARCHAR(120) NOT NULL,
    Unit_Price INT, 
    Unit VARCHAR(32) NOT NULL,
	activity_id int NOT NULL foreign key references activity,
    primary key (BOQ_id));

create table Description(Desc_ID int identity(1,1) not null primary key,  ID INT not null ,Length float, Thickness Float, Height Float, X Float, Y Float, Z Float)
drop table Description
Alter Table RawConstructionData 
add CONSTRAINT fk_ID
foreign key (ID) references Description(ID);

Alter Table RawConstructionData add Construction_ID int;
UPDATE RawConstructionData
set Construction_ID = construction_elements.construction_id
FROM RawConstructionData INNER JOIN construction_elements ON RawConstructionData.ConstructionElementPart = construction_elements.construction_elem_part

Alter Table RawConstructionData
drop column Construction_Element_Family, ConstructionElementPart,Construction_Element_Type

Alter Table RawConstructionData 
ADD CONSTRAINT FK_Construction_ID
FOREIGN KEY (Construction_ID) REFERENCES Construction_Elements(construction_ID);

alter table Scope
alter column FloorID nvarchar(50)

Alter Table Scope 
ADD CONSTRAINT FK_FloorID
FOREIGN KEY (FloorID) REFERENCES Floor(FloorID);

alter table Scope
alter column TradeID nvarchar(50)

Alter Table Scope 
ADD CONSTRAINT FK_TradeID
FOREIGN KEY (TradeID) REFERENCES Trade(Trade);

alter table Scope
alter column BuildingID nvarchar(50)

Alter Table Scope 
ADD CONSTRAINT FK_BuildingID
FOREIGN KEY (BuildingID) REFERENCES Building(BuildingID);

alter table Schedule
add BOQ_id int 
--epitrofi
UPDATE Schedule
set BOQ_id = Scope.Scope_id
FROM RawConstructionData INNER JOIN Scope ON RawConstructionData.Scope = Scope.ScopeID


INSERT BOQ(BOQ,BOQ_Category,BOQ_Description,Unit_Price,Unit)
SELECT DISTINCT BOQ,BOQCategory,BOQDescription,UnitPrice,Unit FROM RawConstructionData
alter table BOQ ALTER COLUMN unit varchar(32) null

select DISTINCT BOQ, UnitPrice
from RawConstructionData

ALTER TABLE RawconstructionData add BOQ_ID int
select * from RawConstructionData


UPDATE RawConstructionData
set RawConstructionData.BOQ_ID = BOQ.BOQ_id
FROM RawConstructionData INNER JOIN BOQ ON RawConstructionData.BOQ = BOQ.BOQ

ALTER TABLE RawconstructionData drop column BOQCATEGORY,BOQ,BOQDESCRIPTION,UNIT,UNITPRICE
ALTER TABLE RawconstructionData drop column Scope_ELementType_BOQ

Alter Table RawconstructionData
ADD CONSTRAINT FK_BOQ_ID
FOREIGN KEY (BOQ_ID) REFERENCES BOQ(BOQ_ID);



INSERT Description(ID,Length,Thickness,Height,X,Y,Z)
SELECT DISTINCT ID,Length,Thickness,Height,X,Y,Z FROM RawConstructionData
alter table Description ALTER COLUMN Height float null

SELECT*From RawConstructionData

Alter Table RawConstructionData add Desc_ID int
SELECT*From RawConstructionData

Alter Table RawconstructionData
ADD CONSTRAINT FK_Desc_Id
FOREIGN KEY (Desc_Id) REFERENCES Description(Desc_Id);


UPDATE RawConstructionData
set RawConstructionData.Desc_Id = DESCRIPTION.Desc_Id
FROM RawConstructionData INNER JOIN Description ON RawConstructionData.ID = Description.ID

alter table rawConstructionData drop column ID,Length,Thickness,Height,X,Y,Z

SELECT*From Scope
SELECT*From Schedule

alter table schedule add Scope_ID int
UPDATE Schedule
set Scope_ID = Scope.Scope_id
FROM Schedule INNER JOIN Scope ON Schedule.Scope = Scope.Scope


alter table scope add Scope varchar(50) 
update Scope
Set scope = BuildingID +'_' + FloorID + '_' +TradeID


alter table schedule drop column Scope
alter table scope drop column Scope

Alter Table Schedule
ADD CONSTRAINT FK_Scope_ID
FOREIGN KEY (Scope_ID) REFERENCES Scope(Scope_ID);

select*from schedule
UPDATE Schedule
set BOQ_ID = BOQ.BOQ_id
FROM Schedule INNER JOIN BOQ ON Schedule.boq = BOQ.BOQ

create table Construction_elements_types(
con_elem_id int identity(1,1) not null primary key,
construction_elem_type varchar(max),
construction_elem_family varchar(max))

select distinct Construction_elem_type from construction_elements
select*from Construction_elements_types

INSERT Construction_elements_types(construction_elem_type,construction_elem_family  )
SELECT DISTINCT construction_elem_type,construction_elem_family  FROM construction_elements

create table Construction_elements_families(
con_fam_id int identity(1,1) not null primary key,
construction_elem_family varchar(max))

INSERT Construction_elements_families (Construction_elem_family )
SELECT DISTINCT construction_elem_family  FROM Construction_elements_types

alter table Construction_elements_types add con_fam_id int
UPDATE Construction_elements_types
set con_fam_id = Construction_elements_families.con_fam_id
FROM Construction_elements_types INNER JOIN Construction_elements_families ON Construction_elements_types.construction_elem_family = Construction_elements_families.construction_elem_family
select * from Construction_elements_types
alter table Construction_elements_types drop column construction_elem_family
Alter Table Construction_elements_types
ADD CONSTRAINT FK_con_fam_id
FOREIGN KEY (con_fam_id) REFERENCES Construction_elements_families(con_fam_id);

select * from Construction_elements_types

alter table Construction_elements add con_elem_id int
UPDATE Construction_elements
set con_elem_id = Construction_elements_types.con_elem_id
FROM Construction_elements INNER JOIN Construction_elements_types ON Construction_elements.construction_elem_type = Construction_elements_types.construction_elem_type
Alter Table Construction_elements
ADD CONSTRAINT FK_con_elem_id
FOREIGN KEY (con_elem_id) REFERENCES Construction_elements_types(con_elem_id);
alter table Construction_elements drop column construction_elem_family, construction_elem_type
select * from Construction_elements

alter table Schedule add con_elem_id int
UPDATE Schedule
set con_elem_id = Construction_elements_types.con_elem_id
FROM Schedule INNER JOIN Construction_elements_types ON Schedule.ConstructionElementType = Construction_elements_types.construction_elem_type
select * from Schedule

Alter Table Schedule
ADD CONSTRAINT FK_con_elem_id
FOREIGN KEY (con_elem_id) REFERENCES Construction_elements_types(con_elem_id);


UPDATE Schedule
SET	ConstructionElementType = 'Earth Work'
FROM Schedule
WHERE ConstructionElementType = 'Earthwork'


alter table Rawconstructiondata add Scope_ElementType_BOQ nvarchar(100)
UPDATE Rawconstructiondata
set Scope_ElementType_BOQ = Rawconstructiondata1.Scope_ElementType_BOQ
FROM Rawconstructiondata INNER JOIN Rawconstructiondata1 ON Rawconstructiondata.RCID = Rawconstructiondata1.rcid


alter table Schedule1 add sid int identity(1,1) primary key 

UPDATE Schedule
set Scope_ConstructionElementType_BOQ = Schedule1.Scope_ConstructionElementType_BOQ
FROM Schedule INNER JOIN Schedule1 ON Schedule.sid = Schedule1.sid

select distinct Scope_ElementType_BOQ from RawConstructionData
select distinct Scope_ConstructionElementType_BOQ from Schedule

select distinct Scope_ElementType_BOQ from RawConstructionData
where Scope_ElementType_BOQ like (select distinct Scope_ConstructionElementType_BOQ from Schedule)

select * FROM RawConstructionData
where Scope_ElementType_BOQ not in (
          select distinct Scope_ConstructionElementType_BOQ
          from Schedule)


select  X from dbo.description



alter table Rawconstructiondata add X float, Y float, Z float, Length float, Thickness float, Height float, ID int



set Scope_ElementType_BOQ = Schedule.Scope_ConstructionElementType_BOQ


Scope_ElementType_BOQ
Scope_ConstructionElementType_BOQ
drop table Description


Alter Table Rawconstructiondata
ADD CONSTRAINT FK_Scope_ElementType_BOQ
FOREIGN KEY (Scope_ElementType_BOQ) REFERENCES  Schedule(Scope_ConstructionElementType_BOQ)


alter table Schedule
drop constrain PK_SID;


Alter table rawconstructionData
ADD CONSTRAINT PK_Scope_Element_Type_BOQ
ALTER TABLE rawconstructionData ADD PRIMARY KEY (RCID, Scope_Element_Type_BOQ);

Alter table Schedule add primary key (SID, Scope_constructionElementType_BOQ)


ADD CONSTRAINT Scope_constructionElementType_BOQ UNIQUE (Scope_constructionElementType_BOQ)

-------Paradeigma syndeshs---
select Cost_Overrrun
from RawConstructionData a join Schedule b on a.Scope_ElementType_BOQ = b.Scope_ConstructionElementType_BOQ
where quantity = 0.308

select quantity from RawConstructionData