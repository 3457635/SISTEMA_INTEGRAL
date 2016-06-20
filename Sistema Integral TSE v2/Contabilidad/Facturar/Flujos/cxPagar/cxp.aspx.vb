Public Class cxp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fecha_inicio = Request("fecha_inicio")
        Dim fecha_fin = Request("fecha_fin")
        Dim tipo_query = Request("tipo_query")
        Dim db As New DataClasses1DataContext()

        Dim facturas = (From consulta In db.proveedores_pagos, consulta2 In db.gastos, consulta3 In db.comprobantes_fiscales
                       Where consulta.fecha_programacion_pago >= fecha_inicio And
                       consulta.fecha_programacion_pago <= fecha_fin And
        consulta.id_gasto = consulta2.id_gasto And
        consulta2.id_gasto = consulta3.id_gasto
                       Select FACTURA = consulta3.folio,
                       PROVEEDOR = consulta.empresa.nombre,
                       DESCRIPCION = consulta2.descripcion,
                       IMPORTE = consulta2.cantidad,
                       fecha = consulta.fecha_programacion_pago).OrderByDescending(Function(x) x.fecha)

        GridView1.DataSource = facturas
        GridView1.DataBind()

    End Sub

End Class