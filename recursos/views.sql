CREATE VIEW v_PermisoDetalle
AS
SELECT P.PermisoID
      ,O.Nombre AS Operacion
      ,RO.Nombre AS Rol
      ,RE.Nombre AS Recurso
  FROM Permiso P
  JOIN Operacion O ON O.OperacionID=P.OperacionID
  JOIN Rol RO ON RO.RolID = P.RolID
  JOIN Recurso RE ON RE.RecursoID = P.RecursoID
GO

CREATE VIEW v_PlanProductoDetalle
AS
SELECT DP.DetallePlanID,
PL.Nombre 'Plan',
PL.PrecioCalculado 'Plan precio',
PR.Nombre 'Producto',
PR.Precio 'Producto precio'
FROM DetallePlan DP
JOIN PlanSuscripcion PL ON PL.PlanSuscripcionID=DP.PlanSuscripcionID
JOIN Producto PR ON PR.ProductoID=DP.ProductoID
GO

CREATE VIEW v_SuscripcionDetalle
AS
SELECT SU.SuscripcionID,
TDOC.Nombre Documento,
DI.Numero NumeroDocumento,
CONCAT(CL.Nombre,' ',CL.ApPaterno,' ',CL.ApMaterno) Cliente,
PL.Nombre PlanNombre,
PL.PrecioCalculado Precio,
DIR.Nombre Direccion,
CF.Nombre CicloFacturacion,
SU.FechaVenta,
SU.FechaInstalacion
FROM Suscripcion SU
JOIN DocumentoIdentidad DI ON DI.DocumentoIdentidadID = SU.DocumentoIdentidadID
JOIN Cliente CL ON CL.ClienteID = DI.ClienteID
JOIN TipoDocumentoIdentidad TDOC ON TDOC.TipoDocumentoIdentidadID=DI.TipoDocumentoIdentidadID
JOIN PlanSuscripcion PL ON PL.PlanSuscripcionID = SU.PlanSuscripcionID
JOIN Direccion DIR ON DIR.DireccionID = SU.DireccionID
JOIN CicloFacturacion CF ON CF.CicloFacturacionID = SU.CicloFacturacionID
GO 

CREATE VIEW v_AuditoriaDetalle
AS
SELECT AU.AuditoriaID, 
AU.FechaHora, 
OP.Nombre Operacion,
CONCAT(US.Nombre,' ',US.ApPaterno,' ',US.ApMaterno) Usuario,
AU.NombreTabla,
AU.IDTabla,
AU.Descripcion
FROM Auditoria AU
JOIN Operacion OP ON OP.OperacionID = AU.OperacionID
JOIN Usuario US ON US.UsuarioID = AU.UsuarioID
GO

CREATE VIEW v_ComunicacionDetalle AS
SELECT CO.ComunicacionID, 
CONCAT(CL.Nombre,' ',CL.ApPaterno,' ',CL.ApMaterno) Cliente,
CL.Correo Correo, 
TC.Nombre TipoComunicacion,
CO.Mensaje,
CO.FechaHora
FROM Comunicacion CO
JOIN TipoComunicacion TC ON TC.TipoComunicacionID = CO.TipoComunicacionID
JOIN Suscripcion SU ON SU.SuscripcionID = CO.SuscripcionID
JOIN DocumentoIdentidad DI ON DI.DocumentoIdentidadID = SU.DocumentoIdentidadID
JOIN Cliente CL ON CL.ClienteID = DI.ClienteID
GO

CREATE VIEW v_BitacoraAtencionDetalle
AS
SELECT BA.BitacoraAtencionID, 
BA.SuscripcionID, 
CBA.Nombre Categoria,
BA.Detalle,
CONCAT(US.Nombre,' ',US.ApPaterno,' ',US.ApMaterno) Usuario
FROM BitacoraAtencion BA
JOIN Usuario US ON US.UsuarioID = BA.UsuarioID
JOIN CategoriaBitacoraAtencion CBA ON CBA.CategoriaBitacoraAtencionID = BA.CategoriaBitacoraID
GO

CREATE VIEW v_UsuarioDetalle
AS
SELECT US.UsuarioID, 
CONCAT(US.Nombre,' ',US.ApPaterno,' ',US.ApMaterno) Usuario,
US.Correo,
RO.Nombre Rol,
Estado = CASE WHEN EUS.Activo = 1 THEN 'Activo' ELSE 'Inactivo' END
FROM Usuario US
JOIN UsuarioRol UR ON UR.UsuarioID = US.UsuarioID
JOIN Rol RO ON RO.RolID = UR.RolID
LEFT JOIN EstadoUsuario EUS ON EUS.UsuarioID = US.UsuarioID
GO

CREATE VIEW v_DireccionDetalle
AS
SELECT DIR.DireccionID,
DIR.Nombre,
DIR.Referencia,
DIS.Nombre Distrito,
PROV.Nombre Provincia,
DEP.Nombre Departamento
FROM Direccion DIR
JOIN Distrito DIS ON DIS.DistritoID = DIR.DistritoID
JOIN Provincia PROV ON PROV.ProvinciaID = DIS.ProvinciaID
JOIN Departamento DEP ON DEP.DepartamentoID = PROV.DepartamentoID
GO

CREATE VIEW v_DetalleRouter
AS
SELECT * FROM DetalleRouter
GO