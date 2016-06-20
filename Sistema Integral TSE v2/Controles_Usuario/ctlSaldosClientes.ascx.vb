Public Class ctlSaldosClientes
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            total()
        End If
    End Sub

    Protected Sub Chart1_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles Chart1.DataBound
        Chart1.Series(0).Sort(pointSortOrder:=DataVisualization.Charting.PointSortOrder.Ascending)
        total()
    End Sub
    Protected Sub total()
        Dim cuentasxcobrarMN = (From consulta In db.fechas_facturacions
                             Where (consulta.factura.total IsNot Nothing And
                             consulta.fecha.tipo_fecha = 6 And
                             consulta.factura.Cancelada = False And
                             consulta.factura.facturada_dolares = False And
                             Not (From consulta2 In db.fechas_facturacions
                             Where (consulta2.fecha.tipo_fecha = 7)
                              Select consulta2.id_factura).Contains(consulta.id_factura))
                             Select consulta.factura.importe).Sum()
        If Not cuentasxcobrarMN Is Nothing Then
            lblTotal.Text = String.Format("{0:c0}", cuentasxcobrarMN)
        End If

    End Sub
End Class