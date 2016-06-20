Public Class ctlGraficaCartera
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txbAno.Text = Now.AddHours(-7).Year()
            ddlMes.SelectedValue = Now.AddHours(-7).Month()
            cargarGrafica()
        End If
        ajustarTamano()
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        cargarGrafica()
        UpdatePanel1.Update()
    End Sub

    
    Protected Sub ddlCliente_DataBound(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCliente.DataBound

        ddlCliente.Items.Add(Crear_item("Todos..", 0))
    End Sub

    Protected Sub cargarGrafica()
        Dim ano = txbAno.Text
        Dim mes = ddlMes.SelectedValue
        Dim cliente = ddlCliente.SelectedValue
        Dim moneda = rdbMoneda.SelectedValue


        SqlDataSource1.SelectParameters(0).DefaultValue = cliente
        SqlDataSource1.SelectParameters(1).DefaultValue = ano
        SqlDataSource1.SelectParameters(2).DefaultValue = mes
        SqlDataSource1.SelectParameters(3).DefaultValue = moneda
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click

    End Sub

    Private Sub ajustarTamano()

        If Not String.IsNullOrEmpty(txbAncho.Text) And Not String.IsNullOrEmpty(txbAlto.Text) Then
            Chart1.Height = txbAlto.Text
            Chart1.Width = txbAncho.Text
            Chart1.DataBind()
        End If

    End Sub

End Class