Public Class ctlGraficaRendimientoPorCliente
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlMes.SelectedValue = Now.AddHours(-7).Month()
            txbAno.Text = Now.AddHours(-7).Year()

        End If
    End Sub

End Class