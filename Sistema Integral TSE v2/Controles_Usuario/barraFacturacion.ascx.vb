Public Class barraFacturacion
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub lnkInicio_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lnkInicio.Click
        Response.Redirect("~/login.aspx")
    End Sub
End Class