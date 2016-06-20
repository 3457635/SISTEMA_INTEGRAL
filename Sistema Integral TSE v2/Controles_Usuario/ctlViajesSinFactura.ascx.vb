Public Class ctlViajesSinFactura
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnLimpiar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnLimpiar.Click
        sdsViajes.SelectParameters(1).DefaultValue = "0"
    End Sub

    Protected Sub btnConsultar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConsultar.Click
        sdsViajes.SelectParameters(0).DefaultValue = 13
        sdsViajes.SelectParameters(1).DefaultValue = "Viajes"
        sdsViajes.SelectParameters(2).DefaultValue = ddlRango.SelectedValue
        sdsViajes.SelectParameters(3).DefaultValue = "Sin Facturar"
        grdDetalle.PageIndex = 0

    End Sub
End Class