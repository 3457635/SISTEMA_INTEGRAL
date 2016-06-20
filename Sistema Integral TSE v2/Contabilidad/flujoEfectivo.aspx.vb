Public Class flujoEfectivo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year()
        End If
    End Sub

End Class