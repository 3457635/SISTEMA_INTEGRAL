Public Class usoEquipo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click
        sdsUtilizacionEquipo.SelectParameters(0).DefaultValue = txbInicio.Text
        sdsUtilizacionEquipo.SelectParameters(1).DefaultValue = ddlVehiculo.SelectedValue
        sdsUtilizacionEquipo.SelectParameters(2).DefaultValue = RadioButtonList1.SelectedValue
    End Sub
End Class