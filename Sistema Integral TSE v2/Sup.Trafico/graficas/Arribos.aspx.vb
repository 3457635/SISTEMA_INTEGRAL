Public Class Arrivos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Session("ano")) Then
                txbAno.Text = Now.Year
                ddlMes.SelectedValue = Now.Month
                Session("ano") = txbAno.Text
                Session("mes") = ddlMes.SelectedValue
            Else
                txbAno.Text = Session("ano")
                ddlMes.SelectedValue = Session("mes")
            End If
        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Session("ano") = txbAno.Text
        Session("mes") = ddlMes.SelectedValue

        Response.Redirect("~/sup.trafico/graficas/Arrivos.aspx")
    End Sub

    Private Sub Arrivos_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        If String.IsNullOrEmpty(Session("pantalla")) Or Session("pantalla") <> "viajesArrivos" Then
            Session("pantalla") = "viajesArrivos"
            Session("ano") = Nothing
            Session("mes") = Nothing
            Session("cliente") = Nothing
        End If
    End Sub
End Class