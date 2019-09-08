CREATE DATABASE ExamenVenta

use ExamenVenta


create table Usuario(
idusuario int primary key AUTO_INCREMENT ,
nombre varchar(50) not null,
email varchar(50) not null,	
password varchar(20) not null			
);

insert into Usuario (nombre,email,password) values('Cristian Perez', 'cristian@gmail.com','123');

select * from Usuario

create table Cliente(
CliRut int primary key,
CliNombre varchar(50)not null,
CliApellido varchar(50)not null,
CliFechaIngreso datetime DEFAULT NOW() not null,
CliDireccion varchar(50)not null,
CliGiro varchar(50)not null,
CliFono varchar(10)not null
);

insert into Cliente(CliRut,CliNombre,CliApellido,CliDireccion,CliGiro,CliFono) values(14785421,'Juan','Perez','Republica','Supermercado','88557744');
insert into Cliente(CliRut,CliNombre,CliApellido,
CliDireccion,CliGiro,CliFono) values(14785422,'Pablo','Valdivia','Ramirez 445','Mayorista','88557755');

create table TipoVenta(
VenTipo int primary key AUTO_INCREMENT,
nombre varchar(50)not null
);
 insert into TipoVenta(nombre)values('Boleta');
 insert into TipoVenta(nombre)values('Factura');

create table Venta(
idVenta int primary key AUTO_INCREMENT ,
VenFolio int not null,
VenFecha date not null,
VenTipo int not null,
CliRut int not null,
CONSTRAINT `FK_VEN_TIPO` FOREIGN KEY (VenTipo) REFERENCES TipoVenta(VenTipo),
CONSTRAINT `FK_VEN_CLIENTE` FOREIGN KEY (CliRut) REFERENCES Cliente (CliRut)
);

insert into Venta (VenFolio,VenFecha,VenTipo,CliRut) values(123456,'2019-09-07',1,14785421);


select * from Venta

create table Producto(
ProCodigo int primary key AUTO_INCREMENT,
ProCodigoBarra int not null,
ProNombre varchar(50)not null,
ProMarca varchar(20)not null,
ProPrecio int not null
);

insert into Producto(ProCodigoBarra,ProNombre,ProMarca,ProPrecio) values (12345678,'Arroz','Luchetti',1000);

create table DetalleVenta(
idDetalleVenta int primary key AUTO_INCREMENT,
idVenta int not null,
VenTipo int not null,
ProCodigo int not null,
VenCantidad int not null,
VenPrecioReal int not null,
VenPrecioVenta int not null,
CONSTRAINT `FK_VENTA` FOREIGN KEY (idVenta) REFERENCES Venta (idVenta),
CONSTRAINT `FK_TIPO_DETALLE` FOREIGN KEY (VenTipo) REFERENCES TipoVenta(VenTipo),
CONSTRAINT `FK_DETALLE_PRO` FOREIGN KEY (ProCodigo) REFERENCES Producto(ProCodigo)
);

alter table DetalleVenta
add column VenDescuento decimal default 0 


alter table DetalleVenta
add CHECK (VenDescuento>=0 and VenDescuento<=20)


insert into DetalleVenta(idVenta,VenTipo,ProCodigo,VenCantidad,VenPrecioReal,VenPrecioVenta) values (1,1,1,2,1000,2000);
insert into DetalleVenta(idVenta,VenTipo,ProCodigo,VenCantidad,VenPrecioReal,VenPrecioVenta) values (1,1,1,2,1000,2000);


        select 
            Venta.VenFolio as Folio,
            TipoVenta.nombre as Tipo, 
            Venta.VenFecha as Fecha,
            Cliente.CliRut as 'Rut Cliente',
            concat_ws(' ',Cliente.CliNombre ,Cliente.CliApellido ) as 'Nombre Cliente',
            DetalleVenta.VenPrecioVenta as Total
          from Venta
            inner join Cliente on Cliente.CliRut=Venta.CliRut
            inner join DetalleVenta on Venta.idVenta=DetalleVenta.idVenta
            inner join TipoVenta on Venta.VenTipo=TiPoVenta.VenTipo
        
select * from DetalleVenta

select TiPoVenta.VenTipo from TipoVenta


      select 
            DetalleVenta.VenCantidad as Cantidad,
            concat_ws(' ', Producto.ProNombre ,ProMarca ) as Producto,
            DetalleVenta.VenPrecioReal as Unitario,
            (DetalleVenta.VenPrecioVenta * 0.19  + DetalleVenta.VenPrecioVenta) as Total,
            DetalleVenta.idDetalleVenta
          from Venta
            inner join Cliente on Cliente.CliRut=Venta.CliRut
            inner join DetalleVenta on Venta.idVenta=DetalleVenta.idVenta
            inner join TipoVenta on Venta.VenTipo=TiPoVenta.VenTipo
            inner join Producto on DetalleVenta.ProCodigo=Producto.ProCodigo
            
            
            select 
                  Producto.ProCodigo,
                  concat_ws(' ', Producto.ProNombre ,ProMarca ) as Producto 
                  FROM Producto
                
            
          select 
            DetalleVenta.VenPrecioReal as Unitario,
            (DetalleVenta.VenPrecioVenta * 0.19 ) as IVA,
            (DetalleVenta.VenPrecioVenta * 0.19  + DetalleVenta.VenPrecioVenta) as Total
            from Venta
            inner join DetalleVenta on Venta.idVenta=DetalleVenta.idVenta
