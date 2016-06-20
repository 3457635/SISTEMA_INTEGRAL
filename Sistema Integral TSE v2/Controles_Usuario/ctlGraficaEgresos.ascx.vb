Public Class ctlGraficaEgresos
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            SqlDataSource2.SelectParameters(0).DefaultValue = Now.AddHours(-7).Year()
        End If
    End Sub

End Class