Public Class tableroVacios
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Session("ano") = Now.Year
            Session("mes") = Now.Month
        End If
    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click
        Session("ano") = txbAno.Text
        Session("mes") = ddlMes.SelectedValue
        Response.Redirect("tableroVacios.aspx")
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Session("ano") = txbAno.Text
        Session("mes") = ddlMes.SelectedValue
        Response.Redirect("tableroVacios.aspx")
    End Sub
End Class