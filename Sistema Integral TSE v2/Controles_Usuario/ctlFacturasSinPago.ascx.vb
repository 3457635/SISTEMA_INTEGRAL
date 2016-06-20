Public Class ctlFacturasSinPago
    Inherits System.Web.UI.UserControl
    Dim db As New DataClasses1DataContext()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnBuscar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscar.Click
        sdsFacturas.SelectParameters(0).DefaultValue = txbInicio.Text
        sdsFacturas.SelectParameters(1).DefaultValue = txbFin.Text
        sdsFacturas.SelectParameters(2).DefaultValue = RadioButtonList1.SelectedValue
        sdsFacturas.SelectParameters(3).DefaultValue = ddlCliente.SelectedValue



    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim folio = e.Row.Cells(0).Text
            Dim buscarFechaIngreso = (From consulta In db.fechas_facturacions
                                   Where consulta.factura.folio = folio And
                                   consulta.fecha.tipo_fecha = 7
                                   Select consulta).FirstOrDefault()

            Dim lblFecha As Label = CType(e.Row.FindControl("lblPago"), Label)

            If Not buscarFechaIngreso Is Nothing Then
                lblFecha.Text = buscarFechaIngreso.fecha.fecha
            End If


        End If
    End Sub

    Protected Sub btnBuscarLote_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnBuscarLote.Click
        Dim tipoConsulta = 3
        sdsFacturas.SelectParameters(2).DefaultValue = tipoConsulta
        sdsFacturas.SelectParameters(4).DefaultValue = txbLote.Text
    End Sub
End Class