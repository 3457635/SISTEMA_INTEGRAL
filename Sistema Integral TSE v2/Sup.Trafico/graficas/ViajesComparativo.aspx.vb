Public Class ViajesComparativo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Session("ano")) Then
                txbAno.Text = Now.Year
                Session("ano") = txbAno.Text
            Else
                txbAno.Text = Session("ano")
            End If
        End If
        If Roles.IsUserInRole("Contabilidad") Then
            ChartIngresosPorCliente.Visible = True
        Else
            ChartIngresosPorCliente.Visible = False

        End If
    End Sub

    Private Sub ViajesComparativo_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        If String.IsNullOrEmpty(Session("pantalla")) Or Session("pantalla") <> "viajesComparativo" Then
            Session("pantalla") = "viajesComparativo"
            Session("ano") = Nothing
            Session("mes") = Nothing
            Session("cliente") = Nothing
        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Session("ano") = txbAno.Text
        Response.Redirect("~/sup.trafico/graficas/ViajesComparativo.aspx")
    End Sub
End Class