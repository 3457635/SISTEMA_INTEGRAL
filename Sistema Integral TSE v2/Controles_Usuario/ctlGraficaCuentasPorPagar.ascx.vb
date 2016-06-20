Public Class ctlGraficaCuentasPorPagar
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            actualizarGrafica(Now.AddHours(-7).Year)
            txbAno.Text = Now.AddHours(-7).Year
            txbTC.Text = 13
        End If
    End Sub
    Protected Sub actualizarGrafica(ByVal ano As Integer)
        sdsCuentasPorPagarAnoAnterior.SelectParameters(1).DefaultValue = ano - 1
        sdsMesAnterior.SelectParameters(1).DefaultValue = ano - 1
        lblAnoActual.Text = ano
        lblAnoAnterior.Text = ano - 1
        lblAnoActualVencido.Text = ano
        lblMesActual.Text = ano
        lblMesAnterior.Text = ano - 1
    End Sub
    Protected Sub ibtnActualizar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ibtnActualizar.Click
        actualizarGrafica(txbAno.Text)
    End Sub
End Class