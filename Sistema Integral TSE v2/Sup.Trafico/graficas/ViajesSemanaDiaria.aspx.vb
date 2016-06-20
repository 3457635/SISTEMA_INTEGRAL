Public Class ViajesSemanaDiaria
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
                If Session("cliente") <> "0" Then

                    ddlCliente.SelectedValue = Session("cliente")
                End If
            End If
        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Session("ano") = txbAno.Text
        Session("mes") = ddlMes.SelectedValue
        Session("cliente") = ddlCliente.SelectedValue
        Response.Redirect("~/sup.trafico/graficas/ViajesSemanaDiaria.aspx")
    End Sub

    Protected Sub ddlCliente_DataBound(sender As Object, e As EventArgs) Handles ddlCliente.DataBound
        Dim SelectItem As ListItem = New ListItem("Todos...", 0)
        ddlCliente.Items.Insert(0, SelectItem)
        If (String.IsNullOrEmpty(Session("cliente")) Or Session("cliente") = "0") Then
            ddlCliente.SelectedValue = 0
        End If
    End Sub

    Private Sub ViajesSemanaDiaria_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        If String.IsNullOrEmpty(Session("pantalla")) Or Session("pantalla") <> "viajesSemanal" Then
            Session("pantalla") = "viajesSemanal"
            Session("ano") = Nothing
            Session("mes") = Nothing
            Session("cliente") = Nothing
        End If
    End Sub
End Class