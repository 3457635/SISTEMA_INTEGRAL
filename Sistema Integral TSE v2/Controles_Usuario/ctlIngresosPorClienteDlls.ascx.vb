Public Class ctlIngresosPorClienteDlls
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year.ToString()
            total()
            ddlMes.SelectedValue = Now.AddHours(-7).Month
            Chart1.DataBind()
            total()
            total_ano()
        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Chart1.DataBind()
        total()
        total_ano()
    End Sub
    Protected Sub total()
        Dim tot = (From consulta In db.fechas_facturacions
                             Where consulta.factura.total IsNot Nothing And
                             consulta.fecha.fecha.Value.Month = ddlMes.SelectedValue And
            consulta.fecha.fecha.Value.Year = txbAno.Text And
                            consulta.fecha.tipo_fecha = 7 And
                            consulta.factura.Cancelada = False And
                            consulta.factura.facturada_dolares = True
                             Select consulta.factura.total).Sum()
        If Not tot Is Nothing Then
            lblTotal.Text = String.Format("{0:c0}", tot)
        End If
    End Sub
    Protected Sub total_ano()
        Dim tot = (From consulta In db.fechas_facturacions
                             Where consulta.factura.total IsNot Nothing And
        consulta.fecha.fecha.Value.Year = txbAno.Text And
                        consulta.fecha.tipo_fecha = 7 And
                        consulta.factura.Cancelada = False And
                        consulta.factura.facturada_dolares = True
                             Select consulta.factura.total).Sum()
        If Not tot Is Nothing Then
            lblAno.Text = String.Format("{0:c0}", tot)
        End If
    End Sub
End Class