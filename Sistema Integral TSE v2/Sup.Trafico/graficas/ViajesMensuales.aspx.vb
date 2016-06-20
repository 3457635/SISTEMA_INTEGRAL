Public Class ViajesMensuales
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Session("ano")) Then
                txbAno.Text = Now.Year
                Session("ano") = txbAno.Text
            Else
                txbAno.Text = Session("ano")
                If Session("cliente") <> "0" Then

                    ddlCliente.SelectedValue = Session("cliente")
                End If
            End If
        End If
        If Roles.IsUserInRole("Contabilidad") Then
            chrMesIngresos.Visible = True
        Else
            chrMesIngresos.Visible = False


        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Session("ano") = txbAno.Text
        Session("cliente") = ddlCliente.SelectedValue
        Response.Redirect("~/sup.trafico/graficas/ViajesMensuales.aspx")
    End Sub

    Protected Sub ddlCliente_DataBound(sender As Object, e As EventArgs) Handles ddlCliente.DataBound
        Dim SelectItem As ListItem = New ListItem("Todos...", 0)
        ddlCliente.Items.Insert(0, SelectItem)
        If (String.IsNullOrEmpty(Session("cliente")) Or Session("cliente") = "0") Then
            ddlCliente.SelectedValue = 0
        End If
    End Sub

    Private Sub ViajesMensuales_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        If String.IsNullOrEmpty(Session("pantalla")) Or Session("pantalla") <> "viajesMensual" Then
            Session("pantalla") = "viajesMensual"
            Session("ano") = Nothing
            Session("mes") = Nothing
            Session("cliente") = Nothing
        End If
    End Sub
End Class