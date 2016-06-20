Public Class ctlGraficaCarteraVencida
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAnoCartera.Text = Now.AddHours(-7).Year()
            ddlMesCartera.SelectedValue = Now.AddHours(-7).Month()
            cargarGrafica()
        End If
    End Sub
    Protected Sub cargarGrafica()
        Dim ano = txbAnoCartera.Text
        Dim mes = ddlMesCartera.SelectedValue
        Dim cliente = ddlClienteCartera.SelectedValue
        Dim moneda = rdbMoneda.SelectedValue


        SqlDataSource1.SelectParameters(0).DefaultValue = cliente
        SqlDataSource1.SelectParameters(1).DefaultValue = ano
        SqlDataSource1.SelectParameters(2).DefaultValue = mes
        SqlDataSource1.SelectParameters(3).DefaultValue = moneda
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        cargarGrafica()
    End Sub

    Protected Sub ddlCliente_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlClienteCartera.DataBound
        ddlClienteCartera.Items.Add(Crear_item("Todos..", 0))
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        chtCarteraVencida.Width = txbAncho.Text
        chtCarteraVencida.Height = txbAlto.Text
        chtCarteraVencida.DataBind()
    End Sub
End Class