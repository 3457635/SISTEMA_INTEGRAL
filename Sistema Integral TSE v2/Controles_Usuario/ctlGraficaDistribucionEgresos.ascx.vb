Public Class ctlGraficaDistribucionEgresos
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SqlDataSource3.SelectParameters(0).DefaultValue = Now.AddHours(-7).Month()
            SqlDataSource3.SelectParameters(1).DefaultValue = Now.AddHours(-7).Year()
            txbAno.Text = Now.AddHours(-7).Year
            ddlMes.SelectedValue = Now.AddHours(-7).Month
        End If
    End Sub

    Protected Sub ibtnActualizarDetalle_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizarDetalle.Click
        SqlDataSource3.SelectParameters(0).DefaultValue = ddlMes.SelectedValue
        SqlDataSource3.SelectParameters(1).DefaultValue = txbAno.Text
    End Sub
End Class