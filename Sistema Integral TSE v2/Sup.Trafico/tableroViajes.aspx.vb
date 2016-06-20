Public Class tableroViajes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlMes.SelectedValue = Now.Month()
            txbAno.Text = Now.Year()
        End If
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
      
    End Sub

   
    Protected Sub btnConsultar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnConsultar.Click
       
    End Sub

    Protected Sub ddlCliente_DataBound(sender As Object, e As EventArgs) Handles ddlCliente.DataBound
        ddlCliente.Items.Add(Crear_item("Todos...", 0))
        ddlCliente.SelectedValue = 0
    End Sub
End Class