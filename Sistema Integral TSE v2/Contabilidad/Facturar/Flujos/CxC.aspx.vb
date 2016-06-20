Public Class CxC
    Inherits System.Web.UI.Page
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim fecha_inicio = Request.Params("fecha_inicio")
        Dim fecha_fin = Request.Params("fecha_fin")
        Dim tipo_query = Request.Params("tipo_query")
        Dim db As New DataClasses1DataContext()

        If tipo_query = "1" Then
            Dim cuentasxcobrarMN = From consulta In db.fechas_facturacions
            Where (consulta.factura.importe IsNot Nothing And
            consulta.fecha.fecha >= fecha_inicio And
            consulta.fecha.fecha <= fecha_fin And
            consulta.fecha.tipo_fecha = 6 And
            consulta.factura.Cancelada = False And
            consulta.factura.facturada_dolares = False And
            Not (From consulta2 In db.fechas_facturacions
            Where (consulta2.fecha.tipo_fecha = 7)
             Select consulta2.id_factura).Contains(consulta.id_factura))
                                                   Select consulta.factura.folio,
                                                   consulta.factura.importe,
                                                   consulta.id_factura
            grd.DataSource = cuentasxcobrarMN
            grd.DataBind()
        Else
            Dim cuentasxcobrarMN = From consulta In db.fechas_facturacions
                         Where consulta.factura.importe IsNot Nothing And
                         consulta.fecha.fecha >= fecha_inicio And
                         consulta.fecha.fecha <= fecha_fin And
                         consulta.fecha.tipo_fecha = 7 And
                         consulta.factura.facturada_dolares = False
                         Select consulta.factura.folio,
                                                   consulta.factura.importe,
                                                   consulta.id_factura
            grd.DataSource = cuentasxcobrarMN
            grd.DataBind()
        End If

        



    End Sub
    Public Sub llenar_grid(ByVal tipo_query, ByVal fecha_inicio, ByVal fecha_fin)
        
    End Sub

    Protected Sub grd_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grd.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim grid As GridView = CType(e.Row.FindControl("Gridview1"), GridView)
            Dim s As SqlDataSource = CType(e.Row.FindControl("SqlDataSource1"), SqlDataSource)

            s.SelectParameters(0).DefaultValue = e.Row.Cells(0).Text

        End If
    End Sub
End Class