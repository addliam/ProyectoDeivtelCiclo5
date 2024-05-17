CREATE VIEW v_PermisoDetalle
AS
SELECT P.[PermisoID]
      ,O.Nombre AS Operacion
      ,RO.Nombre AS Rol
      ,RE.Nombre AS Recurso
  FROM [DataGenius].[dbo].[Permiso] P
  JOIN Operacion O ON O.OperacionID=P.OperacionID
  JOIN Rol RO ON RO.RolID = P.RolID
  JOIN Recurso RE ON RE.RecursoID = P.RecursoID
GO

CREATE VIEW v_DetallePlanProducto
AS
SELECT DP.DetallePlanID,
PL.Nombre 'Plan',
PL.PrecioCalculado 'Plan precio',
PR.Nombre 'Producto',
PR.Precio 'Producto precio'
FROM DetallePlan DP
JOIN [dbo].[PlanSuscripcion] PL ON PL.PlanSuscripcionID=DP.PlanSuscripcionID
JOIN [dbo].[Producto] PR ON PR.ProductoID=DP.ProductoID
GO

CREATE VIEW v_SuscripcionDetalle
AS
SELECT SU.SuscripcionID,
TDOC.Nombre Documento,
DI.Numero NumeroDocumento,
CONCAT(CL.Nombre, CL.ApPaterno, CL.ApMaterno) Cliente,
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

CREATE VIEW v_AuditoriaDetalle
AS
SELECT AU.AuditoriaID, 
AU.FechaHora, 
OP.Nombre,
CONCAT(US.Nombre, US.ApPaterno, US.ApMaterno) Usuario,
AU.NombreTabla,
AU.IDTabla,
AU.Descripcion
FROM Auditoria AU
JOIN Operacion OP ON OP.OperacionID = AU.OperacionID
JOIN Usuario US ON US.UsuarioID = AU.UsuarioID