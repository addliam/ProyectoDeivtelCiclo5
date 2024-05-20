-- 3. Indices
-- Nomenclatura: IX_MyTable_MyColumn_AnotherColumn 
USE DataGenius
GO
CREATE NONCLUSTERED INDEX IX_DocumentoIdentidad_Numero ON
[dbo].[DocumentoIdentidad](Numero);
GO
CREATE NONCLUSTERED INDEX IX_Usuario_Correo ON
[dbo].[Usuario](Correo);
GO
CREATE NONCLUSTERED INDEX IX_Usuario_Nombre ON
[dbo].[CicloFacturacion](Nombre);
GO
CREATE NONCLUSTERED INDEX IX_Celular_Numero ON
[dbo].[Celular](Numero);
GO