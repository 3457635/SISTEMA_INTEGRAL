Public Class ViajesAnuales
    Inherits System.Web.UI.Page

    Private Sub ViajesAnuales_Disposed(sender As Object, e As EventArgs) Handles Me.Disposed
        
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Session("ano")) Then
                txbAno.Text = Now.Year
                Session("ano") = txbAno.Text
                

            Else
                txbAno.Text = Session("ano")
                If Session("cliente") <> "0" Then
                    ddlCliente.SelectedValue = Session("cliente")
                Else
                    ddlCliente.SelectedValue = Nothing
                End If
               
            End If
        End If
        If Roles.IsUserInRole("Contabilidad") Then
            chrIngresos.Visible = True
        Else
            chrIngresos.Visible = False

        End If
    End Sub

    Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs) Handles ImageButton1.Click
        Session("ano") = txbAno.Text
        Session("cliente") = ddlCliente.SelectedValue
        Response.Redirect("~/sup.trafico/graficas/ViajesAnuales.aspx")
    End Sub

    Protected Sub ddlCliente_DataBound(sender As Object, e As EventArgs) Handles ddlCliente.DataBound
        Dim SelectItem As ListItem = New ListItem("Todos...", 0)
        ddlCliente.Items.Insert(0, SelectItem)
        If (String.IsNullOrEmpty(Session("cliente")) Or Session("cliente") = "0") Then
            ddlCliente.SelectedValue = 0
        End If

    End Sub

    Private Sub ViajesAnuales_PreLoad(sender As Object, e As EventArgs) Handles Me.PreLoad
        If String.IsNullOrEmpty(Session("pantalla")) Or Session("pantalla") <> "viajesAnual" Then
            Session("pantalla") = "viajesAnual"
            Session("ano") = Nothing
            Session("mes") = Nothing
            Session("cliente") = Nothing
        End If
    End Sub

    
    Private Sub ViajesAnuales_Unload(sender As Object, e As EventArgs) Handles Me.Unload
        
    End Sub
End Class